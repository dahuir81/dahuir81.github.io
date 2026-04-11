# Claude Code 长任务 Runtime：从压缩、续写到记忆的治理体系

**来源**: 架构师（若飞）  
**原文链接**: https://mp.weixin.qq.com/s/L0fGwMIh4HOXrg-Xi_BcWA  
**抓取时间**: 2026-04-09

---

## 核心观点

> **长任务真正容易卡住的地方，不是 context window 不够大，而是系统有没有能力决定什么该留、什么该丢、什么该交接、什么该进入长期记忆。**

---

## Claude Code 至少 6-7 层 context / memory 机制

### 两类并行链路
- **上下文治理**：当前长任务不断线
- **跨会话长期记忆**：项目级经验沉淀

### 七层架构

| 层级 | 机制 | 作用 |
|------|------|------|
| 0 | `toolResultStorage` | 大工具结果先落盘 `tool-results/`，上下文只保留预览 |
| 1 | `microcompact` | 清理旧 Read/Shell/Grep/Glob/WebSearch 结果，先扔垃圾 |
| 2 | `autocompact` | 带预算控制的正式 compact，有 circuit breaker |
| 3 | `reactiveCompact` | 打到 prompt too long 时的最后一道防线 |
| 4 | `SessionMemory` | 后台持续维护的工作笔记（非 compact 时临时生成） |
| 5 | `memdir` + `extractMemories` | 跨会话长期记忆（文件系统方案） |
| 6 | `autoDream` | 慢周期后台巩固（24h+/5 session+） |

---

## 关键设计细节

### compact 阶段严格禁工具
- `prompt.ts` 明确禁止 compact agent 调用任何工具
- 把"摘要"当成受约束的系统动作，不是自由发挥

### SessionMemory ≠ compact 摘要
- 上下文 >10k token 初始化，之后每 +5k token 或 3 次工具调用更新
- 9 个结构化字段：Current State、Task specification、Files and Functions、Workflow、Errors & Corrections 等
- **compact 负责缩短历史，SessionMemory 负责续住工作**

### 长期记忆有硬预算
- `MEMORY.md`：200 行 / 25KB 硬上限，只是索引不是正文
- 召回不是 embedding 检索，是扫描头部后用 `sideQuery` 选最多 5 个
- memory 类型只 4 类：user、feedback、project、reference
- 不存：代码模式、架构结构、文件路径、git 历史、debugging fix recipe、临时任务状态

---

## 6 条可直接拿走的思路

1. **压缩历史** 和 **续写状态** 拆成两个系统
2. compact 阶段严格禁工具
3. 给状态续写一个固定骨架（Current State / Errors & Corrections / Worklog）
4. memory 只基于最近消息更新
5. relevant memory 要做召回，不要全量注入
6. 给长期记忆入口加硬预算

## 关联标签

- #ClaudeCode #LongTaskRuntime #ContextManagement #SessionMemory
- [[Claude Code Runtime]]、[[上下文治理]]、[[SessionMemory]]、[[compact机制]]、[[长期记忆]]
- [[Anthropic]]、[[Claude Code]]
