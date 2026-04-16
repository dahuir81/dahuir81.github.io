# Agent 运行底座

> **类型**：Concept
> **创建**：2026-04-09
> **来源**：Claude Managed Agents 发布解读

## 定义

Agent 运行底座是指让 Agent 能够稳定、长期、可恢复、可追踪地完成真实工作所需的基础设施层，包括：

- 沙箱执行环境（sandboxed code execution）
- 状态持久化（checkpointing）
- 凭证管理（credential management）
- 权限控制（scoped permissions）
- 全链路追踪（end-to-end tracing）
- 错误恢复机制

## 核心判断

1. **Agent 从"会话对象"变成"工作对象"**——不再只是一问一答，而是能持续半小时甚至更长时间完成复杂任务
2. **运行底座正在被平台化**——Anthropic 的 Managed Agents 把最通用、最难自建的那层变成 Claude Platform 默认能力
3. **通用 infra 差异化变薄，垂直领域 harness 更值钱**——金融/法律/医疗需要特定的 mandate state、compliance harness、权限隔离

## Brain / Hands / Session 架构

```
Brain（Claude + harness）
  ↕ 推理、规划、路由
Hands（sandbox + tools）
  ↕ 执行动作
Session（append-only events）
  → 过程记录、恢复、审计
```

解耦后性能：首 token 延迟 p50 降低约 60%，p95 降低超过 90%。

## 关联概念

- [[Harness]]
- [[Claude Code]]
- [[Claude Managed Agents]]
- [[上下文治理]]
- [[SessionMemory]]
- [[Agent Loop]]
- [[Hermes Agent]]
- [[Kimi K2.6]]

## 来源文章

- [[2026-04-14-Hermes接入KimiK2.6实测-source|Hermes 接入 Kimi K2.6 实测]] — 23 个 Agent 并发底座实测

## 商业影响

| 影响 | 说明 |
|------|------|
| 通用 Agent infra 被压缩 | 只做 loop + 工具 + 沙箱的产品空间被挤压 |
| 垂直 harness 更值钱 | 领域特定的权限、合规、验收成为差异点 |
| 竞争进入"懂工作"阶段 | 不再比"谁先搭出框架"，而是"谁的 Agent 能稳定完成真实工作" |
