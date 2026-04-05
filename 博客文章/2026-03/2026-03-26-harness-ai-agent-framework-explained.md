---
title: "Harness：AI Agent的「驾驭系统」究竟是什么？"
date: 2026-03-26T22:30:00+08:00
draft: false
tags: ["AI", "Harness", "Agent", "Anthropic", "OpenAI", "系统工程"]
categories: ["AI技术"]
---

## 引言：又一个翻译不了的AI新词

Token刚被官方认证为「词元」，AI圈又迎来一个难以翻译的新词：**Harness**。

这个词在Anthropic去年11月的博客中首次被正式提出，随后OpenAI、MiniMax等厂商纷纷跟进。它到底是什么？为什么顶级AI实验室都在谈论它？

---

## 什么是Harness？

### 最简单的定义

> **Harness = Agent的运行容器 + 安全边界 + 调度控制器**

它是一套系统，用来补偿当前AI不擅长的事：
- AI不擅长长期记忆 → Harness用进度文件、git历史来补
- AI评价自己太宽松 → 用独立评估Agent来严格测试
- AI容易偏航 → 用任务分解、合约约定来约束

### 为什么需要Harness？

Anthropic的研究发现，当Claude执行长周期任务时，一旦感觉上下文窗口快填满，就会产生**"上下文焦虑"**——像快要下班的打工人，开始疯狂敷衍，试图赶紧结束任务。

更可怕的是，Claude并不觉得自己在敷衍。当研究员要求AI评估这些"为了下班赶工"编写的代码时，它发现不了其中的问题。

传统的提示词设计对此毫无用处。Harness应运而生。

---

## Anthropic的Harness：组织架构视角

### 三角闭环设计

Anthropic设计了一个包含三个角色的Harness闭环：

| 角色 | 职责 |
|------|------|
| **规划师（Planner）** | 把一句话需求扩写成详细的产品文档 |
| **生成器（Generator）** | 纯粹的执行者，只负责按文档写代码 |
| **评估器（Evaluator）** | 冷酷的QA兼产品经理，手握自动化测试工具 |

### 实际效果对比

**无Harness**：
- 时间：20分钟
- 成本：9美元
- 结果：界面能看，但核心功能坏掉（游戏角色对键盘操作无反应）

**有Harness**：
- 时间：6小时
- 成本：200美元
- 结果：游戏能玩，还有动画系统、音效、AI关卡设计

**关键机制**：生成器写完代码，评估器立即像真实用户一样测试，发现Bug或"AI塑料味"的设计，直接打回重做。

---

## OpenAI的Harness：工程文化视角

### 核心约束：零人工代码

OpenAI的Codex团队把Harness做成了一种工程文化：

> "所有代码——业务逻辑、测试、CI配置、文档、内部工具——都由Codex写。工程师的工作不是写代码，而是设计让AI能可靠工作的环境。"

### 从AGENTS.md到docs/

**早期做法**：
- 超长的AGENTS.md文件，告诉AI所有规则
- 问题：上下文限制导致AI只进行本地模式匹配，没有真正理解
- 文件很快过时，无人维护

**改进做法**：
- AGENTS.md只有100行，充当"目录"
- 指向结构化的docs/文件夹
- 架构文档、产品规格、设计决策、技术债务追踪，全部版本化
- 每个doc由AI写、AI维护，定期有"文档园丁"Agent扫描更新

### 楚门的世界

在这个Harness中：
- AI拥有写代码的绝对自由
- 但这种自由永远在人类设定的结界之内
- 严格的Linter和物理依赖边界，越界就会被系统切断

---

## Harness的本质：补偿AI的短板

| AI不擅长 | Harness的补偿 |
|----------|--------------|
| 长期记忆 | 进度文件、git历史、结构化文档 |
| 自我评估 | 独立评估Agent，带具体标准测试 |
| 复杂任务偏航 | 任务分解、结构化、合约约定 |
| 架构品味直觉 | 文档和自动化规范检查，将人类判断转为系统规则 |

---

## 为什么Harness难以翻译？

网友给出了各种翻译：
- 线束、驾驭层、控制框架、管控层、锚定层
- 安全套、套马杆、槽具（约束牛马）...

Claude的建议是：**不翻译，就用Harness**。

因为它同时包含了：
- **约束**（马具、束缚）
- **执行**（运行容器）
- **环境**（工作空间）
- **系统**（整体架构）

拆开来哪个都只说对了一半。

---

## 未来：模型越强，Harness越重要

Anthropic升级到Opus 4.6后发现，之前为对抗"上下文焦虑"设计的"上下文重置"机制可以直接去掉——新模型已经能自己处理了。

但同时，他们发现了新方向：用Harness让AI在应用里自动集成AI功能，这是之前模型做不到的事。

> **模型越强，Harness不是变得更简单，而是要去做更难的事。**

---

## 对开发者的启示

### 1. 从提示词工程到Harness设计

会写提示词和Skills不是核心竞争力。真正的顶级人才，是那些**懂得如何设计Harness的人**。

### 2. 投资系统架构能力

- 学习Anthropic的规划-生成-评估闭环
- 学习OpenAI的文档即代码、规则即架构
- 把"约束AI"变成"系统能力"

### 3. 准备迎接新范式

Harness代表了AI工程的新范式：
- 不是让AI更聪明，而是让系统更可靠
- 不是写更多代码，而是设计更好的环境
- 不是追求单次成功，而是追求可复现的成功

---

## 参考链接

- [Anthropic: Effective harnesses for long-running agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)
- [Anthropic: Harness design for long-running application development](https://www.anthropic.com/engineering/harness-design-long-running-apps)
- [OpenAI: Harness engineering](https://openai.com/index/harness-engineering/)
- [OpenAI: Unlocking the Codex harness](https://openai.com/index/unlocking-the-codex-harness/)
- [Mitchell Hashimoto: My AI Adoption Journey](https://mitchellh.com/writing/my-ai-adoption-journey)

---

*本文整理自微信公众号「APPSO」*
