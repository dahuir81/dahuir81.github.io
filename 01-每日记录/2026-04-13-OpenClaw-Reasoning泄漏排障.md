---
created: 2026-04-13
tags: [OpenClaw, 运维, Reasoning泄漏, Fallback机制, Session污染, 排障]
---

# 2026-04-13 OpenClaw Reasoning 泄漏排障

## 现象
钉钉 Tars 多次出现英文思考过程泄漏（"Let me...""I need to..."），用户收到非预期的 reasoning content 作为正常回复。

## 根因（三层）

### 第一层：百炼 Coding Plan Key 多端共用 → 秒级 RPS 限流
- CC、OpenClaw、同事并发使用同一 Key
- 百炼除 RPM/TPM 外还有秒级 RPS 限制
- 官方文档明确禁止 Key 共享，有禁用风险

### 第二层：OpenClaw fallback 机制污染 session primary
- 代码位置：`src/agents/command/session-store.ts` `updateSessionStoreAfterAgentRun`
- 同类问题：`src/cron/isolated-agent/run.ts` `finalizeCronRun`
- 问题：fallback 成功后会调用 `setSessionRuntimeModel` 把 fallback 的 provider/model 写回 session，导致下次新请求从 fallback 模型起跳，而不是配置的 primary
- 日志实锤：20:17 `requested=openrouter/qwen/qwen3.6-plus`，用户从未手动切换过

### 第三层：OpenRouter 与百炼 reasoning 协议不兼容
- 代码位置：`src/provider-utils/resolveReasoningOutputMode`
- bailian 用 native 模式，能正确分离 `reasoning_content` 字段
- openrouter 默认也走 native，但转发层把 reasoning 直接塞进 content
- 结果：`isReasoning` 字段没被标记，钉钉插件无法拦截

## 今晚修复（止血方案，非代码修复）

1. **清理已污染 session**：3 个 4月7日 subagent 孤儿（整条删除）+ 1 个 cron session（改 model 字段回 qwen3.6-plus）
2. **关闭 fallback**：`agents.defaults.model.fallbacks` 设为空数组
3. **launchctl 重启 openclaw**：PID 89067 → 11587，日志确认 `agent model: bailian/qwen3.6-plus`

## 代码 Patch 状态

已定位到 5 个文件的 patch，已在 `/Users/dahuir/GitHub/openclaw-src` commit `014d255`：

| 文件 | 改动 |
|------|------|
| `src/agents/model-fallback.ts` | 新增 `didFallback` 字段到 `ModelFallbackRunResult` |
| `src/agents/agent-command.ts` | 捕获并传递 `didFallback` |
| `src/agents/command/session-store.ts` | `if (!didFallback)` 条件化 `setSessionRuntimeModel` |
| `src/cron/isolated-agent/run-executor.ts` | Cron 执行器传递 `didFallback` |
| `src/cron/isolated-agent/run.ts` | `finalizeCronRun` 条件化 `setSessionRuntimeModel` |

未应用原因：
1. `pnpm build` 产物缺失 `compact.runtime.js`（上游 `tsdown.config.ts` 漏了 entry）
2. 自行维护 fork 长期升级成本高

改走 GitHub Issue 路线，等社区修复。

## 未采用方案（留档）

- **钉钉插件侧代码修复**：`deliver()` 方法已有 `if (payload.isReasoning === true) return;` 拦截，但 upstream 未标记 `isReasoning` 时无法生效
- **直接修改运行时 dist**：可行但不安全，已用 rsync 无 --delete 同步，保留旧 `compact.runtime.js`

## 备份（一周后可删）

- `~/.openclaw/agents/main/sessions.backup-20260413-021009`
- `~/.openclaw/openclaw.json.backup-20260413-022159`
- `~/Library/pnpm/global/5/.pnpm/openclaw@*/node_modules/openclaw/dist.backup-20260413-014944`

## 保留（issue 证据）

- `/Users/dahuir/GitHub/openclaw-src` 整个源码仓库
- commit `014d255`（本地 patch）
- `/tmp/openclaw-build.log`（构建日志）
- `/tmp/openclaw-pnpm-install.log`（安装日志）

## TODO

- [ ] 百炼 Key 分配策略：CC 一个 Key，OpenClaw 一个 Key
- [ ] 问百炼客服：限流是按 Key 还是按账号
- [x] 提 Issue #1：Fallback 污染 session primary（带日志证据）→ https://github.com/openclaw/openclaw/issues/65646
- [ ] 提 Issue #2：tsdown.config 漏 compact.runtime entry（build 配置）→ 等 #65646 有响应后再提
- [ ] VPN 使用规范：同一 Key 固定网络出口，避免跨国 IP 跳跃

## 4月13日追加：rsync 叠加导致 dist 损坏 + 回滚修复

### 问题起因
昨晚 01:49 备份 dist 后，用 rsync **不带 `--delete`** 同步了 build 产物，导致新的 dist 文件叠加到已有的 dist 上。结果：
- `dist/` 根目录 .js 文件从 2483 暴增到 4768（多了 2285 个变体文件）
- 其中 `commands-status-Cv5Egt1X.js` 引用了不存在的 `commands-status-deps.runtime.js`
- 导致钉钉 `/status` 命令报错：`ERR_MODULE_NOT_FOUND: Cannot find module 'commands-status-deps.runtime.js'`

### 根因确认
- 版本号从原始的 `769908e` 变成了 `014d255`（patch commit 的 hash）
- 各子目录 .js 数量基本一致，差异全部在 dist 根目录
- rsync 不带 `--delete` 导致两次 build 产物叠加，引用链断裂

### 修复步骤（2026-04-13 11:20 执行）

| 步骤 | 操作 | 结果 |
|------|------|------|
| Step 1 | 确认 `dist.backup-20260413-014944` 完整性 | ✅ 2499 文件，237M |
| Step 2 | `mv dist dist.broken-20260413-112025` | ✅ 损坏 dist 保留为证据 |
| Step 3 | `cp -R dist.backup-20260413-014944 dist` | ✅ 恢复为 2499 文件 |
| Step 4 | 校验版本和文件 | ✅ 版本回退到 `769908e`，commands-status 恢复为 3 个文件 |
| Step 5 | launchctl 重启 gateway | ✅ PID 35881 运行中 |
| Step 6 | 验证 fallback 配置 | ✅ `primary: bailian/qwen3.6-plus`, `fallbacks: []` 未受影响 |

### 保留的证据（一周后清理）
- `dist.broken-20260413-112025` — 损坏的 dist，rsync 叠加事故证据
- `dist.backup-20260413-014944` — 原始完好备份

### 教训
- **rsync 同步目录必须加 `--delete`**，否则多次执行会叠加而非替换
- **备份是底线**：没有 01:49 的备份，今天无法无损回滚
- **配置修改和产物混装是隐患**：openclaw.json 里改的 fallback 配置是安全的（不在 dist 里），但 patch 编译产物混在 dist 里就容易被破坏

---

## 经验

- **只认日志，不认猜测**：今晚初期推测 "fallback 和 openrouter 协议导致泄漏"，被用户质疑没证据后退回重新取证。最终日志里的 `requested=openrouter` 才是实锤。
- **取证 → 分析 → 方案 → 战略决策** 的顺序不能跳，尤其凌晨排障容易跳步。
- **Build 失败 ≠ 排障失败**：issue 不需要自己能 build，能说清根因就够了。
- **止血优先于完美修复**：关 fallback + 清 session 比等代码修复更紧急，先让系统回到可控状态。

---

## 4月13日 17:52 追加：根因确认 + 钉钉插件侧修复

### 真正根因

OpenClaw 的 **`runAgentAttempt`（`src/agents/command/attempt-execution.ts:462`）调用 `runEmbeddedPiAgent` 时没有传 `reasoningLevel` 参数**。

代码链路：
1. 用户消息 → gateway → `runAgentAttempt()`
2. `runAgentAttempt` 调用 `runEmbeddedPiAgent({ ..., /* 没有 reasoningLevel */ })`
3. `runEmbeddedPiAgent` → `attempt.ts` → `subscribeEmbeddedPiSession`
4. `reasoningMode = params.reasoningLevel ?? "off"` → **默认 off**
5. `includeReasoning = reasoningMode === "on"` → **false**
6. reasoning content **不被分离**，直接混入普通 content 作为正常回复发送
7. 钉钉插件 `isReasoning: false`，一级拦截失效

结论：**session 里的 `reasoningLevel: "on"` 在 command/gateway 路径中从未被读取和传递。这是 OpenClaw 的代码缺陷。**

### 钉钉插件侧修复（止血）

在 `reply-strategy-markdown.ts` 和 `reply-strategy-card.ts` 新增**第三级防御**：

```typescript
const REASONING_PREFIX_RE = /^(let me|now let me|i need to|i'll |i will |first, i|...)/i;
function looksLikeReasoning(text: string): boolean {
  if (!text || text.length > 500) return false;
  const firstLine = text.split("\n")[0].trim();
  return REASONING_PREFIX_RE.test(firstLine);
}
```

拦截典型英文 reasoning 开头模式（"Now let me..."、"I need to..."、"Let me check..." 等 50+ 种模式）。

### 修复状态

- [x] 钉钉插件代码修复完成
- [x] Gateway 重启（PID 44110）
- [ ] 用户测试验证
- [ ] OpenClaw upstream issue 补充说明根因

### 三级防御体系

| 级别 | 机制 | 状态 |
|------|------|------|
| 一级 | `isReasoning === true` 元数据拦截 | 失效（upstream 未标记） |
| 二级 | `splitCardReasoningAnswerText` 分离 "Reasoning:" 前缀/`<thinking>` 标签 | 有效（仅对有标记的内容） |
| 三级 | `looksLikeReasoning` 英文 reasoning 模式匹配 | **新增**，覆盖本次泄漏 |
