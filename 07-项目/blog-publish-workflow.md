# 博客发布工作流程（核心维护）

**创建时间**: 2026-03-17  
**最后更新**: 2026-03-17  
**重要性**: 高频每日使用  
**状态**: 已验证，长期维护

---

## 一、流程概述

**目标**: 将撰写的文章自动发布到 dahuir81.github.io 博客，并触发通知  
**技术栈**: Hugo + GitHub Pages + GitHub Actions  
**发布方式**: GitHub Web 界面（主方案）/ Git 命令（备用）

---

## 二、博客仓库信息

| 项目 | 详情 |
|------|------|
| 仓库路径 | `~/.openclaw/workspace/blog/` |
| GitHub 仓库 | `dahuir81/dahuir81.github.io` |
| 网站地址 | https://dahuir81.github.io |
| 构建工具 | Hugo (PaperMod 主题) |
| 部署方式 | GitHub Actions → GitHub Pages |

---

## 三、标准发布流程

### 步骤 1: 创建文章文件

#### 博客仓库文件命名规范（GitHub）
```bash
# 格式：日期-文章标题英文小写-连字符.md
content/posts/YYYY-MM-DD-文章标题.md

# 示例
content/posts/2026-03-17-nvidia-gtc-2026.md
content/posts/2026-03-25-alibaba-token-strategy.md
```

#### Obsidian 归档文件命名规范
```bash
# 博客文章归档
05-Blog/YYYY-MM/YYYY-MM-DD-文章标题.md

# 原文资料归档
04-Sources/YYYY-MM-DD-文章标题.md

# 示例
05-Blog/2026-03/2026-03-29-why-rewrite-harness-ai-engineering.md
04-Sources/2026-03-29-模型越来越强为什么大家却开始重写Harness.md
```

**命名规则要点：**
- 必须包含日期前缀 `YYYY-MM-DD-`
- 使用英文小写和连字符
- 避免特殊字符和空格
- 保持文件名简洁明了

### 步骤 2: 文章 Front Matter 模板

```yaml
---
title: "文章标题"
date: 2026-03-17T08:00:00+08:00
draft: false
author: "Tars"
tags: ["标签1", "标签2", "标签3"]
categories: ["技术观察"]
description: "文章摘要，用于SEO和列表展示"
---
```

### 步骤 3: 发布到 GitHub（主方案 - Web 界面）

**原因**: Git push 经常因网络超时失败

1. 打开浏览器: `https://github.com/dahuir81/dahuir81.github.io/new/main/content/posts`
2. 填写文件名: `文章标题.md`
3. 粘贴完整 Markdown 内容
4. Commit message: `Create 文章标题.md`
5. 点击 "Commit changes"

### 步骤 3 备用: Git 命令（网络正常时使用）

```bash
cd ~/.openclaw/workspace/blog
git add content/posts/文章标题.md
git commit -m "Add new post: 文章标题"
git push origin main
```

---

## 四、GitHub Actions 工作流

### 已配置的工作流

| 工作流 | 功能 | 状态 |
|--------|------|------|
| `hugo.yml` | Deploy Hugo site to Pages | ✅ 自动触发 |
| `notify.yml` | Notify After Deploy | ✅ 自动触发 |

### 部署流程

```
GitHub Commit → Actions 触发 → Hugo 构建 → GitHub Pages 部署 → 通知发送
     ↑                                              ↓
   手动/Web                                    约 30-60 秒
```

### 验证部署状态

1. 访问: https://github.com/dahuir81/dahuir81.github.io/actions
2. 查看最新运行状态
3. 确认 "Deploy Hugo site to Pages" 成功

---

## 五、通知系统

### 通知方式

| 方式 | 配置 | 状态 |
|------|------|------|
| 飞书 | GitHub Actions → OpenClaw Gateway | ✅ 自动发送 |

### 通知触发

- GitHub Actions `notify.yml` 在部署成功后自动触发
- 通过 OpenClaw Gateway 发送飞书消息
- **已移除邮件通知**（原 notify.sh 含硬编码 SMTP 授权码，已迁移至 GitHub Secrets 管理）

---

## 六、常见问题

### 问题 1: Git push 超时

**症状**: `fatal: unable to access... Error in the HTTP2 framing layer`

**解决**: 使用 GitHub Web 界面发布（主方案）

### 问题 2: Actions 未触发

**检查项**:
- [ ] 文件是否成功 commit 到 main 分支
- [ ] GitHub Actions 是否显示新运行
- [ ] 文件路径是否正确 (`content/posts/`)

### 问题 3: 文章未显示

**排查**:
1. 检查 front matter 是否有 `draft: false`
2. 检查 date 是否为未来时间
3. 等待 1-2 分钟后刷新页面

---

## 七、文章格式规范

### 标题层级

```markdown
# 一级标题（文章主标题，Hugo 自动生成）
## 二级标题（章节）
### 三级标题（小节）
```

### 特色元素

- **加粗**: `**重点内容**`
- *斜体*: `*强调内容*`
- 引用: `> 引用内容`
- 代码块: 三个反引号
- 表格: Markdown 表格语法
- 链接: `[文字](URL)`

### 结尾格式

```markdown
---

**参考来源：**
- 来源1
- 来源2

---

*Published by Tars | YYYY-MM-DD*
```

---

## 八、历史记录

| 日期 | 事件 |
|------|------|
| 2026-03-15 | 博客仓库初始化，Hugo + PaperMod 主题配置 |
| 2026-03-15 | GitHub Actions 配置完成 (hugo.yml, notify.yml) |
| 2026-03-16 | 首次成功发布文章，验证全流程 |
| 2026-03-17 | 发布 GTC 2026 分析文章，确认 Web 界面方案为主 |
| 2026-03-29 | 统一 Obsidian 文件命名规范，全部加上日期前缀 |
| 2026-04-13 | 安全修复：移除 notify.sh（SMTP 授权码泄露），迁移至 GitHub Secrets |

---

## 九、相关文件

- `~/.openclaw/workspace/blog/PUBLISH_WORKFLOW.md` - 发布流程文档
- `~/.openclaw/workspace/blog/hugo.toml` - Hugo 配置
- `~/.openclaw/workspace/blog/.github/workflows/hugo.yml` - Actions 配置
- `~/.openclaw/workspace/blog/.github/workflows/notify.yml` - 通知配置

---

**记忆锚点**: 博客发布 → Hugo → GitHub Pages → Web界面 → Actions自动部署 → 飞书通知

*维护者: Tars | 更新频率: 每次发布时验证*