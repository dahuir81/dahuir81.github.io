#!/bin/bash
# 统一博客发布脚本 - 双通道自动fallback
# 通道1: git push (网络正常时最快)
# 通道2: GitHub API (网络受限时兜底)
# 使用方法: ./publish.sh [文件名.md]

set -e

# 加载环境变量
ENV_FILE="$HOME/.openclaw/.env"
if [ -f "$ENV_FILE" ]; then
    source "$ENV_FILE"
fi

# 配置
TOKEN="${GITHUB_TOKEN:-}"
REPO="dahuir81/dahuir81.github.io"
POSTS_DIR="content/posts"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# 检查参数
if [ -z "$1" ]; then
    echo "用法: ./publish.sh <文件名.md>"
    echo "示例: ./publish.sh 2026-03-23-new-post.md"
    echo ""
    echo "支持传入完整路径或仅文件名，自动在 content/posts/ 下查找"
    exit 1
fi

if [ -z "$TOKEN" ]; then
    echo "❌ GITHUB_TOKEN 未配置"
    echo "请在 $ENV_FILE 中设置 GITHUB_TOKEN"
    exit 1
fi

FILE="$1"
FILENAME=$(basename "$FILE")

# 查找文件
if [ ! -f "$FILE" ]; then
    if [ -f "$SCRIPT_DIR/$POSTS_DIR/$FILENAME" ]; then
        FILE="$SCRIPT_DIR/$POSTS_DIR/$FILENAME"
    elif [ -f "$POSTS_DIR/$FILENAME" ]; then
        FILE="$POSTS_DIR/$FILENAME"
    else
        echo "❌ 文件不存在: $FILENAME"
        echo "在以下位置查找均未找到:"
        echo "  - $SCRIPT_DIR/$POSTS_DIR/$FILENAME"
        echo "  - $POSTS_DIR/$FILENAME"
        exit 1
    fi
fi

echo "📄 发布文件: $FILENAME"

# 提取标题
TITLE=$(grep "^title:" "$FILE" | head -1 | sed 's/^title: *["'\''"]//;s/["'\''"]$//' | tr -d '"' | cut -c1-50)
if [ -z "$TITLE" ]; then
    TITLE="$FILENAME"
fi
echo "📝 文章标题: $TITLE"

# 提取frontmatter中的slug（如果有）
SLUG=$(grep "^slug:" "$FILE" | head -1 | sed 's/^slug: *//;s/["'\'']//g' | tr -d '"' | tr -d "'")
if [ -n "$SLUG" ]; then
    URL_SLUG="$SLUG"
else
    URL_SLUG="${FILENAME%.md}"
fi

# ============================================
# 通道1: git push
# ============================================
echo ""
echo "🔄 通道1: git push..."
cd "$SCRIPT_DIR"

# 检查文件是否已暂存
if ! git status --porcelain "$FILE" | grep -q "^.A\|^?."; then
    git add "$FILE" 2>/dev/null || true
fi

# 检查是否有未提交的变更
if git status --porcelain "$FILE" | grep -q "^.A\|^M\|^?"; then
    # 本地提交
    if git status --porcelain "$FILE" | grep -q "^??"; then
        git add "$FILE"
    fi
    git commit -m "add: $TITLE" --quiet 2>/dev/null || true
fi

# 尝试 push (设置超时避免长时间卡住)
if timeout 30 git push origin main --quiet 2>/dev/null; then
    echo "✅ git push 成功!"
    PUSH_METHOD="git push"
else
    echo "⚠️  git push 失败，切换到通道2..."
    PUSH_METHOD=""
fi

# ============================================
# 通道2: GitHub API
# ============================================
if [ -z "$PUSH_METHOD" ]; then
    echo ""
    echo "🔄 通道2: GitHub API..."

    # Base64 编码
    CONTENT=$(base64 -i "$FILE")

    # 检查文件是否已存在（获取 sha）
    SHA=$(curl -s -H "Authorization: Bearer $TOKEN" \
        "https://api.github.com/repos/$REPO/contents/$POSTS_DIR/$FILENAME" 2>/dev/null | \
        grep -o '"sha":"[^"]*"' | head -1 | sed 's/"sha":"//;s/"$//')

    if [ -n "$SHA" ]; then
        echo "🔄 文件已存在，更新中..."
        SHA_PARAM=",\"sha\":\"$SHA\""
        ACTION="更新"
    else
        echo "✨ 新文件，创建中..."
        SHA_PARAM=""
        ACTION="发布"
    fi

    # 调用 GitHub API
    RESPONSE=$(curl -s -X PUT \
        -H "Authorization: Bearer $TOKEN" \
        -H "Accept: application/vnd.github+json" \
        -d "{\"message\":\"$ACTION: $TITLE\",\"content\":\"$CONTENT\"$SHA_PARAM,\"branch\":\"main\"}" \
        "https://api.github.com/repos/$REPO/contents/$POSTS_DIR/$FILENAME")

    if echo "$RESPONSE" | grep -q '"commit":'; then
        echo "✅ GitHub API 发布成功!"
        PUSH_METHOD="GitHub API"
    else
        echo "❌ GitHub API 也失败!"
        echo "$RESPONSE" | grep -o '"message":"[^"]*"' | head -1
        exit 1
    fi
fi

# ============================================
# 发布后处理
# ============================================
echo ""
echo "✅ 发布成功 (方式: $PUSH_METHOD)"
echo "🔗 GitHub: https://github.com/$REPO/blob/main/$POSTS_DIR/$FILENAME"
echo "🌐 网站: https://openclawmy.work/posts/${URL_SLUG}/"
echo ""

# 1. Obsidian 博客归档
OBSIDIAN_DIR="$HOME/Documents/Tars/KnowledgeBase/05-博客/$(date +%Y-%m)"
mkdir -p "$OBSIDIAN_DIR"
cp "$FILE" "$OBSIDIAN_DIR/$FILENAME"
echo "✅ 已归档到 Obsidian: $OBSIDIAN_DIR/$FILENAME"

echo ""
echo "⏳ ECS cron 将在15分钟内自动同步并构建..."
echo "   如需立即生效: ssh admin@121.196.146.14 'sudo bash /usr/local/bin/sync-blog.sh'"
