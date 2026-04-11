# Hermes Agent

**定义**: Nous Research于2026年2月推出的开源自主Agent智能体，GitHub已超4万星  
**提出者**: [[Nous Research]]  
**提出时间**: 2026-02  
**GitHub**: https://github.com/nousresearch/hermes-agent  
**标签**: #开源Agent #AI操作系统 #Nous-Research

---

## 六大核心特性

1. **与你同在** — 私有、常驻的Agent
2. **越用越强** — 任务轨迹反哺训练
3. **定时自动化** — 可配置定时执行
4. **委派与并行** — 多任务协同
5. **沙盒隔离** — 安全执行环境
6. **全网页与浏览器控制** — 完整的UI交互能力

## 三层学习闭环

### 第一层：记忆
- `MEMORY.md` + `USER.md` 长期记忆文件
- 基于FTS5的跨会话检索 + 大模型摘要
- 不会开新会话就"失忆"

### 第二层：技能
- 完成复杂任务后自动回顾，提取关键步骤
- 整理成结构化技能文件
- 技能持续迭代改进
- "别的智能体在消耗上下文，Hermes在沉淀上下文"

### 第三层：训练数据
- 内置批量轨迹生成能力
- 接入Atropos强化学习环境
- 任务轨迹可直接用于训练下一代模型

## 核心slogan

> "一个会跟着你成长的Agent"

## 与OpenClaw的对比

| 维度 | OpenClaw | Hermes Agent |
|------|----------|-------------|
| 架构 | 插件式集成 | 原生Agent |
| 记忆 | 会话级别 | 跨会话持久化 |
| 技能沉淀 | 无 | 自动提取+迭代 |
| 训练反哺 | 无 | 轨迹回收 |
| 安全 | 依赖插件生态 | 沙箱隔离 |
| 开源 | 是 | 是（4万星） |

## 相关文章
- [[2026-04-10-OpenClaw升维-Managed-Agents-Hermes-source|OpenClaw升维：Managed Agents与Hermes Agent的降维打击]]

## 关联概念
- [[Nous Research]] — 开发商
- [[Managed Agents]] — 同期商业竞品
- [[OpenClaw]] — 被对比的传统方案
- [[AI操作系统]] — 架构方向

---
*创建于 2026-04-10 | Tars 知识库*
