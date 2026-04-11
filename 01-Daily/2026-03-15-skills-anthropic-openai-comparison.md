# Skills 详解：Anthropic vs OpenAI 思路差异

**来源**: 微信公众号 - 架构师 (2026-03-04)  
**作者**: 若飞

---

## 核心观点

Agent Skills 格式由 Anthropic 发起（agentskills.io），已被 OpenAI Codex、Cursor、GitHub 等 30+ 工具采纳，是跨平台通用标准。

---

## Skill 解决什么问题

**提示词漂移 (Prompt Drift)** - 提示词一开始能用，过两周出问题，复制到别处又长出三套变体。

**核心思路**: 把提示词从对话框搬到文件系统
- 一个文件夹 + 一个 SKILL.md
- 可被版本控制、PR review、跨项目复用

---

## Anthropic 的扩展体系

| 组件 | 做什么 | 加载方式 | 上下文成本 |
|------|--------|----------|------------|
| CLAUDE.md | 常驻规则 | 启动时全量加载 | 每次请求 |
| **Skills** | 可复用知识/工作流 | 按需，渐进式 | 低（用到才加载）|
| Hooks | 确定性脚本 | 事件驱动 | 零 |
| MCP | 连接外部服务 | 启动时加载工具定义 | 每次请求 |
| Subagents | 隔离上下文的独立工作者 | 按需启动 | 与主会话隔离 |

**选择标准**:
- 每次都应该知道 → CLAUDE.md
- 有时候需要 → Skill
- 必须100%执行，不靠模型判断 → Hooks
- 需要外部系统数据/操作 → MCP

---

## OpenAI Codex 的差异

| 维度 | Claude Code (Anthropic) | OpenAI Codex |
|------|------------------------|--------------|
| Skill 定位 | 扩展体系中的一个模块 | 可移植的工作流包 |
| 触发控制 | `disable-model-invocation: true` | `allow_implicit_invocation: false` |
| 确定性动作 | 分离到 hooks | 偏向写进 Skill 的 scripts/ |
| 上下文隔离 | subagents + agent teams | 渐进式披露为主 |
| 元数据 | SKILL.md frontmatter | 额外的 agents/openai.yaml |
| 分发 | plugins + marketplaces | 多级作用域 + skill-installer |

---

## 关键设计原则

### 1. 渐进式披露
Description 写得像路由规则，精确控制加载时机。

### 2. 负面约束比正面要求更具体
用 "NEVER use..." 比 "use good design" 更有效。

### 3. 有副作用的技能必须显式调用
两家共识：`disable-model-invocation: true` 或 `allow_implicit_invocation: false`

---

## frontend-design Skill 示例

**42 行的 SKILL.md 设计要点**:
1. **Design Thinking 环节** - 强制模型先选审美立场（Purpose/Tone/Constraints/Differentiation）
2. **NEVER 清单** - 禁用 Inter/Roboto/Arial、紫色渐变、模板化布局
3. **复杂度对齐** - 极简风格要克制，极繁风格要细节到位

---

## 核心结论

> Skill 不会让模型变得更聪明。它解决的是：让"怎么用好模型"这件事本身变得可复用、可审查、可持续。

- **Anthropic**: 更关心"模型应该管什么、不应该管什么"
- **OpenAI**: 更关心"技能怎么流转起来"

---

**保存时间**: 2026-03-15
