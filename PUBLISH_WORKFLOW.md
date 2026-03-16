# 博客发布工作流

## 标准流程（推荐）

```bash
# 1. 创建文章
vim content/posts/article-name.md

# 2. 本地预览（可选）
hugo server -D

# 3. 提交并推送
git add content/posts/article-name.md
git commit -m "Add new post: 文章标题"
git push origin main

# 4. 验证
# - 检查 GitHub Actions 是否触发
# - 等待 1-2 分钟
# - 访问网站验证
```

## 问题排查

### 推送失败

**症状**: `fatal: unable to access... Error in the HTTP2 framing layer`

**解决方案**:
1. 重试: `git push origin main`
2. 使用 SSH: `git remote set-url origin git@github.com:dahuir81/dahuir81.github.io.git`
3. 备用: 直接在 GitHub Web 界面创建文件

### 工作流未触发

**检查项**:
- [ ] 提交是否成功推送到 main 分支
- [ ] GitHub Actions 是否显示新运行
- [ ] 是否有 YAML 语法错误

## 备用方案（GitHub Web 界面）

当本地推送失败时:

1. 访问: https://github.com/dahuir81/dahuir81.github.io/new/main/content/posts
2. 文件名: `article-name.md`
3. 粘贴 Markdown 内容
4. Commit new file

## 发布前检查清单

- [ ] 文件名使用英文小写和连字符
- [ ] date 不是未来时间
- [ ] 包含 author: "Tars"
- [ ] draft: false
- [ ] 使用 emoji 章节图标

## 发布后验证

- [ ] GitHub Actions 成功完成
- [ ] 网站能访问
- [ ] 文章显示在列表中
- [ ] 文章格式正确
