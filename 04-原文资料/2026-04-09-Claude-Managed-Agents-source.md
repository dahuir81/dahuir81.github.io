# Claude Managed Agents：Agent 从"会话对象"到"工作对象"

> 来源：架构师（若飞）
> 原文：https://mp.weixin.qq.com/s/WsNQWXz1_kAQtHRvBtC11Q
> 抓取时间：2026-04-09 23:34
> 发布：2026-04-08

---

## 核心论点

2026年4月8日，Anthropic 发布 **Claude Managed Agents**，把 Agent 的运行底座（沙箱、长会话、状态保存、错误恢复、工具执行、日志追踪）搬到 Claude Platform 上托管。

**核心判断**：它做的不是替你写一个 Agent，而是把"让 Agent 能稳定干活"的后台搬到了云上。

---

## 关键信息

### 四个核心抽象

| 对象 | 负责什么 | 类比 |
|------|----------|------|
| `Agent` | 模型、system prompt、tools、MCP servers、skills | 数字同事的角色设定和能力清单 |
| `Environment` | 容器模板、预装包、网络访问、挂载文件 | 工位、电脑、工具箱和网络边界 |
| `Session` | 某个 Agent 在某个环境里执行一次具体任务 | 接到的一项具体工作 |
| `Events` | 应用和 Agent 之间的消息、工具结果、状态更新 | 工作从开始到结束留下的流水账 |

### Brain / Hands / Session 三层解耦

- **Brain**：Claude 和 harness，负责推理、规划、路由工具调用
- **Hands**：sandbox 和 tools，真正执行动作
- **Session**：append-only 事件日志，任务推进过程

解耦后性能：首 token 延迟 p50 降低约 60%，p95 降低超过 90%。

### 早期客户案例

| 客户 | 方向 |
|------|------|
| Notion | 在工作空间里委派任务给 Claude，多任务并行 |
| Asana | AI Teammates，像团队成员一样接任务 |
| Rakuten | 组织级 specialist agents（产品/销售/市场/财务） |
| Sentry | 发现问题 → 定位原因 → 写修复 → 开 PR |
| Vibecode | 从 prompt 到 deployed app，降低基础设施门槛 |

### 成本结构

- 标准 Claude Platform token 费用
- + `$0.08 / session-hour`（活跃运行时长）
- + 可能的工具成本

### 当前状态

- Beta 阶段，API header：`managed-agents-2026-04-01`
- `outcomes`、`multiagent`、`memory` 仍为 research preview

---

## 商业信号

1. **通用 Agent infra 会被压缩**——如果产品只是封一层 loop、接几个工具、做个沙箱，空间会被快速挤压
2. **垂直领域 harness 更值钱**——金融/法律/医疗需要 mandate state、compliance harness、权限隔离
3. **竞争从"我也有一个 Agent"转向"我的 Agent 能不能稳定完成一类真实工作"**

---

## 与 Tars 的关联

Anthropic 的 Managed Agents 方向与 OpenClaw/Tars 的本地 Agent 平台思路有重叠但优化方向不同：
- Managed Agents：云端托管，面向开发者平台
- OpenClaw：本地通用智能体，编码只是其中一种工作负载

两者都在解决同一组问题：上下文管理、状态持久化、权限治理、错误恢复。
