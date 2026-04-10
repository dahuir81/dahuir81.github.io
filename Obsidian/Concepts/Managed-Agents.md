# Managed Agents（托管智能体）

**定义**: Anthropic于2026年4月9日推出的全新AI架构，将Agent拆解为Session（会话层）、Harness（框架层）、Sandbox（沙箱层）三个标准组件，实现"大脑"与"双手"的彻底解耦  
**提出者**: [[Anthropic]]  
**提出时间**: 2026-04-09  
**标签**: #AI操作系统 #架构解耦 #Anthropic #Claude

---

## 核心架构

### 三层组件（致敬Unix）

| 组件 | 功能 | 类比 |
|------|------|------|
| **Session** | "仅追加"日志，独立于模型，重启不丢失 | 记忆系统 |
| **Harness** | Agent循环逻辑，调用Claude并分发指令 | 操作系统内核 |
| **Sandbox** | 绝对隔离的计算环境 | 用户空间进程 |

**关键原则**: 大脑（模型）不需要知道手（沙箱）在哪里运行。

## 架构对比

### OpenClaw（传统方案）的痛点
- Harness与模型能力深度耦合
- 模型升级（Sonnet→Opus）导致Harness逻辑变成冗余代码
- 容器内封装所有组件 → "宠物效应"（娇贵不可替代）
- 私钥与代码运行在同一环境 → 安全风险
- 上下文窗口限制长周期任务

### Managed Agents的突破
- 围绕稳定接口构建，Harness变化不影响接口
- 容器变成"牲畜"，Harness本身也可替换
- `execute(name, input) → string` 调用模式
- Token保存在沙箱外部的安全保险库 → Prompt Injection失去物理目标
- 会话即日志 → 突破上下文限制
- 多执行环境并行 → p50 TTFT↓60%，p95 TTFT↓90%+

## 核心特性

### 1. OAuth一键接入
### 2. 云端托管
### 3. 沙箱隔离
### 4. Code Channels远程指挥

## 关键洞察

> "AI本身就是操作系统，工具就是它的外设。"

Managed Agents改变了计算的拓扑结构——从"工具嫁接"到"AI原生系统"。

## 影响

对OpenClaw的影响是**降维打击**：
- Anthropic收紧政策，拿OpenClaw开刀
- 限制通过套餐额度"绕道"支撑外挂Agent
- 必须走按用量计费的API

## 相关文章
- [[2026-04-10-OpenClaw升维-Managed-Agents-Hermes-source|OpenClaw升维：Managed Agents与Hermes Agent的降维打击]]

## 关联概念
- [[OpenClaw]] — 被降维打击的对象
- [[Hermes Agent]] — 同期崛起的开源竞争对手
- [[AI操作系统]] — 架构方向
- [[Harness]] — 框架层组件
- [[Session]] — 会话层组件

---
*创建于 2026-04-10 | Tars 知识库*
