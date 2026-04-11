# Anthropic 官方 33 页指南：构建 Skills 最佳实践

**来源**: 微信公众号 - 架构师 (2026-02-14)  
**作者**: 若飞  
**官方文档**: The Complete Guide to Building Skills for Claude (33页 PDF)

---

## 核心定位

**MCP vs Skills 的关系**
- **MCP**: 专业厨房，提供工具、食材、设备、实时数据
- **Skills**: 菜谱，告诉你怎么用这些东西做出一道菜

| 维度 | MCP (连接层) | Skills (知识层) |
|------|--------------|-----------------|
| 作用 | 把 Claude 接入你的服务 | 教 Claude 怎么高效使用你的服务 |
| 提供 | 实时数据访问和工具调用 | 固化工作流与最佳实践 |
| 回答 | Claude 能做什么 | Claude 应该怎么做 |

**关键特性**
- **可组合**: Claude 可能同时加载多个 skill，不能假设"自己是唯一规则"
- **可移植**: 同一套 skill 可在 Claude.ai、Claude Code、API 上工作

---

## 三层渐进式披露 (Progressive Disclosure)

**核心设计思想**: 把"决策信息"做轻，把"执行细节"延迟加载

| 层级 | 内容 | 加载时机 |
|------|------|----------|
| **第一层** | YAML frontmatter | 永远加载，最轻量信息 |
| **第二层** | SKILL.md 正文 | 判断相关时才加载 |
| **第三层** | 关联文件 (references/assets/脚本) | 真正需要时才打开 |

**硬性建议**: SKILL.md 控制在 **5000 词以内**

---

## description: 最重要的部分

**为什么重要**: Claude 只看 frontmatter 里的 description 字段，几十个字决定是否调用

**最小可用格式**:
```yaml
---
name: your-skill-name
description: What it does. Use when user asks to [specific phrases].
---
```

**必须回答两个问题**:
1. **What**: 这个 skill 做什么
2. **When**: 什么时候应该触发

**触发条件**: 用**用户真的会说出来的话**，不是技术术语

**好坏对比**:
- ❌ 坏的: `description: Helps with projects.` (太泛)
- ❌ 坏的: `description: Implements the Project entity model...` (太技术)
- ✅ 好的: `description: Analyzes Figma design files and generates developer handoff documentation. Use when user uploads .fig files, asks for "design specs", "component documentation", or "design-to-code handoff".`

**推荐模板**:
```yaml
description: [交付什么结果]. Use when user [会怎么说/会上传什么]. Do NOT use when [明显不相关的场景].
```

**硬限制**:
- `name`: 必须 kebab-case（小写+短横线）
- `description`: 控制在 **1024 字符以内**
- frontmatter: **禁止 XML 角括号** (< >)
- 名称不能带 "claude" 或 "anthropic"

---

## 用例驱动设计

**正确顺序**: 先想清楚 2-3 个具体用例，再动笔

**每个用例写清三件事**:
1. **Use Case**: 用户要完成什么
2. **Trigger**: 用户会怎么说
3. **Steps + Result**: 按什么步骤做，最后交付什么

**三种 Skill 类型**:

| 类型 | 干什么 | 代表示例 |
|------|--------|----------|
| **文档/资产创建** | 生成统一风格的文档、代码、设计稿 | `frontend-design` |
| **工作流自动化** | 多步骤流程（立项、审查、迭代） | `skill-creator` |
| **MCP 增强** | 为 MCP 工具接入提供领域知识 | `sentry-code-review` |

---

## 技术规则

**最小结构**:
```
your-skill-name/
├── SKILL.md          # 必需
├── scripts/            # 可选
├── references/         # 可选
└── assets/             # 可选
```

**三条最常见的"上传失败"原因**:
1. **SKILL.md 必须叫这个名字** - 大小写敏感
2. **文件夹名必须 kebab-case** - `notion-project-setup` ✅
3. **skill 文件夹里不要放 README.md**

**SKILL.md 推荐结构**:
```markdown
---
name: your-skill
description: [...]
---

# Your Skill Name
## Instructions
### Step 1: [第一步]
具体做什么，成功长什么样。

## Examples
### Example 1: [常见场景]
用户说什么 → 执行什么 → 交付什么。

## Troubleshooting
### Error: [常见报错]
原因是什么，怎么修。
```

**四条最佳实践**:
1. **具体且可操作** - 别写"validate the data"，要写清楚跑哪个脚本、检查哪些字段
2. **包含错误处理** - 把常见报错和解法写进去
3. **明确引用打包资源** - "写查询之前先看 references/api-patterns.md"
4. **关键校验尽量脚本化** - Code is deterministic; language interpretation isn't.

---

## 5 种经过验证的模式

### 模式 1: 顺序工作流编排
适用于步骤必须按顺序走的场景 - 入职、开通、部署、生成报告

### 模式 2: 多 MCP 协调
适用于一个交付需要跨多个服务 - Figma → Drive → Linear → Slack

### 模式 3: 迭代精炼
适用于质量能通过"生成 → 校验 → 修正"提升的场景 - 报告、文档、审计输出

### 模式 4: 上下文感知的工具选择
同一个目标，不同输入选不同工具 - 大文件走云存储、协作文档走 Notion

### 模式 5: 领域特定智能
注入的不是"工具访问"，而是"规则与判断" - 合规检查、风控、安全审计

---

## 测试: 至少做三件事

### 触发测试
- 3-5 条明确请求
- 3-5 条改写请求（同义不同说法）
- 3-5 条不相关请求

**调试技巧**: 直接问 Claude "你什么时候会用这个 skill？"

### 功能测试
用 Given/When/Then 格式写，测:
- 输出是否正确
- 工具调用是否成功
- 错误处理是否有效
- 边缘情况是否兜住

### 性能对比

| 指标 | 无 Skill | 有 Skill |
|------|----------|----------|
| 用户交互 | 每次从零说明流程 | 自动执行工作流 |
| 对话轮数 | 15 轮来回 | 2 个澄清问题 |
| 失败 API 调用 | 3 次重试 | 0 次 |
| Token 消耗 | ~12,000 | ~6,000 |

**省了一半 token，少了十几轮对话**

---

## 分发与定位

**当前分发方式** (2026年1月):
- **个人用户**: 下载 → 压缩 zip → Settings > Capabilities > Skills 上传
- **组织级** (2025年12月上线): workspace 级部署，支持自动更新
- **开发者**: `/v1/skills` API 端点，支持 Claude Agent SDK

**开放标准**:
> "Like MCP, we believe skills should be portable across tools and platforms - the same skill should work whether you're using Claude or other AI platforms."

**定位写法**:
- ✅ 好: "帮你把 30 分钟的手工项目配置压缩到几秒自动完成"
- ❌ 坏: "这是一个包含 YAML 和 Markdown 的文件夹，会调用我们的 MCP 工具"

---

## 常见问题速查表

| 症状 | 原因 | 解法 |
|------|------|------|
| 上传报错 "Could not find SKILL.md" | 文件名不对 | 必须精确到 `SKILL.md` |
| 上传报错 "Invalid frontmatter" | YAML 格式问题 | 检查 `---` 分隔符、引号闭合 |
| 上传报错 "Invalid skill name" | 名称有空格或大写 | 改成 kebab-case |
| Skill 不触发 | description 太泛 | 加入用户实际会说的触发短语 |
| Skill 触发太频繁 | description 太宽 | 加 `Do NOT use for...` |
| Claude 不遵循指令 | 指令太啰嗦 | 关键指令放最前，细节挪到 references/ |
| 响应变慢 | 上下文太大 | SKILL.md 控制在 5000 词以内 |

**Claude 偷懒**: 在用户提示（不是 SKILL.md）里加 "Take your time, quality is more important than speed"

---

## 关键结论

1. **Skill 解决的核心问题**: 怎么让 AI 从"能聊"变成"能干活"
2. **不是写更长的提示词**，而是把工作流变成有结构、可触发、可测试、可分发的"指令包"
3. **MCP 让 AI 能连上工具，Skill 让 AI 知道怎么用工具**
4. **30 分钟做出第一个能用的 Skill，然后迭代**
5. **先单点打透，再横向铺开**

---

**官方资源**:
- PDF: https://resources.anthropic.com/hubfs/The-Complete-Guide-to-Building-Skill-for-Claude.pdf
- 仓库: https://github.com/anthropics/skills
