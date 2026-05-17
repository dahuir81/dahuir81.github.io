# HTML 发布流程（供 AI 执行用）

## 仓库结构

```
blog/
├── static/            # 发布目录：HTML 文件放这里
│   └── [file].html    # → https://dahuir81.github.io/[file].html
├── PUBLISH.md         # 本文件（发布流程）
├── README.md
└── ...
```

⚠️ **关键规则**：文件必须放 `static/` 目录，放根目录会 404。

---

## 完整发布流程

### Step 1 — 准备 HTML

- 文件放到 `static/[文件名].html`
- 文件名用英文短横线式，如 `ai-token-economy.html`
- 自包含：所有 CSS 内嵌 `<style>`，无外部依赖
- 暗色主题，820px 最大宽度

### Step 2 — 推送到 GitHub

通过 GitHub API 创建/更新 `static/[file].html`。

构建方式：GitHub Actions 自动构建 Hugo 站点。

### Step 3 — 本地执行（如可访问 Mac mini 文件系统）

```bash
# 复制到 blog 根目录（发布脚本要求）
cp ~/Documents/GitHub/blog/static/[file].html ~/Documents/GitHub/blog/[file].html

# 运行发布脚本
~/.openclaw/workspace/skills/html-publish/publish-html.sh [file].html

# 更新发布清单索引
~/.openclaw/workspace/skills/html-release/scripts/update-index.sh [file].html
```

### Step 4 — 归档到知识库（如可访问 Mac mini）

| 归档项 | 路径 | 方式 |
|--------|------|------|
| 文件本体 | `KnowledgeBase/05-博客/[file].html` | publish-html.sh 自动完成 |
| 发布清单 | `KnowledgeBase/08-参考/发布清单/README.md` | update-index.sh 自动完成 |
| 每日记录 | `KnowledgeBase/01-每日记录/YYYY-MM-DD.md` | 手动记录 |

### Step 5 — 交付链接

| 网址 | 用途 |
|------|------|
| `https://dahuir81.github.io/[file].html` | 国际访问 |
| `https://openclawmy.work/[file].html` | 国内访问（ECS 自动同步，约15分钟延迟） |

---

## 关键路径速查

| 项目 | 路径 |
|------|------|
| 博客仓库 | `~/Documents/GitHub/blog/` |
| 发布目录 | `~/Documents/GitHub/blog/static/` |
| 发布脚本 | `~/.openclaw/workspace/skills/html-publish/publish-html.sh` |
| 索引更新脚本 | `~/.openclaw/workspace/skills/html-release/scripts/update-index.sh` |
| 知识库归档 | `~/Documents/Tars/KnowledgeBase/05-博客/` |
| 发布清单 | `~/Documents/Tars/KnowledgeBase/08-参考/发布清单/README.md` |
| 每日记录 | `~/Documents/Tars/KnowledgeBase/01-每日记录/` |

## 常见问题

- **问**：文件发布后 404？
  **答**：检查文件是否放在 `static/` 目录，根目录会 404。
- **问**：更新已有页面内容？
  **答**：重新推送覆盖 `static/` 下的同一文件即可，GitHub Actions 自动重新构建。
- **问**：ECS 镜像不同步？
  **答**：等待 15 分钟自动同步周期，或手动触发 ECS 同步脚本。
