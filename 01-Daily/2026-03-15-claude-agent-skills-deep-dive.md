# Claude Agent Skills 深度剖析

**来源**: 微信公众号 - 架构师 (2026-02-17)  
**作者**: 若飞  
**参考**: Han Lee "Claude Agent Skills: A First Principles Deep Dive"

---

## 太长不看版

1. **Skill 的本质**: 提示词扩展，不是函数调用。系统把 `SKILL.md` 内容按需注入对话上下文，让模型"临时学会一套做法"

2. **元工具设计**: 管理所有技能的是名为 `Skill` 的元工具。模型先看到"通讯录"（名称+简介），选中后才加载完整"操作手册"
3. **选择机制**: 完全依赖 LLM 语言理解——没有路由器、正则、分类器，决策发生在 Transformer 前向传播中
4. **双重注入**: 一次调用同时改写：对话上下文（注入指令与工作流）+ 执行上下文（临时放行工具权限、可选切换模型）
5. **代价**: 每次注入额外消耗 1500+ tokens；技能越多，歧义与误触发越难避免
6. **工程启示**: 把 Skill 当成"可版本化的配置资产"运营，不是写完扔那里

---

## Skill  vs Tools 核心区别

| 维度 | Tools | Skills |
|------|-------|--------|
| 执行方式 | 调用后同步执行，返回即时结果 | 先注入指令（提示词扩展），再由模型按指令执行 |
| 核心价值 | 做一个动作 | 指导一类工作流 |
| 返回值 | 操作结果 | 对话上下文 + 执行上下文变更 |
| 典型例子 | `Read`、`Write`、`Bash` | `skill-creator`、`internal-comms` |
| 并发安全 | 通常安全 | 不保证并发安全 |
| Token 开销 | 很小（约 100 tokens） | 显著（约 1500+ tokens/次）

**一句话**: Tools 直接解决问题，Skills 让模型准备好去解决问题

---

## 元工具设计：渐进式披露

**问题**: 如果所有技能都塞进 prompt
- 20个技能 × 2000 tokens = 40000 tokens 预加载
- 用户一次只用1-2个，其余全是浪费
- 过长提示词让模型"抓不住重点"

**Claude Code 方案**: "通讯录 + 叫号系统"
- 启动时只汇总：名称 + 一句话简介
- 真正用时再动态加载 `SKILL.md` 正文

**实现细节**:
- 通讯录嵌入在 `Skill` 元工具的 `description` 字段
- 作为 API 请求中 `tools` 数组的一部分
- 决策纯靠 LLM 推理，无正则/向量/分类器

---

## 双重上下文注入

### 对话上下文注入
**矛盾**: 模型需要几千字详细指令，但用户不需要看到刷屏
**解决**: 拆成两条消息

**第一条（给人看）** - `isMeta: false`，UI 可见
**消息序列**:
1. `tool_use`: Agent 调用 Skill Tool
2. `tool_result`: 返回 "Launching skill: xxx"
3. `user message`: `SKILL.md` 完整内容作为新 user message 注入

**执行上下文修改**:
通过 `contextModifier` 函数：
- **放行工具权限** (`allowed-tools`): 临时授予特定命令
- **切换模型**: 复杂任务切到 Opus
**安全关键**: 改变的是权限边界，不只是文字

**完整调用链路**:
```
① 用户: "帮我看一下这个飞书文档"
② Agent 读到 <available_skills> 列表
   → 看到 "feishu-docx": Export Feishu/Lark cloud documents...
   → 推理: 这个任务需要 feishu-docx 技能
③ Agent 调用 Skill Tool: command: "feishu-docx"
④ 系统验证: 存在 ✓ | 类型 prompt ✓ | 未禁用 ✓ | 权限检查 → 用户批准
⑤ 系统加载 SKILL.md:
   - 元数据（可见）: "正在加载 feishu-docx skill"
   - 完整指令（隐藏）: 怎么安装、调用、输出格式
⑥ 系统修改执行上下文: 放行工具权限
⑦ 完整消息数组发送到 API
⑧ Agent 执行: Bash(feishu-docx export "https://...") → 获取结果
```

---

## 常见失败排查

| 问题 | 原因 | 解法 |
|------|------|------|
| 没触发 | 缺 description 或被 `disable-model-invocation: true` | 检查 frontmatter |
| 触发错了 | description 语义撞车 | 写清"边界"：不光说"做什么"，还说"不做什么" |
| 触发了但没跑对 | 步骤不够确定性，或工具输出不结构化 | SKILL.md 写可执行步骤，工具输出结构化 |

---

## 关键字段

### description
- 决定模型能不能找到技能
- 用清晰、面向动作的语言
- 例: "Guide for creating effective skills. This skill should be used when users want to create a new skill..."

### allowed-tools
- **是权限边界，不是便利清单**
- 最小化原则：
  - ✅ `"Read,Write,Edit,Glob,Grep"`
  - ✅ `"Bash(git status:*),Bash(git diff:*),Read,Grep"`
  - ❌ `"Bash,Read,Write,Edit,Glob,Grep,WebSearch,Task,Agent"`

### SKILL.md 结构
```markdown
# 简要用途说明
## Overview
## Prerequisites
## Instructions
### Step 1: [动作]
### Step 2: [动作]
## Output Format
## Error Handling
## Examples
## Resources
```

**最佳实践**:
- 正文控制在 5000 词（约 800 行）
- 祈使句（"分析代码中的..."）而非第二人称
- 外部文件用 `{baseDir}` 占位
- 复杂操作放 `scripts/` 目录

### 目录结构
```
my-skill/
├── SKILL.md          # 核心提示词与指令
├── scripts/            # 可执行脚本
├── references/         # 参考文档（会被 Read 进上下文，占 tokens）
└── assets/             # 模板与静态资源（只按路径引用，不占 tokens）
```

### 特殊字段
- `disable-model-invocation: true` - 手动调用，适合危险操作
- `mode: true` - 模式命令，出现在列表顶部
- `model` - 指定执行模型（如切到 Opus）

---

## 技能多了怎么管

### 可观测性
- 触发哪个 skill + 用户意图原文
- 注入多少 token
- 工具调用次数、失败原因、重试次数
- 中间产物（结构化日志）

### 歧义与冲突治理
- description 写成"任务边界"
- 分层：L0（读取）、L1（写文件）、L2（跑命令）

### 并发安全
- Skills **不保证并发安全**
- 避免技能互相覆盖指令

### 版本化与回滚
- `SKILL.md` 加版本号、变更日志
- 用 git 管理配置文件

---

## 设计模式

1. **脚本自动化**: 复杂操作放 `scripts/` 目录
2. **读取-处理-写入**: 读输入、转换、写输出
3. **搜索-分析-报告**: Grep 搜索 → 读取 → 分析 → 生成报告
4. **向导式多步工作流**: 拆阶段，每阶段用户确认
5. **迭代深化**: 第一遍广度扫描，第二遍深度分析

---

## 落地清单（12件事）

1. 技能分层（L0-L2），默认只自动触发低风险
2. description 写清"边界"和"不做什么"
3. `allowed-tools` 最小化，限制到命令模式
4. 高风险技能默认 `disable-model-invocation: true`
5. 工具输出结构化，schema 写进 `SKILL.md`
6. 明确失败处理：何时重试、换工具、停止
7. 观测做成默认：触发、开销、tool_calls、上下文
8. 写文件/改配置/发请求做二次确认
9. 常见输入做校验与纠错
10. 技能多了做"目录化"：按业务域/角色/风险等级
11. 建最小评测集：10-30条真实任务定期回归
12. 把技能当团队资产：有人 review、维护、负责

---

## 关键结论

> "By treating specialized knowledge as prompts that modify conversation context and permissions that modify execution context rather than code that executes, Claude Code achieves flexibility, safety, and composability that would be difficult with traditional function calling."
> — Han Lee

- Skill 对模型推理、指令遵循、多步规划能力要求很高
- 小尺寸模型验证 Skill 功能 → 建议放弃
- 从低风险技能起步，先打稳"可观测性 + 权限最小化 + 结构化输出"
- 优雅归优雅，生产环境需要补很多地基

---

**原文**: https://mp.weixin.qq.com/s/ZxruvaCgBdxWnm_1yum2Ww  
**参考**: https://leehanchung.github.io/blogs/2025/10/26/claude-skills-deep-dive/
