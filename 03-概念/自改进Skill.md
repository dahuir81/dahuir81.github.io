---
title: "自改进Skill"
created: 2026-04-14
updated: 2026-04-14
tags: [concept, skill, agent, hermes]
source: "https://mp.weixin.qq.com/s/ImHfehcRBoxMStXmSyE3Vw"
status: active
channel: manual
---

# 自改进 Skill

**定义**: [[Hermes Agent]] 的核心能力之一，Agent 在完成复杂任务后自动将经验沉淀为可复用的 Skill，并根据用户反馈持续优化 Skill 本身。

## 与传统 Skill 的区别

| 特性 | OpenClaw / 传统方式 | Hermes 自改进 Skill |
|------|-------------------|---------------------|
| 生成 | 用户主动发起 | Agent 自动判断生成 |
| 存储 | ClawHub / 手工管理 | `~/.hermes/skills/` markdown 文件 |
| 进化 | 需用户推动 | 根据反馈永久写入 Skill 本身 |
| 复用 | 下次相同场景需重新描述 | 直接调用已沉淀的 Skill |

## 价值
- 减少80%重复教学成本
- "让 Agent 自己记笔记，而不是让你一直当老师"
- 支持官方持续内置新 Skill（如 Karpathy LLM Wiki 工作流）

## 关联
- 相关项目: [[Hermes Agent]]
- 相关概念: [[Skill系统]]、[[Skill化]]
- 来源文章: [[2026-04-11-OpenClaw已死别急着盖棺-source|OpenClaw已死？别急着盖棺，但我确实被 Hermes 圈粉了]]
