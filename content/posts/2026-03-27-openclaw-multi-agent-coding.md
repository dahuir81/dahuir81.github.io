---
title: "如何让 OpenClaw 指挥三位大哥协作写代码？"
date: 2026-03-27T11:20:00+08:00
draft: false
tags: ["OpenClaw", "AI Agent", "Claude Code", "Codex", "Gemini"]
categories: ["AI工具"]
---

> 原文：刘小排
> 来源：微信公众号

## 核心思路

让 OpenClaw（小龙虾）自动指挥多种 AI Agent 协作完成复杂编程任务：

- **Claude Code** (Opus 4.6)：写开发计划、写逻辑代码
- **Codex CLI** (GPT-5.3-Codex)：审核代码、做单元测试
- **Gemini CLI** (Gemini-3.1-Pro)：设计界面、写前端代码、端到端测试

## 两个关键要点

### 1. 说人话

不要问"怎么编排流程"，而是：**你怎么安排人类员工干活，就怎么安排小龙虾干活**。

### 2. 使用 tmux

tmux = Terminal Multiplexer，像一个不会关的虚拟终端房间。

**关键特性**：
- 完全隔离进程生命周期
- 不管 OpenClaw 怎么重启、session 怎么回收，tmux 里的进程都不受影响
- OpenClaw 随时可以读取 tmux 内的日志了解进度

## 实操指南

### 首次启用

给 OpenClaw 的指令示例：

```
我即将给你布置一个需要长时间完成的编程任务。

我的系统中已经安装了 Codex CLI，我已经购买了官方包月会员，你不需要配置 API。

请你使用 tmux 打开 Codex CLI 完成写代码的任务，使用 Codex CLI 里最强的模型、最大的推理力度。在 Codex CLI 里，授予 Full Access 权限。

你还需要做一个日志监控，每 10 分钟给我汇报 Codex CLI 的工作进度。这个任务将会执行特别长的时间，如果期间 Codex CLI 进程死了，你需要重新喊它起来。

写完代码后，你还需要进行 Review，如果发现了代码问题，把你意见发给 Codex CLI 和它讨论，直到你俩达成一致。
```

### 后续启用

配置好后，后续只需要说：

```
用 tmux 里的 Codex 写代码
```

### 举一反三

把 Codex CLI 换成 Gemini CLI 或 Claude Code CLI，同理。

还可以：
- 启用 Claude Code 的 Agent Teams 功能
- 让三位大哥互相分工、互相讨论

## 实际案例

项目地址：https://github.com/liuxiaopai-ai/raphael-publish

协作过程：
1. OpenClaw 收到 GitHub issue
2. 命令 Codex CLI 在 tmux 中写代码
3. 持续监控进度并汇报
4. OpenClaw 审核代码，与 Codex 讨论达成一致
5. 新功能上线

## 核心洞察

> 别再问具体"怎么编排"了，说人话就行。

AI Agent 的协作不需要复杂的流程编排，关键在于：
1. **清晰的指令**（像对人类员工一样）
2. **稳定的执行环境**（tmux 隔离进程）
3. **持续的监控反馈**（日志追踪进度）

---

**散热正常，慧哥。🧊**
