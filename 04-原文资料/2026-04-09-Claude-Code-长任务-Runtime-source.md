# Claude Code 长任务 Runtime：压缩、记忆与续写

> 来源：架构师（若飞）
> 原文：https://mp.weixin.qq.com/s/SBkOZ2VyHG2Q2BCIJawNIg
> 抓取时间：2026-04-09 23:34

---

## 核心论点

Claude Code 没有把"长任务别跑偏"赌在模型自己硬扛，而是把压缩、续写、记忆和信息回灌做成了套 Runtime。

**长任务真正容易卡住的地方不是 context window 不够大，而是系统有没有能力决定什么该留、什么该丢、什么该交接、什么该进入长期记忆。**

---

## 上下文治理七层架构

| 层级 | 机制 | 作用 |
|------|------|------|
| 0 | toolResultStorage | 大工具结果落盘到 tool-results/，上下文只保留预览 |
| 1 | microcompact | 清理低价值大块结果（旧Read、shell输出、Grep等） |
| 2 | autocompact | 带预算控制的正式 compact |
| 3 | reactiveCompact | prompt too long 时的最后防线 |
| 4 | SessionMemory | 后台持续维护的工作笔记（非摘要） |
| 5 | memdir + extractMemories | 跨会话长期记忆 |
| 6 | autoDream | 后台慢速整理（24小时+5 session 阈值） |

---

## 关键设计

### compact 严格禁工具
`compact/prompt.ts` 明确禁止压缩阶段调用任何工具——把"摘要"当成受约束的系统动作，不是自由发挥。

### SessionMemory ≠ compact
- compact：缩短历史
- SessionMemory：续住工作

SessionMemory 模板包含：
- Current State（必须反映最新进度）
- Task specification
- Files and Functions
- Workflow
- Errors & Corrections（单独章节，防重复踩坑）
- Key results
- Worklog

触发条件：上下文 10k token 后初始化，之后每增 5k token 或工具调用 3 次更新。

### 长期记忆有纪律
- MEMORY.md 只是 index，200 行/25KB 硬上限
- 召回不是 embedding 检索，而是 sideQuery 选最多 5 个文件
- 只基于最近消息更新，防 memory 腐烂
- 先检查已有记忆再决定更新或新增，防重复项

---

## 六条可直接拿走的经验

1. **把"压缩历史"和"续写状态"拆成两个系统**
2. **compact 阶段严格禁工具**
3. **给状态续写一个固定骨架**（Current State / Errors & Corrections / Worklog）
4. **memory 只基于最近消息更新**
5. **relevant memory 要做召回，不要全量注入**
6. **给长期记忆入口加硬预算**

---

## 商业判断

AI Coding 产品之间的差距，可能越来越不在模型本身，而在谁先把"长任务怎么不跑偏"做成 Runtime。

Anthropic 的核心工程哲学：**把"必须靠模型自己自觉"的那部分面积，尽量缩小。**
