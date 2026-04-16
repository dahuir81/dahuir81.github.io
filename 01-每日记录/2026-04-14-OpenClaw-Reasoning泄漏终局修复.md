---
created: 2026-04-14
tags: [OpenClaw, 运维, Reasoning泄漏, 钉钉插件, 排障]
---

# 2026-04-14 OpenClaw Reasoning 泄漏终局修复

## 背景

延续 4/13 的排障。钉钉收到 Tars 回复时，每次都会先出现一条独立的 "Reasoning:" 消息，内容是 AI 的思考过程。

4/13 已完成止血（关闭 fallback、清理 session、恢复 dist），但问题根源未彻底消除：
- 百炼 CodingPlan 端点默认总是返回 `reasoning_content`
- pi-ai 会拾取该字段并格式化成 `"Reasoning:\n_..._"` 文本块
- 钉钉插件的 `isReasoning` 一级防线失效（upstream 未标记）

## 今日走过的弯路

### 尝试一：`reasoning: false`（官方客服建议，无效）

在 `openclaw.json` bailian 模型中加 `"reasoning": false`。

**无效原因**：这只影响 OpenClaw 是否向 API 发送 `enable_thinking` 参数，不影响 pi-ai 接收端对 `reasoning_content` 字段的读取。百炼 CodingPlan 端点不管有没有被要求，默认就返回 reasoning_content。

### 尝试二：`reasoning: true + compat.thinkingFormat: "qwen"`（适得其反）

pi-ai 的 `openai-completions.js` 有这段逻辑：
```javascript
else if (compat.thinkingFormat === "qwen" && model.reasoning) {
    params.enable_thinking = !!options?.reasoningEffort;
    // reasoningEffort=undefined → enable_thinking: false → API 不返回 reasoning_content
}
```

理论上：`reasoning: true + thinkingFormat: "qwen"` 会让 pi-ai 发送 `enable_thinking: false`，从源头抑制。

实际上：OpenClaw 看到 `reasoning: true` 就认为该模型"支持 thinking"，新 session（`/new`）自动把 `thinkingLevel` 设成了 `"low"`，反而主动激活了 thinking，reasoning_content 更多地被返回。

**已还原**：qwen3.6-plus 回到 `"reasoning": false`，移除 compat。

## 真正的 Bug 与最终修复

### Bug 定位

文件：`/Users/dahuir/GitHub/openclaw-channel-dingtalk/src/reply-strategy-markdown.ts`

流程：
1. 百炼返回 `reasoning_content` → pi-ai 格式化成 `"Reasoning:\n_..._"` 文本块
2. `payload.isReasoning === true` → false（upstream 未标记），一级过滤失效
3. `looksLikeReasoning(payload.text)` → "Reasoning:" 开头不匹配英文短语正则，三级过滤失效
4. 进入 `splitCardReasoningAnswerText(payload.text)` → 正确识别出 "Reasoning:" 块，返回 `{ reasoningText: "...", answerText: undefined }`
5. **Bug**：`const answerText = split.answerText ?? payload.text;` → `undefined ?? 原始文本` → 把含 "Reasoning:" 的完整文本发出去了

`splitCardReasoningAnswerText` 其实已经正确分离了，`answerText: undefined` 的含义是"这个块只有 reasoning，没有答案"，应该静默返回，而不是 fallback 回原始文本。

### 修复（一行）

```typescript
// 修复前（bug）
const split = splitCardReasoningAnswerText(payload.text);
const answerText = split.answerText ?? payload.text;  // ← undefined 时发原始文本
await emitAnswerSuffix(answerText);

// 修复后
const split = splitCardReasoningAnswerText(payload.text);
if (split.answerText === undefined) {
  return;  // 纯 reasoning 块，静默
}
await emitAnswerSuffix(split.answerText);
```

修复位置：`src/reply-strategy-markdown.ts`，约第 250 行。

### 为什么 card 策略没有同样的 bug

`reply-strategy-card.ts` 的 `applyDeliveredContent` 里：
```typescript
if (normalized.answerText && options.answerHandling !== "ignore") {
```
用的是 truthy 判断，`undefined` 不会触发 emit，逻辑正确。

## 执行

1. 修改 `reply-strategy-markdown.ts`（源码直接生效，无需 build）
2. 重启 gateway：`launchctl kickstart -k gui/<uid>/ai.openclaw.gateway`，PID 95809 → 96318
3. 钉钉测试：**已验证正常**，"Reasoning:" 消息不再出现

## 防御体系现状

| 级别 | 机制 | 状态 |
|------|------|------|
| 一级 | `isReasoning === true` 元数据拦截 | 失效（upstream 未标记） |
| 二级 | `splitCardReasoningAnswerText` 分离 + 修复后的静默逻辑 | **已修复，生效** |
| 三级 | `looksLikeReasoning` 英文短语匹配 | 在源码中存在，覆盖 "let me..." 等模式 |

## 经验

- **工具已经正确，fallback 逻辑是凶手**：`splitCardReasoningAnswerText` 本身就能识别 "Reasoning:"，问题在于识别后 `undefined ?? payload.text` 反而把原文发了出去。
- **不要从源头修，要看哪里漏**：几次尝试都在折腾 OpenClaw 配置和 pi-ai 行为，真正的洞在钉钉插件的 deliver 逻辑里，且一直没被关掉。
- **弯路的代价**：`reasoning: true` 的尝试虽然被还原了，但浪费了一轮测试。下次排查先读现有防线的代码，确认 "分离成功但 fallback 泄漏" 的可能性。

## 后续

- [ ] 向 OpenClaw upstream 补充 issue 说明：钉钉插件侧已有 workaround，`answerText ?? payload.text` fallback 是 bug
- [ ] `reasoning: false` 官方建议可以关掉的 issue 也值得回复：该配置对 CodingPlan 端点无效
