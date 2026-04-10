# Claude Managed Agents

> **类型**：Entity（产品）
> **创建**：2026-04-09
> **来源**：Anthropic 官方博客 2026-04-08

## 基本信息

- **发布方**：Anthropic
- **发布日期**：2026-04-08
- **状态**：Beta
- **API Header**：`managed-agents-2026-04-01`
- **定价**：标准 Claude Platform token 费用 + $0.08/session-hour

## 是什么

Claude Platform 上的托管 Agent 运行系统，帮助开发者更快构建和部署云端托管 Agent。

不是聊天入口，是 pre-built、configurable 的 agent harness，跑在 managed infrastructure 上。

## 四个核心对象

| 对象 | 负责 |
|------|------|
| Agent | 模型、system prompt、tools、MCP servers、skills |
| Environment | 容器模板、预装包、网络访问、挂载文件 |
| Session | 某个 Agent 在某个环境里执行一次具体任务 |
| Events | 应用和 Agent 之间的消息、工具结果、状态更新 |

## 早期客户

Notion、Asana、Rakuten、Sentry、Vibecode

## 限制

- Beta 阶段
- outcomes / multiagent / memory 为 research preview，需申请访问
- 不是零代码工具，需要懂 API、权限、环境配置

## 关联

- [[Anthropic]]
- [[Agent运行底座]]
- [[Harness]]
- [[Claude Code]]
