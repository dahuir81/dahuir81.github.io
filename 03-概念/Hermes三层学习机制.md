# Hermes 三层学习机制

**类型**: 架构设计 / Agent 记忆分层
**来源**: [[Hermes Agent]] 核心架构
**首次记录**: 2026-04-13，架构师公众号《拆解 Hermes Agent 的三层学习机制》

## 定义
Hermes 将 Agent 的长期记忆拆成三个不同层次，分别解决不同问题，各有独立的存储、召回和更新逻辑。

## 三层架构

### 第一层：事实记忆（Declarative Memory）
- **存储**: `MEMORY.md`（~800 tokens）+ `USER.md`（~500 tokens）
- **内容**: 用户偏好、环境事实、项目约定、工具 quirks、学到的经验
- **召回**: 每次新会话启动时作为 **frozen snapshot** 注入 system prompt
- **特点**: 小而硬，不随会话中途写入改变当前 prompt，保护 prompt cache
- **安全**: 写入前扫描 `_MEMORY_THREAT_PATTERNS`（prompt injection、敏感命令等）
- **写入**: 原子操作（tempfile → fsync → os.replace），带文件锁

### 第二层：会话检索（Session Retrieval）
- **存储**: `~/.hermes/state.db`（SQLite + FTS5 全文索引）
- **内容**: 历史会话消息、对话记录、踩过的坑
- **召回**: 通过 `session_search` 工具按需检索，不主动注入上下文
- **特点**: 是档案室不是随身备忘录，宽查询用 OR 语义，支持 100k 字符窗口截断
- **零成本模式**: 不传 query 时返回最近会话列表，不调 LLM

### 第三层：过程记忆（Procedural Memory）
- **存储**: `~/.hermes/skills/`（SKILL.md + scripts/references/templates/assets/）
- **内容**: 某类任务的可复用流程（触发条件、步骤、失败模式、验证方法）
- **召回**: 任务匹配时自动加载
- **操作**: create / patch / edit / delete / write_file / remove_file
- **触发**: 累计 10 次工具调用迭代后，后台 fork review agent 静默评估
- **安全**: `tools.skills_guard` 安全扫描，不通过的写入会被回滚

## 关键设计决策

| 决策 | 说明 |
|------|------|
| frozen snapshot | 会话启动时冻结 memory 内容，中途写入不影响当前 prompt，保护 prompt cache |
| 后台 review | 经验沉淀不抢主任务注意力，主任务完成后后台 fork review agent |
| 分层边界 | 事实进 memory，历史靠 search，流程进 skill，不混在一起 |
| skill 生命周期 | 创建→修补→过时→删除，默认不是永久正确的 |

## 与 OpenClaw 的对比

| 维度 | OpenClaw | Hermes |
|------|----------|--------|
| 事实记忆 | MEMORY.md + memory_search + Honcho | MEMORY.md + USER.md（frozen snapshot） |
| 会话检索 | 实验性 dreaming + memory_search | SQLite + FTS5 session_search |
| 过程记忆 | Skills（人工定义，系统治理） | skill_manage（自动沉淀 + 后台 review） |
| 学习闭环 | 部分（Honcho、dreaming 实验性） | 完整（nudge → review → create/patch → scan） |

## 核心价值
**长期信息拆开看**。事实太多污染上下文，历史每次都带浪费 token，流程不维护会固化错误 SOP。混在一起管理迟早出问题。

## 关联
- 相关项目: [[Hermes Agent]]
- 相关概念: [[程序性记忆]]、[[frozen snapshot]]、[[session_search]]、[[skill_manage]]、[[closed learning loop]]
- 对比: [[OpenClaw]] 的 memory_search / dreaming / Honcho
- 来源文章: [[2026-04-13-Hermes三层学习机制-source|拆解 Hermes Agent 的三层学习机制]]
