# OpenClaw + Discord 配置教程笔记

**来源**: https://mp.weixin.qq.com/s/jISSGKwPQp0_p8MBkzEC7w  
**作者**: SoSME的Lab  
**时间**: 2026-02-25

---

## 为什么从 Telegram 转向 Discord

| 维度 | Telegram ❌ | Discord ✅ |
|------|-------------|-----------|
| **组织架构** | 平行聊天群，无法分类 | 自带频道（Channels），可建部门专属工位 |
| **机器人协作** | 隐私模式导致互相看不见消息 | 开启权限后完美读取上下文和同事进度 |
| **打扰程度** | 多机器人同时回复，信息流爆炸 | Thread（子线索）机制，AI 在折叠主题里深聊 |

**核心优势**: 从"手机通讯录"到"企业级自动化 OA 系统"的跨越

---

## Discord 配置四步法

### 1. 创建服务器
- 下载 Discord 客户端
- 点击【+ 号】→【亲自创建】→【仅供我和我的朋友使用】
- 取名如"AI 自动化总部"

### 2. 注册 Bot（获取 Token）
- 访问 discord.com/developers/applications
- New Application → 取名 → Bot → Reset Token → 复制保存

### 3. 开启特权意图（关键！）
- Privileged Gateway Intents
- 打开 **Message Content Intent** 和 **Server Members Intent**
- 不打开则机器人看不到任何信息

### 4. 生成 OAuth2 链接
- Scopes: `bot` + `applications.commands`
- 复制链接 → 授权到服务器

---

## OpenClaw 配置三大结构

### 结构一：Agents（大脑）
```json
"agents": {
  "list": [
    {
      "id": "main",
      "model": "bailian/qwen3.5-plus",
      "workspace": "~/.openclaw/workspace"
    },
    {
      "id": "dev", 
      "model": "zai/glm-5",
      "workspace": "~/.openclaw/workspace-dev"
    }
  ]
}
```

### 结构二：Accounts（躯壳）
```json
"channels": {
  "discord": {
    "accounts": {
      "main": {
        "enabled": true,
        "token": "你的Token"
      }
    }
  }
}
```

### 结构三：Bindings（附体）
```json
"bindings": [
  {
    "agentId": "main",
    "match": {
      "channel": "discord",
      "accountId": "main"
    }
  }
]
```

---

## 关键授权（两个特权）

### 1. agentToAgent（内部通话）
```json
"tools": {
  "agentToAgent": {
    "enabled": true,
    "allow": ["main", "content", "dev", "design", "pm"]
  }
}
```

### 2. subagents（影分身）
```json
"subagents": {
  "allowAgents": ["content", "dev", "design", "pm"]
},
"tools": {
  "allow": ["*"]
}
```

**作用**: 
- `sessions_send` - 跨部门打内线电话
- `sessions_spawn` - 后台派发分身干活，不阻塞主聊天

---

## 避坑指南

| 坑位 | 现象 | 解决 |
|------|------|------|
| **Unrecognized sender** | 机器人不理你，显示配对码 | `openclaw pairing approve discord 839211` |
| **疯狂刷屏** | 多机器人同时回复 | 加 `"requireMention": true` |
| **卡死** | 通道被占用 | `openclaw gateway restart` |

---

## Discord vs 飞书 对比

| 维度 | Discord | 飞书 |
|------|---------|------|
| **国内访问** | ❌ 需要 VPN/代理 | ✅ 直接访问 |
| **Thread 机制** | ✅ 原生支持，AI 协作完美 | ⚠️ 支持话题，但 OpenClaw 集成不完善 |
| **Session 连续性** | ✅ Thread 绑定，上下文连续 | ❌ 每次消息可能创建新 session |
| **多机器人协作** | ✅ 机器人互相可见 | ⚠️ 需额外配置 |
| **OpenClaw 支持** | ✅ 官方完整支持 | ✅ 官方支持，但文档较少 |
| **移动端体验** | ✅ 优秀 | ✅ 优秀 |
| **企业功能** | ⚠️ 偏社区/游戏 | ✅ 完整企业办公套件 |

### 核心差异

**Discord 优势**:
- Thread 机制让多 AI 协作更顺畅
- 机器人权限控制更精细
- 社区生态丰富

**飞书优势**:
- 国内直接访问，无需翻墙
- 完整的企业办公功能（日历、文档、审批等）
- 与中文工作流更契合

---

## 可以同时使用吗？

**答案**: ✅ **可以，OpenClaw 支持多渠道同时配置**

### 配置方式

在 `openclaw.json` 中同时配置多个渠道：

```json
{
  "channels": {
    "feishu": {
      "enabled": true,
      "appId": "cli_xxx",
      "appSecret": "xxx"
    },
    "discord": {
      "enabled": true,
      "accounts": {
        "main": {
          "token": "discord_token"
        }
      }
    }
  },
  "bindings": [
    {
      "agentId": "main",
      "match": { "channel": "feishu", "accountId": "default" }
    },
    {
      "agentId": "main", 
      "match": { "channel": "discord", "accountId": "main" }
    }
  ]
}
```

### 使用场景建议

| 场景 | 推荐渠道 |
|------|---------|
| **日常办公、国内协作** | 飞书 |
| **多 AI 自动化、复杂工作流** | Discord（需 VPN） |
| **代码开发、技术讨论** | Discord |
| **与国内团队沟通** | 飞书 |
| **个人自动化实验** | Discord |

### 混合工作流示例

1. **飞书**: 接收日常消息、日程提醒、简单查询
2. **Discord**: 
   - 复杂任务自动化（spawn 子代理）
   - 多 AI 协作场景
   - 代码生成与调试

**切换方式**:
- 简单任务 → 飞书直接处理
- 复杂任务 → "@Main 去 Discord 开个 Thread 处理这个需求"

---

## 国内使用 Discord 的方案

| 方案 | 稳定性 | 复杂度 |
|------|--------|--------|
| **VPN/代理** | ⚠️ 一般 | 低 |
| **海外服务器中转** | ✅ 较好 | 中 |
| **仅 Web 版** | ⚠️ 较差 | 低 |
| **放弃 Discord，优化飞书** | ✅ 稳定 | 需调试 |

---

## 关键结论

1. **Discord 的 Thread 机制确实更适合多 AI 协作**
2. **飞书在国内访问便利性上无可替代**
3. **可以同时配置，按需切换**
4. **如果只用简单功能，飞书足够；如果需要复杂自动化，考虑 Discord + VPN**

---
_散热正常，慧哥。🧊_
