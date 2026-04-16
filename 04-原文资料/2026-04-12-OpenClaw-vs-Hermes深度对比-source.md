# OpenClaw vs Hermes：一文深入理解两大通用 Agent

**来源**: 架构师（JiaGouX）微信公众号  
**原文链接**: https://mp.weixin.qq.com/s/oKuSgz5CP4aPOjt_o2Vi8g  
**抓取时间**: 2026-04-12 23:02  
**抓取工具**: Scrapling (web-content-fetcher skill)

---

## 核心内容

### 太长不看版

- **同一大类**：OpenClaw 和 Hermes 都是通用 Agent 系统，不是聊天机器人或工具集合
- **OpenClaw 核心资产**：Gateway 控制面，覆盖 25+ 聊天渠道、WebChat、macOS/iOS/Android 节点、Live Canvas
- **Hermes 核心资产**：学习型执行循环，self-improving agent、closed learning loop、自动创建和修补 skills、FTS5 会话搜索、Honcho 用户建模、6 种执行后端
- **Skill 语义不同**：OpenClaw 偏"人定义技能，系统加载治理"（SOP 库）；Hermes 偏"Agent 自动把成功路径沉淀为 procedural memory"（工作笔记）
- **安全思路不同**：OpenClaw 走信任模型+配置审计；Hermes 走纵深防御（审批→容器隔离→凭据过滤→注入扫描）
- **Memory 方向**：OpenClaw 是"文件即记忆"笔记本；Hermes 是 SQLite+FTS5 搜索引擎式大脑
- **迁移**：Hermes 支持 `hermes claw migrate` 导入 OpenClaw 的 persona/memory/skills/allowlist 等，但迁移配置≠迁移整套使用方式
- **选型**：缺多入口助理和治理面→OpenClaw；缺长期重复任务经验沉淀和自我改进→Hermes

### 一句话概括

**OpenClaw 管入口和秩序，Hermes 管执行和经验。**

### 系统重心不在同一层

| 层 | OpenClaw | Hermes |
|------|---------|--------|
| **厚度在哪** | 入口、控制面、多设备协同 | 执行循环、技能沉淀、跨会话复用 |
| **核心资产** | Gateway 控制面 | 学习型执行循环 |
| **技术栈** | Node.js / TypeScript | Python 3.11 |

### 团队背景

- **OpenClaw**：Peter Steinberger 创建，2026年2月加入 OpenAI，项目交给社区基金会维护
- **Hermes**：Nous Research 团队，Hermes 3/4 模型缔造者，上线不到两个月

### Hermes 四层机制

1. 当前任务怎么跑 → Agent loop + tool runtime
2. 过去做过什么 → session store + FTS5 搜索召回
3. 哪些流程值得复用 → 沉淀成 skill（procedural memory）
4. 用户长期偏好 → memory provider + Honcho 用户建模

Reddit 用户反馈：Agent 两小时内自动生成三份技能文档后，重复性研究任务速度提升约 40%

### 能力对比摘要

| 维度 | OpenClaw | Hermes |
|------|---------|--------|
| 大类 | 通用 Agent 系统 | 通用 Agent 系统 |
| 核心定位 | 本地优先个人 AI 助手，Gateway 控制面 | self-improving AI agent，学习型执行循环 |
| 入口能力 | 25+ 渠道 + 多平台节点 | CLI + Telegram/Discord/Slack/WhatsApp/Signal/Email |
| 技能体系 | 50+ 内置 skill，加载来源/优先级/gating | 26 类别，自动创建/修补/复用 |
| 记忆方向 | workspace 文件 + 语义检索 | SQLite+FTS5 搜索 + Honcho 建模 |
| 安全策略 | 信任模型 + 配置审计 + allowlist | 纵深防御：审批 + 容器隔离 + 凭据过滤 |
| 模型支持 | 多 provider，OAuth+API key failover | 200+ 模型，一条命令切换 |
| 更适合 | 多渠道助理、设备联动、团队治理 | 长期重复任务、研究流、经验沉淀 |

### 作者观点

> OpenClaw 更像是在回答：Agent 如何进入世界。Hermes 更像是在回答：Agent 如何积累经验。
>
> Agent 框架的竞争，已经从"能不能调用工具"，进入到"能不能管理入口、治理风险、沉淀经验"的阶段。
