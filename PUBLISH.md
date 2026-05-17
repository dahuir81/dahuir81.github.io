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

## 发布通道选择

优先按执行环境选择通道，不要混用同一次发布动作：

| 通道 | 适用场景 | 做什么 |
|------|----------|--------|
| A. Mac mini 本地脚本 | 能访问 Mac mini 文件系统和脚本 | 放入 `static/`，再运行发布脚本与索引脚本，自动完成知识库归档 |
| B. GitHub 直传 | 不能访问 Mac mini，或只需要先让 GitHub Pages 可访问 | 通过 git 或 GitHub API 更新 `static/[file].html`，归档稍后由 Mac mini/其他 AI 补做 |

⚠️ 不要把文件放到仓库根目录等待 Hugo 发布；根目录 HTML 不会按预期暴露为页面。

---

## 完整发布流程

### Step 1 — 准备 HTML

- 文件放到 `static/[文件名].html`
- 文件名用英文短横线式，如 `ai-token-economy.html`
- 自包含：所有 CSS 内嵌 `<style>`；如需音频/图片，优先内嵌或放在 `static/` 下同级资源目录
- 普通文章页建议暗色主题、820px 最大宽度；报告、仪表盘、演示页可按内容需要使用宽版布局

### Step 2A — Mac mini 本地脚本发布（推荐：可访问 mini 时）

```bash
# 1. 确认文件在 static/
cp /path/to/[file].html ~/Documents/GitHub/blog/static/[file].html

# 2. 复制到 blog 根目录（发布脚本要求）
cp ~/Documents/GitHub/blog/static/[file].html ~/Documents/GitHub/blog/[file].html

# 3. 运行发布脚本
~/.openclaw/workspace/skills/html-publish/publish-html.sh [file].html

# 4. 更新发布清单索引
~/.openclaw/workspace/skills/html-release/scripts/update-index.sh [file].html
```

### Step 2B — GitHub 直传发布（无法访问 mini 时）

把文件更新到 `static/[file].html` 后提交到 `main`。构建方式：GitHub Actions 自动构建 Hugo 站点。

小文件可用 GitHub API 创建/更新：

```bash
gh api repos/dahuir81/dahuir81.github.io/contents/static/[file].html \
  --method PUT \
  --field message="Publish HTML: [file].html" \
  --field content="$(base64 -i static/[file].html)" \
  --field branch="main"
```

较大的自包含 HTML，尤其是内嵌音频/图片的文件，优先用 git 提交推送：

```bash
cd ~/Documents/GitHub/blog
git pull --ff-only --recurse-submodules=no origin main
git add static/[file].html
git commit -m "Publish HTML: [file].html"
git push origin main
```

> 大文件说明：内嵌音频的 HTML 适合走 `git push`，不适合优先走 GitHub API。API 会把文件 base64 包进 JSON，请求体更大，也更容易因网络或大小限制失败。GitHub 单文件硬限制约 100MB；建议独立 HTML 尽量控制在 50MB 以内，超过时考虑拆分音频资源。

### Step 3 — 归档到知识库（如可访问 Mac mini）

| 归档项 | 路径 | 方式 |
|--------|------|------|
| 文件本体 | `KnowledgeBase/05-博客/[file].html` | publish-html.sh 自动完成 |
| 发布清单 | `KnowledgeBase/08-参考/发布清单/README.md` | update-index.sh 自动完成 |
| 每日记录 | `KnowledgeBase/01-每日记录/YYYY-MM-DD.md` | 手动记录 |

如果通过 GitHub 直传发布，且当前 AI 无法访问 Mac mini，可以先跳过归档，并在交付时明确说明“GitHub 已发布，知识库归档待补”。

### Step 4 — 交付链接

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
- **问**：含音频 HTML 是否不适合 git push？
  **答**：不是。含音频导致文件变大，但 `git push` 通常比 GitHub API 更适合发布这种大号自包含 HTML。以前容易出错，常见原因是本地仓库落后远端、子模块脏、网络超时、权限/token 问题，或误把文件放到根目录；不是音频本身不适合 git。
- **问**：仓库里有 `themes/PaperMod` 子模块改动怎么办？
  **答**：不要把子模块改动加入发布提交。只 `git add static/[file].html` 和必要的索引/清单文件。
- **问**：ECS 镜像不同步？
  **答**：等待 15 分钟自动同步周期，或手动触发 ECS 同步脚本。
