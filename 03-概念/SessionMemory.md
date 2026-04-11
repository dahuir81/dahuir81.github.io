# SessionMemory

> **类型**：Concept
> **创建**：2026-04-09
> **来源**：Claude Code 长任务 Runtime 源码分析

## 定义

SessionMemory 是 Claude Code 中专门用于维护**当前任务运行状态**的机制，不是摘要，而是一份结构化的交接文档。

## 与 Compact 的区别

| 维度 | Compact | SessionMemory |
|------|---------|---------------|
| 目的 | 缩短历史 | 续住工作 |
| 内容 | 历史摘要 | 当前状态、待办、已踩坑 |
| 触发 | 上下文接近上限 | 10k token 初始化，每增 5k token 更新 |
| 性质 | 被动压缩 | 主动维护 |

## SessionMemory 模板结构

- `Current State` — 最新进度（必须反映最新状态）
- `Task specification` — 任务定义
- `Files and Functions` — 关键文件和函数
- `Workflow` — 工作流
- `Errors & Corrections` — 踩坑记录（单独章节，防重复犯错）
- `Codebase and System Documentation` — 文档
- `Learnings` — 学到的经验
- `Key results` — 关键结果
- `Worklog` — 工作日志

## 触发条件

1. 上下文 token 数超过 10,000 → 初始化
2. 之后至少再增长 5,000 token → 考虑更新
3. 同时看工具调用数（默认 3 次）
4. 到达自然停顿点也可能触发

## 关联概念

- [[Claude Code]]
- [[上下文治理]]
- [[Agent运行底座]]
- [[Harness]]
- [[长期记忆系统]]
