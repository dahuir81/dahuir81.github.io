# OpenClaw Reasoning 内容泄漏问题

**问题描述**: 钉钉对话中出现英文 thinking/reasoning 内容  
**根本原因**: Markdown 策略未正确处理 isReasoning 字段  
**影响版本**: OpenClaw 4.9+  
**状态**: 待修复

---

## 问题现象

- 钉钉对话中出现英文 thinking 内容（如 "Let me...", "I need to..."）
- 飞书正常，不受影响
- 4.9 版本后出现，之前版本正常

---

## 根因分析

### 直接原因

钉钉 Markdown 模式的 `reply-strategy-markdown.ts` 在 `deliver` 方法中**完全没有判断 `isReasoning` 字段**，导致 reasoning 内容被当成正式回答发送。

### 深层原因

1. **百炼 API 行为**: 总是返回 `reasoning_content`（即使没开 thinking）
2. **OpenClaw 4.9 变更**: "default missing reasoning effort to high" 让框架更积极地保留 reasoning 字段
3. **钉钉插件缺失**: 没有处理 reasoning 的逻辑
4. **框架层 bug**: `inbound-handler.ts:1953` 硬编码 `isReasoning: false`

### 飞书为什么没事

飞书有独立的 `StreamingCardController`，把 reasoning 和 answer **彻底分开**处理。

---

## 触发链路

```
百炼 API → reasoning_content
    ↓
OpenClaw 4.9 → isReasoning: true
    ↓
buffered dispatcher → 缓冲所有 block
    ↓
inbound-handler.ts:1907 → strategy.deliver({isReasoning: true})
    ↓
reply-strategy-markdown.ts → 不看 isReasoning，直接 emit
    ↓
钉钉对话出现英文 thinking
```

---

## 修复方案

### P0 必改（核心修复）

**文件**: `reply-strategy-markdown.ts`  
**方法**: `deliver`  
**代码**:

```typescript
if (payload.isReasoning === true) {
  return;
}
```

### P1 加固（框架层修复）

**文件**: `inbound-handler.ts:1953`  
**问题**: `bufferedFinal` 回退路径硬编码 `isReasoning: false`  
**修复**: 根据实际内容判断或使用 `splitCardReasoningAnswerText` 二次过滤

### P2 顺手（体验优化）

- "✅ Done" → "✅ 完成"

### P3 可选（框架优化）

**文件**: `getReplyOptions`  
**修改**: 注册空的 `onReasoningStream` 回调，标记 reasoning 流已消费

---

## 修复验证建议

1. 先部署 P0 修复
2. 测试常用场景：图片处理、文件操作、查资料
3. 确认英文不再出现
4. 如有零星泄漏，再上 P1 二次过滤

---

## 相关文件

| 文件 | 位置 | 作用 |
|------|------|------|
| reply-strategy-markdown.ts | 钉钉插件 | Markdown 回复策略 |
| inbound-handler.ts | 框架层 | 消息入站处理 |
| StreamingCardController | 飞书插件 | 飞书卡片流处理 |

---

## 参考

- [[2026-04-11-钉钉Markdown-reasoning泄漏问题诊断]]
- OpenClaw 4.9 变更日志
- 百炼 API 文档

---

**标签**: #OpenClaw #Bug #Reasoning #钉钉 #技术债务
