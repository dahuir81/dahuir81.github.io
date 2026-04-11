# Hermes Agent

**类型**: 开源项目 / Agent Runtime
**维护方**: [[Nous Research]]
**GitHub**: https://github.com/NousResearch/hermes-agent
**文档**: https://hermes-agent.nousresearch.com/docs/
**最新版本**: v0.8.0 (2026-04-08)

## 核心定位
Agent 自身的执行与学习引擎，强调**长期使用、持续沉淀和自我改进**。

## 与 [[OpenClaw]] 的定位差异
| 维度 | OpenClaw | Hermes Agent |
|------|----------|--------------|
| 核心 | Gateway（网关守护进程） | Agent 执行循环 |
| 重点 | 会话路由、渠道连接 | 工具使用、经验沉淀 |
| 记忆 | 文件即记忆（SOUL.md / MEMORY.md） | SQLite + FTS5 全文检索 |
| Skill | 人工编写 + ClawHub 市场 | Agent 自动沉淀 + 后台 review |
| 安全 | 依赖模型判断 | 七层纵深防御 |

## 核心特性
1. **闭环学习循环**: 系统提示引导 + 后台 review 流程
2. **记忆分层**: MEMORY.md (~800 tokens) + USER.md (~500 tokens) + state.db (无限)
3. **Skill 系统**: 122 个 SKILL.md，26 个类目，支持 skills.sh 和 .well-known 发现
4. **安全模型**: 七层纵深防御（危险命令审批、上下文注入扫描等）
5. **多 Provider 支持**: 15+ 主流 Provider 即时切换（Nous Portal/OpenAI Codex/Anthropic/OpenRouter/智谱/Kimi/MiniMax/通义千问/HuggingFace 等）
6. **低门槛部署**: $5 VPS 可运行，支持 6 种终端后端
7. **Gateway 消息平台**: Telegram/Discord/Slack/WhatsApp/Signal/Email/Home Assistant
8. **语音模式**: CLI 麦克风输入 + TTS 语音回复（faster-whisper / ElevenLabs）
9. **定时任务**: 通过 cron 安排自动化任务
10. **RL 训练**: 内置强化学习微调流程（Tinker/Atropos 后端）
11. **ACP 集成**: 作为 ACP 服务器运行于 VS Code/Zed/JetBrains
12. **MCP 支持**: 通过模型上下文协议连接外部工具服务器

## 关联
- 相关概念: [[Harness]]、[[Skill 系统]]、[[闭环学习循环]]、[[七层纵深防御]]
- 对比项目: [[OpenClaw]]、[[Claude Code]]、[[Codex]]
- 中文文档: https://hermes-doc.aigc.green/ （DracoVibeCoding 翻译维护）
- 来源文章: [[2026-04-09-Hermes Agent架构拆解]]
- 来源文章: [[2026-04-06-你的下一只龙虾何必是龙虾-source|你的下一只龙虾何必是龙虾]]
