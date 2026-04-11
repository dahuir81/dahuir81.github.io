# Harness

**类型**: 架构概念
**定义**: AI Agent 模型之外的系统层，负责工具调用、执行循环、记忆管理、安全控制等

## 核心观点
> "模型能力已经越来越强，真正拉开差距的，正在变成模型外面那层系统。"

## Agentic Harness 定义
> "围绕模型搭建的约束、反馈闭环与上下文工程系统"

**类比**：Model = CPU，Context Window = RAM，Agent Harness = OS，Agent = Application
*图源：Philipp Schmid — The Importance of Agent Harness in 2026*

## 核心悖论
Agent 赛道两个矛盾观点同时成立：
1. **Agent 不是一个赛道** — 没有持久壁垒，独立产品无法形成护城河
2. **Harness 是效果的决定性变量** — 当下效果差异的核心变量

**解释**：Harness 优势有保质期，且不同层面差异很大：
- 有些会在**下一代模型发布时迅速归零**（模型进步抵消）
- 有些反而会**随模型进步而增值**（长期价值）

## 典型 Harness 组件
- 执行循环（Execution Loop）
- 工具编排（Tool Orchestration）
- 记忆管理（Memory Management）
- Skill 沉淀（Skill Accumulation）
- 安全边界（Security Boundaries）

## 代表项目
| 项目 | Harness 特点 |
|------|-------------|
| [[Hermes Agent]] | 闭环学习 + 后台 review + FTS5 记忆 |
| [[OpenClaw]] | 多渠道网关 + Skill 市场 |
| [[Claude Code]] | 上下文压缩 + 记忆续写 |
| [[Codex]] | 会话管理 + 工具集成 |

## 行业趋势
从"补模型能力"转向"删冗余功能"——Harness 越来越精简高效。

## 关联
- 相关文章: [[2026-04-09-Hermes Agent架构拆解]]
- 相关文章: [[2026-04-06-huawei-chasiwu-ai-weekly-agent-harness-2nm-chip-source|万字解读Agentic Harness | 茶思周一见]]
- 参见: [[闭环学习循环]]、[[七层纵深防御]]、[[记忆分层存储]]、[[Context工程]]
