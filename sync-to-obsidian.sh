#!/bin/bash
# 博客文章归档到 Obsidian 脚本
# 功能: 将 blog/content/posts/ 下的所有文章同步到 Obsidian 知识库

set -e

# 配置
BLOG_DIR="$HOME/.openclaw/workspace/blog/content/posts"
OBSIDIAN_BASE="$HOME/Documents/Tars/KnowledgeBase/05-博客"
LOG_FILE="/tmp/blog_sync_obsidian.log"

DATE=$(date +%Y-%m-%d)
TIME=$(date '+%H:%M:%S')

echo "[$DATE $TIME] ================================" >> $LOG_FILE
echo "[$DATE $TIME] 开始同步博客文章到 Obsidian" >> $LOG_FILE

# 统计
TOTAL=0
SYNCED=0
SKIPPED=0

# 遍历所有文章
for file in "$BLOG_DIR"/*.md; do
    if [ -f "$file" ]; then
        TOTAL=$((TOTAL + 1))
        filename=$(basename "$file")
        
        # 从文件名提取年月
        if [[ $filename =~ ^([0-9]{4}-[0-9]{2}) ]]; then
            year_month="${BASH_REMATCH[1]}"
        else
            year_month=$(date +%Y-%m)
        fi
        
        # 目标目录
        target_dir="$OBSIDIAN_BASE/$year_month"
        target_file="$target_dir/$filename"
        
        # 检查是否需要同步
        if [ -f "$target_file" ]; then
            # 比较文件大小和修改时间
            src_size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
            dst_size=$(stat -f%z "$target_file" 2>/dev/null || stat -c%s "$target_file" 2>/dev/null)
            
            if [ "$src_size" -eq "$dst_size" ]; then
                SKIPPED=$((SKIPPED + 1))
                continue
            fi
        fi
        
        # 创建目录并同步
        mkdir -p "$target_dir"
        cp "$file" "$target_file"
        SYNCED=$((SYNCED + 1))
        echo "[$DATE $TIME] ✅ 已同步: $filename -> $year_month/" >> $LOG_FILE
    fi
done

echo "[$DATE $TIME] ------------------------------" >> $LOG_FILE
echo "[$DATE $TIME] 同步完成: 总计 $TOTAL, 新增/更新 $SYNCED, 跳过 $SKIPPED" >> $LOG_FILE
echo "[$DATE $TIME] ================================" >> $LOG_FILE

# 输出摘要
echo "📊 同步摘要:"
echo "   总计文章: $TOTAL"
echo "   新增/更新: $SYNCED"
echo "   已存在跳过: $SKIPPED"
echo ""
echo "✅ 同步完成！"
