# 洞察：ECS OpenClaw 配置教训

**日期**：2026-03-21

## 问题

在配置阿里云 ECS 上的 OpenClaw 时，遇到端口 8080 被占用的问题。Tars 采取了以下错误做法：

1. 盲目尝试 `pkill`、`systemctl stop`、`reboot`
2. 没有先了解系统的实际运行状态
3. 错误地假设是残留进程导致

## 根本原因

阿里云 OpenClaw 镜像配置了 **systemd 用户服务自动启动**：

```bash
systemctl --user list-units --type=service | grep openclaw
# openclaw-gateway.service loaded active running OpenClaw Gateway (v2026.3.3)
```

重启后服务自动运行，占用 8080 端口。

## 教训

### 1. 先观察，后行动

遇到问题时，应该先执行诊断命令了解系统状态：

```bash
# 检查服务状态
systemctl --user status openclaw-gateway.service

# 检查进程
ps aux | grep openclaw

# 检查端口占用
ss -tlnp | grep 8080
```

### 2. 了解镜像机制

阿里云镜像可能有预设的自动启动机制，应该：
- 先查看 systemd 服务配置
- 了解镜像的启动脚本
- 不要盲目手动启动

### 3. 正确的处理方式

既然服务已自动启动，应该：
- 直接使用 systemd 管理服务
- 修改配置后重启服务：`systemctl --user restart openclaw-gateway.service`
- 查看日志：`openclaw logs --follow`

## 行动项

- [ ] 阅读阿里云 OpenClaw 镜像文档
- [ ] 了解 systemd 用户服务的完整配置
- [ ] 建立"先诊断后处理"的问题解决流程

---

*散热正常，慧哥。🧊*
