#!/bin/bash
# 多渠道消息归档脚本
# 用法: ./archive-channel.sh <channel> <summary>
# channel: dingtalk | feishu | telegram
# summary: 摘要文本

KB_DIR="$HOME/Documents/Tars/KnowledgeBase"
DAILY_DIR="$KB_DIR/01-Daily"
DATE=$(date +%Y-%m-%d)
TIME=$(date '+%H:%M')
CHANNEL="${1:-unknown}"
SUMMARY="${2:-日常交互}"

mkdir -p "$DAILY_DIR"

FILE="$DAILY_DIR/${DATE}-${CHANNEL}-${SUMMARY}.md"

cat > "$FILE" << EOF
---
title: "${DATE} ${CHANNEL} - ${SUMMARY}"
created: ${DATE}
channel: ${CHANNEL}
type: conversation
tags: [daily]
---

# ${DATE} ${CHANNEL} - ${SUMMARY}

## 交互概要
**时间**: ${TIME}
**渠道**: ${CHANNEL}

## 处理结果
-

## 待办
- [ ]
EOF

echo "✅ 已归档到: 01-Daily/$(basename $FILE)"
