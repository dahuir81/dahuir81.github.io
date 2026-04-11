# GitHub API 发布工作流

**创建时间**: 2026-03-23  
**用途**: 绕过 `git push` 网络问题，直接通过 API 发布博客文章  
**状态**: ✅ 已验证，可用

---

## 问题背景

`git push` 到 GitHub 在国内网络环境下经常失败：
- `Empty reply from server`
- `Error in the HTTP2 framing layer`
- 连接超时

**根本原因**: GitHub 的 HTTPS 端点在国内不稳定

---

## 解决方案: GitHub API 直接上传

### 核心思路

```
本地 Markdown 文件 → Base64 编码 → GitHub API PUT → 自动部署
```

绕过 `git push`，直接调用 GitHub REST API 创建/更新文件。

### API 端点

```
PUT https://api.github.com/repos/{owner}/{repo}/contents/{path}
```

### 请求参数

| 参数 | 说明 |
|------|------|
| `message` | Commit 消息 |
| `content` | Base64 编码的文件内容 |
| `branch` | 目标分支（如 `main`） |
| `sha` | 可选，更新已有文件时需要 |

### 命令示例

```bash
# 1. Base64 编码文件内容
CONTENT=$(base64 -i "文章.md")

# 2. 调用 API 创建文件
curl -s -X PUT \
  -H "Authorization: token YOUR_GITHUB_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  -d "{\"message\":\"add: 文章标题\",\"content\":\"$CONTENT\",\"branch\":\"main\"}" \
  "https://api.github.com/repos/dahuir81/dahuir81.github.io/contents/content/posts/文章.md"
```

---

## 完整发布脚本

```bash
#!/bin/bash
# upload-post.sh - 单篇文章上传

FILE="$1"
TOKEN="ghp_xxxxxxxxxxxxxxxxxxxx"
REPO="dahuir81/dahuir81.github.io"

# Base64 编码
CONTENT=$(base64 -i "$FILE")

# 提取标题
TITLE=$(grep "^title:" "$FILE" | head -1 | sed 's/title: "//;s/"$//')

# 上传
curl -s -X PUT \
  -H "Authorization: token $TOKEN" \
  -H "Accept: application/vnd.github+json" \
  -d "{\"message\":\"add: $TITLE\",\"content\":\"$CONTENT\",\"branch\":\"main\"}" \
  "https://api.github.com/repos/$REPO/contents/content/posts/$(basename $FILE)"
```

---

## 对比: 传统方案 vs API 方案

| 维度 | `git push` | GitHub API |
|------|-----------|------------|
| 网络依赖 | 高（易失败） | 中（API 端点相对稳定） |
| 配置复杂度 | 需 SSH/Token | 只需 Token |
| 错误处理 | 难定位 | API 返回明确错误码 |
| 批量操作 | 原生支持 | 需脚本实现 |
| 适用场景 | 网络良好时 | 网络受限时 |

---

## 注意事项

1. **Token 安全**: 不要硬编码在脚本中，使用环境变量
2. **Rate Limit**: GitHub API 有调用限制（每小时 5000 次）
3. **文件大小**: 单个文件最大 100MB
4. **更新文件**: 需要提供 `sha` 参数（获取现有文件 sha）

---

## 验证记录

- **2026-03-23**: 成功发布 `2026-03-23-wechat-openclaw-integration.md`
- **文章数量**: 本地 30 篇已全部同步到 GitHub
- **部署状态**: GitHub Actions 自动构建成功

---

## 参考链接

- [GitHub API - Create or update file contents](https://docs.github.com/en/rest/repos/contents#create-or-update-file-contents)
- [Personal Access Token 创建](https://github.com/settings/tokens)

---

**散热正常，慧哥。** 🧊
