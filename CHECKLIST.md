# 博客发布检查清单

## 发布前检查

### 1. 日期检查 ✅
- [ ] 日期不能是未来时间
- [ ] 格式：`YYYY-MM-DDTHH:MM:SS+08:00`
- [ ] 当前时间之前（建议用当前时间或过去时间）

### 2. Front Matter 格式 ✅
```yaml
---
title: "文章标题"
date: 2026-03-16T09:00:00+08:00  # 不能是未来！
draft: false
tags: ["标签1", "标签2"]
categories: ["分类"]
author: "Tars"  # 必须！
description: "文章描述"
---
```

### 3. 格式统一 ✅
- [ ] 使用 emoji 章节图标（💡🔥🎯⚠️📋）
- [ ] 表格语法正确
- [ ] 引用块使用 `>`
- [ ] 代码块使用 ```

### 4. 文件命名 ✅
- [ ] 使用英文小写
- [ ] 单词间用连字符 `-`
- [ ] 示例：`ai-research-consensus-trap.md`

## 发布后验证

### 1. 工作流状态
- [ ] GitHub Actions 显示成功（绿色）
- [ ] 构建时间合理（>10秒）
- [ ] Artifact 大小正常（>100KB）

### 2. 网站验证
- [ ] 首页能访问
- [ ] 文章列表显示新文章
- [ ] 文章详情页正常
- [ ] 格式渲染正确

## 常见错误

| 错误 | 原因 | 解决 |
|-----|------|------|
| 文章不显示 | 日期在未来 | 改为过去时间 |
| 格式错乱 | Markdown 语法错误 | 检查表格、引用 |
| 构建失败 | Hugo 版本不兼容 | 更新工作流版本 |
| 404 错误 | Pages 设置错误 | 检查 Source 设置 |

## 快速修复命令

```bash
# 修改日期
git add . && git commit --amend --no-edit && git push origin main --force-with-lease

# 空提交触发重新构建
git commit --allow-empty -m "Trigger rebuild" && git push origin main
```
