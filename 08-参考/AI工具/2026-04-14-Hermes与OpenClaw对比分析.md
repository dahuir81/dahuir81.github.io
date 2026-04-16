---
title: "Hermes 与 OpenClaw 对比分析"
created: 2026-04-14
updated: 2026-04-14
tags: [reference, agent, hermes, openclaw, comparison]
source: "https://mp.weixin.qq.com/s/ImHfehcRBoxMStXmSyE3Vw"
status: active
channel: manual
---

# Hermes 与 OpenClaw 对比分析

**来源**: 微信公众号《林月半子的AI笔记》  
**作者**: [[林月半子]]  
**原文**: [[2026-04-11-OpenClaw已死别急着盖棺-source|OpenClaw已死？别急着盖棺，但我确实被 Hermes 圈粉了]]  
**发布日期**: 2026-04-11

---

## 核心结论

作者不认同 "OpenClaw 已死" 的说法。OpenClaw 凭借 ClawHub 上 5 万多个 Skill 和几千万用户，短期内难以被替代。但作者认为，Hermes 爆火的本质是一群用户受够了 OpenClaw 的稳定性问题，想找更省心的选项。

## 用户视角的两大痛点

### 1. OpenClaw 的稳定性缺陷
- 每次升级常常引入新问题（Gateway 启动失败、手动修配置、重装依赖）
- SOUL.md 的设计哲学依然优秀，但维护成本过高
- "一个工具再聪明，如果每次升级都要花半小时去救它，那它就不是在帮你干活，它在让你给它打工"

### 2. Hermes 的可观测性优势
- 每一步工具调用、命令执行、返回结果都在对话中透明展示
- 工作过程透明，信任感更强

## 为什么选 Hermes？两个核心亮点

### 自改进 Skill

| 特性 | 说明 |
|------|------|
| 自动沉淀 | 任务完成后自动判断是否值得复用，生成 markdown Skill 文件 |
| 永久进化 | 用户反馈后直接修改 `~/.hermes/skills/` 下的文件，而非仅在当次会话中记住 |
| 减少重复 | 避免 80% 的时间浪费在重复教学上 |

### 双层记忆

| 层级 | 组成 | 设计特点 |
|------|------|---------|
| L1 | MEMORY.md + USER.md | 会话开始时作为 frozen snapshot 注入，会话期间不变 |
| L2 | SQLite + FTS5 | 需要时才主动检索，避免历史信息胡乱塞入 prompt |
| L3 | 外持 Mem0 等 | 跨会话用户建模（可选） |

这种设计避免了 "边推理边写"导致的 prompt 污染问题，是 Hermes 工程克制的代表。

## 其他产品细节

- **一键迁移**: 支持从 OpenClaw 无缝迁移记忆和 Skills，几秒完成
- **飞书 Bot 接入**: `hermes gateway setup` 配置飞书，大约十分钟跑通
- **Claude Pro 窗口期**: 目前仍可用 Claude Pro 登录态调用 Sonnet / Opus
- **内置 Karpathy LLM Wiki**: Nous Research 将社区好点子快速内置为 Skill

## 实用命令

| 命令 | 作用 | 注意事项 |
|------|------|---------|
| `/yolo` | 一键免审批（懒人模式） | 仅建议在个人环境使用，生产环境开启有风险 |
| `/personality` | 切换人格（如 technical、kawaii） | 内置 14 种人格 |
| `/title` | 会话命名 | 方便后续 `/resume` 恢复 |
| `/reset` | 清空当前会话开新 session | 会显示当前模型和窗口信息 |
| `/resume` | 跳回命名过的会话 | 必须先用 `/title` 命名 |

## 作者建议

| 用户类型 | 建议 |
|---------|------|
| OpenClaw 老用户 | 强烈建议装一下试试，一键迁移值回票价 |
| OpenClaw 新用户 | 跳过 OpenClaw 直接上 Hermes，学习曲线更短 |
| 完全新手 | Hermes 是不错的入门选择，能真正动手做事 |

## 金句

> "OpenClaw 教会了我们 Agent 是可以被配置出来的，Hermes 在尝试告诉我们 Agent 是可以自己长大的。"

## 关联
- 对比实体: [[Hermes Agent]]、[[OpenClaw]]、[[Claude Code]]
- 相关概念: [[自改进Skill]]、[[双层记忆]]、[[Agent]]
- 作者: [[林月半子]]
