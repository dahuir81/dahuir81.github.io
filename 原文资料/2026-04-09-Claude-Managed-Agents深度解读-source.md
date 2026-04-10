# Claude Managed Agents 深度解读：Agent 运行底座的托管时代

**来源**: 架构师（若飞）  
**原文链接**: https://mp.weixin.qq.com/s/WsNQWXz1_kAQtHRvBtC11Q  
**抓取时间**: 2026-04-09

---

## 核心事件

2026 年 4 月 8 日，Anthropic 发布 **Claude Managed Agents**（beta），将 Agent 的运行底座（沙箱、权限、会话、tracing、错误恢复）搬到 Claude Platform 上托管。

官方定位：**帮助开发者更快构建和部署云端托管 Agent，10x 到生产。**

---

## 一句话理解

> **Agent 正在从"会话对象"变成"工作对象"。**

不是替你写一个 Agent，而是把"让 Agent 能稳定干活"的后台搬到了云上。

---

## 四个核心抽象

| 对象 | 负责什么 | 类比 |
|------|----------|------|
| `Agent` | 模型、system prompt、tools、MCP servers、skills | "数字同事"的角色设定和能力清单 |
| `Environment` | 容器模板、预装包、网络访问、挂载文件 | 工位、电脑、工具箱和网络边界 |
| `Session` | 某个 Agent 在某个环境里执行一次具体任务 | 接到的一项具体工作 |
| `Events` | 应用和 Agent 之间的消息、工具结果、状态更新 | 工作从开始到结束留下的流水账 |

---

## Brain / Hands / Session 解耦

Anthropic 工程文章把 Agent 运行系统拆成三层：

- **Brain**: Claude + harness（推理、规划、路由工具调用）
- **Hands**: sandbox + tools（真正执行动作）
- **Session**: append-only 事件日志（任务过程记录）

**核心工程思路**: 接口要稳定，实现可以替换。

容器可以挂，harness 可以重启，只要 session log 还在，就能从事件历史恢复。

**性能数据**: Brain/Hands 解耦后，首 token 延迟 p50 降低约 60%，p95 降低超过 90%。

---

## 早期客户案例

| 公司 | 场景 | 意义 |
|------|------|------|
| **Notion** | 工作空间内委派任务，多任务并行 | 协作产品 + 任务委派系统 |
| **Asana** | AI Teammates 接任务做任务 | Agent 进入任务系统，遵守协作规则 |
| **Rakuten** | 给各部门部署 specialist agents（一周内完成） | 缩短专用 Agent 进入组织的周期 |
| **Sentry** | 发现问题 → 定位原因 → 写修复 → 开 PR | Agent 进入软件工程闭环 |
| **Vibecode** | prompt → deployed app，不再花几周搭基础设施 | 降低 Agent 开发门槛 |

---

## 行业影响判断

### 通用 Agent infra 会被压缩

如果一个产品只是在卖：封一层 agent loop + 接几个工具 + 做通用沙箱 + 存会话状态 + 粗粒度日志，那它的空间会被快速压缩。

### 垂直领域 harness 会变得更值钱

- **金融 Agent**: 需要 mandate state（授权金额/品种/止损）
- **法律 Agent**: 需要 compliance harness（自动标注 vs 人工确认）
- **医疗 Agent**: 需要权限隔离、审计日志、human-in-the-loop

> **模型越来越通用，Agent 产品反而要越来越专用。**

---

## 当前状态

- **状态**: beta
- **API header**: `managed-agents-2026-04-01`
- **Research preview**（需申请）: `outcomes`、`multiagent`、`memory`
- **价格**: 标准 Claude Platform token 费用 + `$0.08 / session-hour`

---

## 核心洞察

1. Anthropic 把 Agent 运行底座产品化，不只是提供模型 API
2. Agent 产品的竞争从"谁能先把框架搭出来"进入"谁更懂工作本身"
3. 底座越标准，差异越往业务边界走
4. 对创业公司：通用 infra 变薄，垂直 workflow 更值钱

## 关联标签

- #Anthropic #Claude #ManagedAgents #AgentHarness #AgentInfrastructure
- [[Claude Managed Agents]]、[[Agent运行底座]]、[[Harness工程]]、[[BrainHands解耦]]
- [[Anthropic]]、[[Notion]]、[[Asana]]、[[Rakuten]]、[[Sentry]]
