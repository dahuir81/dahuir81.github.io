# AGENTS.md — Knowledge 库统一规则

**适用于**: Tars (Openclaw) / Claudian (Obsidian插件) / Claude Code / 手工操作
**生效日期**: 2026-04-11
**知识库根目录**: `~/Documents/Tars/KnowledgeBase/`

---

## 一、目录结构速查

```
KnowledgeBase/
├── 00-MOC.md                    # 主导航入口
├── Clippings/                   # Obsidian Web Clipper 默认保存目录
├── 01-每日记录/                    # YYYY-MM-DD.md
├── 02-实体/                        # 人物、公司、产品、技术
├── 03-概念/                        # 方法论、架构、模式、理论
├── 04-原文资料/                    # 抓取的原始文章（不可变）
├── 05-博客/                    # 按 YYYY-MM 子目录
├── 06-人物/                        # 人物档案
├── 07-项目/                        # 项目文档、工作建议、专题研究
├── 08-参考/                    # 简报/研报摘要/数据表分析（非博客类），按主题分子目录
├── 09-归档/                        # 历史归档
├── content/posts/               # Hugo 博客源文件（发布用）
├── templates/                   # 文件模板
└── index.md / log.md            # 索引和操作日志（保留兼容）
```

---

## 二、文件命名规范

| 类型 | 命名格式 | 示例 |
|------|---------|------|
| 每日记录 | `YYYY-MM-DD.md` 或 `YYYY-MM-DD-摘要.md` | `2026-04-11-feishu-blog-publish.md` |
| 实体 | `实体名称.md` | `Anthropic.md` |
| 概念 | `概念名称.md` | `光学压缩.md` |
| 原文资料 | `YYYY-MM-DD-标题-source.md` | `2026-04-11-DeepSeek-V4-source.md` |
| 博客归档 | `YYYY-MM-DD-标题.md` | `2026-04-11-deepseek-v4.md` |
| 人物档案 | `姓名.md` | `慧哥.md` |

---

## 三、YAML Frontmatter 模板

**所有新建文件**必须在头部添加 frontmatter：

```yaml
---
title: "文件标题"
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags: [标签1, 标签2]
source: "来源URL"
status: draft | active | done | archived
channel: tars | claudian | claude-code | manual
---
```

---

## 四、标签体系

| 标签 | 用途 | 对应目录 |
|------|------|---------|
| `#daily` | 每日记录 | 01-每日记录/ |
| `#entity` | 实体页面 | 02-实体/ |
| `#concept` | 概念页面 | 03-概念/ |
| `#source` | 原文资料 | 04-原文资料/ |
| `#blog` | 博客归档 | 05-博客/ |
| `#person` | 人物档案 | 06-人物/ |
| `#project` | 项目文档 | 07-项目/ |
| `#reference` | 参考资料 | 08-参考/ |
| `#archive` | 归档内容 | 09-归档/ |
| `#insight` | 核心洞察/教训 | 任意文件 |
| `#todo` | 待办事项 | 01-每日记录/ |

---

## 五、Wikilink 规则

- **必须使用 `[[文件名]]` 格式**，不用 `[]()`
- 跨目录引用：`[[02-实体/DeepSeek]]`
- 带显示文本：`[[02-实体/DeepSeek|DeepSeek]]`
- 带标题锚点：`[[03-概念/光学压缩#核心原理]]`

---

## 六、工作流程

### 6.1 链接处理（Tars 主流程）

```
收到链接
  ↓
1. 抓取全文 → 存档到 04-原文资料/YYYY-MM-DD-标题-source.md
  ↓
2. Claudian 日常整理：
   - 提取实体 → 02-实体/（新建或更新）
   - 提取概念 → 03-概念/（新建或更新）
   - 更新 00-MOC.md 索引
  ↓
3. 用户说"发布博客"？
   ├─ 是 → 走 6.2 博客发布流程
   └─ 否 → 结束，通知完成
```

### 6.2 博客发布流程

```
触发（钉钉/飞书发链接 / 手工撰写）
  ↓
1. 生成 Hugo 格式 → content/posts/YYYY-MM-DD-标题.md
  ↓
2. 发布到 GitHub（git push 或 GitHub API）
  ↓
3. ECS Data cron 15min 自动同步 → openclawmy.work
  ↓
4. 归档到 05-博客/YYYY-MM/YYYY-MM-DD-标题.md
  ↓
5. 更新 00-MOC.md + log.md
  ↓
6. 通知用户（回原渠道）
```

### 6.3 简报/研报归档流程（非博客类内容）

**触发**：慧哥发送数据表/研报PDF/简报截图，未要求发布博客

```
收到非博客类内容
  ↓
1. 加工分析（提取关键数据、洞察、对比）
  ↓
2. 归档到 08-参考/主题/YYYY-MM-DD-简报标题.md
   - 主题按内容领域分类（如 AI芯片/、HBM/、Bloomberg/）
   - 新建主题目录前需确认合理性
  ↓
3. 如有 PDF 原件，同步存档到 04-原文资料/YYYY-MM-DD-标题.pdf
  ↓
4. 识别实体 → 02-实体/（新建或更新）
  ↓
5. 识别概念 → 03-概念/（新建或更新）
  ↓
6. 更新 log.md + 00-MOC.md
  ↓
7. 通知用户完成
```

**关键规则**：
- 简报类内容不进入 `05-博客/`，不发布到外部网站
- 按主题分子目录，不在 `08-参考/` 根目录散放文件
- 简报可以包含表格、数据对比、关键洞察，格式灵活
- 如有对应 PDF 原文，PDF 存 `04-原文资料/`，简报存 `08-参考/`

### 6.4 多渠道通信归档

每次通过钉钉/飞书/Telegram 完成有效交互后：
- 归档到 `01-每日记录/YYYY-MM-DD-渠道-摘要.md`
- 格式见 `templates/daily.md`
- 类型：conversation | briefing | blog-review | knowledge-update

### 6.5 Claudian 日常整理

每日自动执行：
1. 检查 `04-原文资料/` 中未整理的原文
2. 提取02-实体/概念，新建或更新
3. 更新 `00-MOC.md` 和 `log.md`
4. 检查 `01-每日记录/` 是否有遗漏记录

---

## 七、内容不可变规则

**04-原文资料/ 中的原文资料是不可变的原始记录**：
- 不修改、不删除、不覆盖
- 新文章创建新文件
- 原文是知识加工的源头，必须保持原始状态

---

## 八、回顾和归档

| 频率 | 任务 | 执行者 |
|------|------|--------|
| 每次交互后 | 归档到 01-每日记录/ | Tars / Claudian / CC |
| 每日 | Claudian 整理 04-原文资料/ | Claudian |
| 每周 | 回顾 01-每日记录/，提炼洞察 | CC / Tars |
| 每月 | 归档旧文件到 09-归档/ | CC |

---

_所有 AI Agent 必须遵守本文件定义的规则。违反时请立即修正并更新本文件。_
