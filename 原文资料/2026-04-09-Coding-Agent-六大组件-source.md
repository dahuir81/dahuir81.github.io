# Coding Agent 六大核心组件：从模型到协作同事

> 来源：架构师（若飞）
> 原文：https://mp.weixin.qq.com/s/L0fGwMIh4HOXrg-Xi_BcWA
> 抓取时间：2026-04-09 23:34
> 原文作者引用：Sebastian Raschka《Components of a Coding Agent》

---

## 核心论点

真实的 Coding Agent 不是"会写代码的聊天机器人"，而是 `模型 + 控制循环 + 运行时系统` 的组合。同一个模型，放在聊天框里 vs 放在做过上下文管理、工具编排、状态恢复的系统里，表现完全不同。

---

## 六组件拆解

| 组件 | 解决什么问题 | 更像团队里的什么 |
|------|-------------|----------------|
| Live Repo Context | 避免模型盲启动 | 入组先读项目和规则 |
| Prompt Shape & Cache | 稳定前缀和动态信息分层 | 长期规则和当前任务分开 |
| Structured Tools | 工具调用可验证、可约束 | 受控工具链和权限系统 |
| Context Management | 避免上下文膨胀 | 只保留当下真正相关的信息 |
| Session Memory | 长任务不断线 | 会议纪要 + 当前行动清单 |
| Delegation & Subagents | 支线任务拆分 | 有边界的协作分工 |

---

## 关键洞察

### 1. LLM ≠ Agent ≠ Harness
- LLM：预测下一个 token 的引擎
- Reasoning Model：花 test-time compute 做推理
- Agent：围绕模型的控制循环（决定下一步做什么）
- Harness：包在外面的工程系统（上下文、工具、状态、权限、恢复）

### 2. Prompt 缓存优化
稳定前缀（系统指令、工具定义、仓库摘要）+ 动态部分（当前请求、近期历史、短期记忆）= 更低成本 + 更稳定速度

### 3. 上下文管理比模型更重要
很多表面上的"模型质量"，其实是上下文质量。
- Clipping：超长输出截断
- Transcript reduction：历史压成摘要
- Deduplication：重复文件不反复喂

### 4. 完整记录 ≠ 工作记忆
- Full Transcript：完整记录，可恢复、可审计
- Working Memory：精炼状态，让任务不断线

### 5. 子智能体的危险
- 上下文不够：出去一趟什么也做不了
- 边界太松：回来前把系统搞乱了

---

## 与 OpenClaw 的对比

| 维度 | Coding Harness | OpenClaw |
|------|---------------|----------|
| 核心场景 | 终端专用编码助手 | 本地通用智能体平台 |
| 关注点 | 仓库里高效读/改/跑工具/接反馈 | 多频道/工作区长运行本地智能体 |
| 重叠 | AGENTS.md、会话文件、记录压缩、子智能体 | 同左 |

---

## 商业判断

Sebastian 的推测：如果把最强开源模型（如 GLM-5）放进跟 Codex/Claude Code 同等成熟的 Harness，体验未必跟 GPT-5.4/Opus 4.6 差得夸张。Harness 的工程质量可能比模型选型更决定体感。
