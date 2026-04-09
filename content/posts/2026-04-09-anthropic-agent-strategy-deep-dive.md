---
title: 'Anthropic Agent 战略拼图：从 Managed Agents 到长任务 Runtime 的完整解读'
date: 2026-04-09
draft: false
tags:
  - AI
  - Anthropic
  - Agent
  - Claude
  - Harness
categories:
  - 技术深度
description: '2026年4月，Anthropic 通过 Claude Managed Agents 发布和 Claude Code 源码泄露事件，暴露了一套完整的 Agent 运行底座战略。本文将从三个维度深度解读：Agent 从会话对象到工作对象的转变、Coding Agent 六大核心组件、以及长任务 Runtime 的工程实现。'
---

> 本文由三篇架构师（若飞）深度解读文章综合分析整理，原文分别发表于 2026 年 4 月 8-9 日。

---

2026 年 4 月初，Anthropic 做了一件事：把 Agent 从"聊天框"里拽出来，按进了"真实工作"里。

4 月 8 日发布 **Claude Managed Agents**，4 月 9 日 **Claude Code 源码** 被翻了个底朝天。两件事合在一起看，不是一次偶然的巧合，而是一套完整的战略拼图。

我想用最直白的方式说清楚：**Anthropic 到底在干什么，以及这件事对普通人意味着什么。**

---

## 一、Agent 不再是聊天框

大多数人理解的 Agent，是这样的：

打开聊天框 → 问问题 → 得到回答 → 结束。

Anthropic 想做的完全不同。

Managed Agents 的本质，是把 Agent 从**"会话对象"变成"工作对象"**。

区别在哪？

| 会话对象 | 工作对象 |
|----------|----------|
| 一问一答，即时返回 | 持续运行半小时甚至更久 |
| 不需要碰文件系统 | 读文件、写文件、跑脚本 |
| 出错了重问就行 | 需要中间状态、错误恢复 |
| 不需要权限管理 | 需要沙箱、权限、审计 |
| 过程不重要 | 过程必须可追踪、可复现 |

用一句话总结 Managed Agents 的核心：

> 它做的不是替你写一个 Agent，而是把"让 Agent 能稳定干活"的后台搬到了云上。

---

## 二、运行底座：Agent 真正难的部分

为什么 Agent 从 demo 到生产这么难？

不是模型不够聪明。是**运行底座**太重。

Anthropic 官方博客列了一组生产 Agent 必须处理的基础设施问题：

- **沙箱执行** —— Agent 生成的代码在哪里跑？怎么限制权限？
- **状态持久化** —— 跑了 40 分钟失败了，前面的工作怎么办？
- **凭证管理** —— Agent 能访问哪些系统？凭证怎么保管？
- **权限控制** —— 它能删数据库吗？能发钱吗？
- **全链路追踪** —— 它为什么调用这个工具？哪一步最花钱？

这些问题，和"模型聪不聪明"几乎没关系。

它们属于**工程基础设施**。

Managed Agents 把这些共性问题拿走，让开发者专注在业务语义、权限治理和验收标准上。

---

## 三、Brain / Hands / Session 三层解耦

这次最让我在意的工程细节，是 Anthropic 把 Agent 运行系统拆成了三层：

```
┌─────────────┐
│    Brain     │  Claude + harness（推理、规划、路由）
├─────────────┤
│    Hands     │  sandbox + tools（真正执行动作）
├─────────────┤
│   Session    │  append-only 事件日志（发生过什么）
└─────────────┘
```

这个拆分的好处很直接：

- 容器可以挂，harness 可以重启，只要 session log 还在就能恢复
- Brain 和 Hands 解耦后，首 token 延迟 p50 降低约 **60%**，p95 降低超过 **90%**
- 模型会变强，harness 会过时，sandbox 也会换——但接口可以保持稳定

> 工程直觉很朴素：**不要让任何一个容器、任何一个 harness、任何一次运行成为不能死的"宠物"。**

---

## 四、Coding Agent 的六个组件

Sebastian Raschka（写《Build a LLM From Scratch》那位）把 Coding Agent 拆成了 6 个核心组件。这张表值得保存：

| 组件 | 解决什么问题 | 类比 |
|------|-------------|------|
| **Live Repo Context** | 避免模型盲启动 | 新员工入组先看项目文档 |
| **Prompt Shape & Cache** | 稳定前缀和动态信息分层 | 长期规则和当前任务分开 |
| **Structured Tools** | 工具调用可验证、可约束 | 受控工具链和权限系统 |
| **Context Management** | 避免上下文膨胀 | 只保留当下真正相关的信息 |
| **Session Memory** | 长任务不断线 | 会议纪要 + 行动清单 |
| **Delegation & Subagents** | 支线任务拆分 | 有边界的协作分工 |

其中最容易被低估的，是**上下文管理**和**工作记忆**。

Sebastian 有一句话很精准：

> 很多表面上的"模型质量"，其实是上下文质量。

---

## 五、长任务为什么容易跑偏

用 Claude Code 跑过长任务的人都知道：前半段很顺，到了某个节点突然开始重复读文件、忘了前面做到哪了、甚至把已经改过的东西又改回去。

你会觉得是模型不行。

但源码告诉我们：**问题通常不在模型，而在上下文治理。**

Claude Code 的处理方式分了好几步：

### 第零步：大结果先落盘
大工具输出（grep、cat、shell 输出）先存到 `tool-results/` 文件里，上下文只保留预览。——**先把垃圾扔了，再整理笔记。**

### 第一步：microcompact
清理低价值的大块结果（旧的 Read、shell 输出、Grep 等），保住对话主线。

### 第二步：autocompact
带预算控制的正式压缩。不是"快满了赌一把摘要"，而是精确计算窗口、预留空间、设置断路器。

### 第三步：reactiveCompact
最后一道防线。到了这一步已经不关心摘要质量了，只关心：**这轮能不能活下来。**

### 第四步：SessionMemory
这不是一份摘要，而是一份**交接文档**：
- 当前做到哪了
- 哪些文件最关键
- 踩过什么坑
- 还有哪些待办

### 第五步：长期记忆
Claude Code 的长期记忆不是向量库，是文件系统：
- `MEMORY.md` 作为索引，200 行/25KB 硬上限
- 召回不是 embedding 检索，是让模型从文件名和描述里选最多 5 个相关文件
- 只基于最近消息更新，防重复、防过时、防腐烂

---

## 六、商业信号

### 谁会被压缩

如果一个产品只是在卖这些东西：
- 自己封一层 agent loop
- 给模型接几个工具
- 做一个通用沙箱
- 存一下会话状态
- 做一点粗粒度日志

**空间会被快速挤压。**

因为大模型公司开始把这层变成平台能力。

### 谁会更值钱

- **垂直领域 harness**：金融需要 mandate state（这次授权允许花多少钱），法律需要 compliance harness（哪些条款必须交给律师确认），医疗需要权限隔离和审计日志
- **懂工作的 Agent**：不再比"谁先搭出框架"，而是"谁的 Agent 能稳定完成一类真实工作"

---

## 七、Anthropic 的工程哲学

把三篇文章连起来看，Anthropic 的核心工程哲学只有一句话：

> **把"必须靠模型自己自觉"的那部分面积，尽量缩小。**

- 能外移成机制的，就外移成机制
- 能拆成独立子任务的，就别让主循环全背
- 能结构化保存的，就不要只留一段自然语言总结
- 能按相关性回灌的，就别把全部历史重新塞回去

这不是某个 feature 的故事。

这是一套完整的 Agent 工程方法论。

---

## 八、对普通人的启示

你不需要懂代码，也能从这件事里看到趋势：

1. **AI 正在从"聊天工具"变成"工作工具"**——未来你委派给 AI 的不再是一个问题，而是一个任务
2. **平台化会压缩通用工具的空间**——只会搭框架不再值钱，懂业务才是壁垒
3. **工程能力比模型更重要**——同样的模型，在不同系统里表现天差地别

Anthropic 这次提醒我们：

**Agent 的下一步，是从"能回答问题"走向"能接住一项工作"。**

这才是真正值得关注的变化。

---

## 参考资料

- [Anthropic 官方博客：Claude Managed Agents](https://claude.com/blog/claude-managed-agents)
- [Claude API Docs：Managed Agents overview](https://platform.claude.com/docs/en/managed-agents/overview)
- [Anthropic Engineering：Scaling Managed Agents](https://www.anthropic.com/engineering/managed-agents)
- [Sebastian Raschka：Components of a Coding Agent](https://magazine.sebastianraschka.com/p/components-of-a-coding-agent)
- 架构师（若飞）：[Claude Managed Agents 深度解读](https://mp.weixin.qq.com/s/WsNQWXz1_kAQtHRvBtC11Q)
- 架构师（若飞）：[Coding Agent 六大核心组件](https://mp.weixin.qq.com/s/L0fGwMIh4HOXrg-Xi_BcWA)
- 架构师（若飞）：[Claude Code 长任务 Runtime](https://mp.weixin.qq.com/s/SBkOZ2VyHG2Q2BCIJawNIg)
