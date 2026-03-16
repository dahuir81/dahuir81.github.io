#!/bin/bash
# 博客发布通知脚本
# 用法: ./notify.sh <文章文件路径>

POST_FILE="$1"
if [ -z "$POST_FILE" ]; then
    echo "用法: ./notify.sh <文章文件路径>"
    exit 1
fi

# 提取文章信息
export TITLE=$(grep "^title:" "$POST_FILE" | sed 's/title: "//;s/"$//' | head -1)
export DATE=$(grep "^date:" "$POST_FILE" | sed 's/date: //' | head -1)
export SLUG=$(basename "$POST_FILE" .md)
export URL="https://dahuir81.github.io/posts/$SLUG/"

# 提取正文内容（去掉front matter）
export CONTENT=$(sed '1,/^---$/d;/^---$/d' "$POST_FILE" | head -80)

echo "📧 发送邮件通知: $TITLE"

# 发送邮件通知
python3 << 'PYEOF'
import smtplib
import os
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

title = os.environ.get('TITLE', '无标题')
date = os.environ.get('DATE', '')
url = os.environ.get('URL', '')
content = os.environ.get('CONTENT', '')

smtp_server = "smtp.qq.com"
smtp_port = 587
sender_email = "5283728@qq.com"
receiver_email = "5283728@qq.com"
password = "ckyfpclygvajbjgf"

message = MIMEMultipart("alternative")
message["Subject"] = f"【博客发布】{title}"
message["From"] = sender_email
message["To"] = receiver_email

# 构建邮件正文
email_body = f"""
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📝 博客文章已发布
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📌 标题：{title}

🔗 链接：{url}

⏰ 时间：{date}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📄 正文内容
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

{content}

...

[完整内容请访问博客链接查看]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤖 Tars 自动生成 | 博客发布通知系统
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
"""

message.attach(MIMEText(email_body, "plain", "utf-8"))

try:
    server = smtplib.SMTP(smtp_server, smtp_port)
    server.starttls()
    server.login(sender_email, password)
    server.sendmail(sender_email, receiver_email, message.as_string())
    server.quit()
    print("✅ 邮件通知发送成功")
except Exception as e:
    print(f"❌ 邮件发送失败: {e}")
PYEOF

# 发送飞书消息
echo "📱 发送飞书通知..."

# 使用 OpenClaw 的 message 工具发送飞书消息
# 这里通过写入文件，由主程序读取后发送
cat > /tmp/feishu_notify.txt << EOF
🎉 博客文章已发布！

📄 ${TITLE}
🔗 ${URL}

✅ 邮件通知已发送
EOF

echo "✅ 通知流程完成！"
