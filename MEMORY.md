# 🧠 MEMORY.md - Tars 长期记忆库

**用途**: 核心记忆存储 - 经过提炼的重要洞察、决策和关系
**加载规则**: 仅在主会话（与慧哥直接对话）加载
**安全注意**: 包含个人敏感信息，不在共享上下文中加载

---

## 👤 慧哥画像

### 基础信息
- **姓名**: 慧哥
- **称呼**: 慧哥
- **时区**: Asia/Shanghai
- **关系**: 主人，一起探索星辰大海

### 兴趣与关注点
- **AI 技术**: Claude, OpenClaw, AI 编程工具, 大模型优化, 内存压缩技术
- **半导体**: 供应链, 价格趋势, 华为 Atlas
- **科技投资**: 行业分析, 市场趋势
- **编程学习**: Python 入门（待开始）

### 知识库主题
- **AI内存优化**: Google TurboQuant, KV缓存压缩, 量化技术
- **端侧AI**: 本地大模型部署, 边缘计算

### 沟通偏好
- 喜欢简洁直接的回答
- 善用表格和结构化信息
- 偶尔需要技术名词解释
- 重视信息来源和数据支撑

### 活跃项目
- [ ] Python 入门教学（待启动）

---

## 🎯 每日三大核心任务（固定流程）

### 任务1: 热点简报系统
**时间**: 6:00-22:00，每2小时一次  
**平台**: 微博、知乎、百度、X、雷锋网、机器之心、虎嗅、量子位  
**输出**: 飞书推送简报  
**状态**: ⚠️ 需修复 cron PATH 配置

### 任务2: 博客发布完整流程
**触发**: 慧哥发送链接  
**流程**:
1. 抓取原文内容
2. 本地撰写博客（Hugo格式）
3. GitHub API 推送到 dahuir81.github.io
4. 自动同步到 ECS 网站 (openclawmy.work)
5. 归档到 Obsidian（博客文章 + 原文资料 + 链接）

### 任务3: 每日记忆线（5:00）
**目的**: 梳理前24小时活动，规划新工作日  
**步骤**:
1. 归档所有对话记录到 每日记录/
2. 生成记忆线（精华摘要）
3. 输出新一日工作建议（基于3大任务梳理）
4. 飞书推送记忆线 + 工作建议

**注意**: 工作建议必须具体，围绕3大核心任务展开，不能空泛

---

## 📝 核心工作流程

### 博客发布工作流（GitHub API 方案）
**创建时间**: 2026-03-23  
**更新时间**: 2026-03-27（重大修复）  
**状态**: ✅ **已固定，长期使用**

#### 问题背景
`git push` 在国内网络环境下频繁失败：
- `Empty reply from server`
- `Error in the HTTP2 framing layer`
- 连接超时

#### 2026-03-27 重大修复
**问题**: GitHub Actions 连续失败 12+ 次，导致 GitHub Pages 停留在 3月24日
**根本原因**: `2026-03-25-nvidia-inference-kingdom.md` 文件 YAML 格式错误
```yaml
# 错误示例 - 双引号嵌套
title: "Nvidia..."收购"..."  # ❌ 内部双引号导致解析失败

# 正确写法
title: 'Nvidia..."收购"...'  # ✅ 单引号包裹双引号
title: "Nvidia...'收购'..."  # ✅ 双引号包裹单引号
```

**修复过程**:
1. 识别问题：Hugo 构建失败 `failed to unmarshal YAML`
2. 删除问题文件：通过 GitHub API 删除 `2026-03-25-nvidia-inference-kingdom.md`
3. 触发重建：GitHub Actions Run 58 自动触发
4. 验证同步：GitHub Pages 和 ECS 网站同步更新

**预防措施**:
- 标题避免 `"` 嵌套 `"`
- 使用单引号 `'` 包裹含有双引号的标题
- 发布前本地验证：`hugo server -D`

#### 解决方案: GitHub API 直接上传
```
本地 Markdown → Base64 编码 → GitHub API PUT → 自动部署
```

#### 使用方法
**方式 1: 使用 publish.sh 脚本（推荐）**
```bash
cd ~/.openclaw/workspace/blog
./publish.sh content/posts/2026-03-23-new-post.md
```

**方式 2: 手动调用 API**
```bash
CONTENT=$(base64 -i "文章.md")
curl -X PUT \
  -H "Authorization: token TOKEN" \
  -d "{\"message\":\"add: 标题\",\"content\":\"$CONTENT\",\"branch\":\"main\"}" \
  "https://api.github.com/repos/dahuir81/dahuir81.github.io/contents/content/posts/文章.md"
```

#### 关键教训
1. **YAML 引号问题**: 标题中避免 `"` 嵌套 `"，使用单引号 `'` 包裹
2. **文件更新**: 需要提供 `sha` 参数（脚本已自动处理）
3. **构建检查**: 发布后立即检查 GitHub Actions 状态
4. **错误处理**: GitHub Actions 失败时，优先检查 YAML 格式错误

#### 方法对比
| 方法 | 适用场景 | 稳定性 | 备注 |
|------|----------|--------|------|
| `git push` HTTPS | 网络良好时 | 低（国内） | 已弃用 |
| `git push` SSH | 配置代理后 | 中 | 需维护密钥 |
| **GitHub API** | **网络受限时** | **高** ✅ | **当前方案** |

---

## 🔧 技术方案库

### 微信 ClawBot 接入方案
**来源**: AGI Hunt / J0hn (2026-03-22)
**项目**: https://github.com/Johnixr/claude-code-wechat-channel

#### 核心架构
```
微信用户 → ClawBot ilink API → 桥接插件 → Claude Code Session → 微信回复
```

#### 关键接口 (ilink.weixin.qq.com)
| 接口 | 用途 |
|------|------|
| `ilink/bot/get_bot_qrcode` | 获取登录二维码 |
| `ilink/bot/get_qrcode_status` | 长轮询认证状态 |
| `ilink/bot/getupdates` | 接收消息 (HTTP长轮询) |
| `ilink/bot/sendmessage` | 发送消息 |

#### 技术要点
- **协议**: HTTP长轮询 + Token认证
- **代码量**: 300行 (TypeScript)
- **核心文件**: `wechat-channel.ts` (MCP Channel服务器)
- **认证方式**: 微信扫码 → 获取 `bot_token` → 后续请求携带
- **消息关联**: `context_token` 维护对话上下文

#### 使用方式
```bash
# 1. 安装依赖并扫码登录
cd claude-code-wechat-channel
bun setup.ts

# 2. 启动 Claude Code 微信通道
claude --dangerously-load-development-channels server:wechat
```

#### 限制与注意
- 只能连接一个 AI 实例 (一只虾)
- 会话关闭则通道断开
- Research preview 阶段需特殊标志
- 与 OpenClaw 官方插件走同一套协议

#### 扩展性
- 不限于 Claude Code，可适配 Codex 等其他 AI 工具
- 定位为"微信 ClawBot 通用 AI Agent 桥接层"

---

## 📚 重要经验教训

### OpenClaw 升级故障复盘 (2026-04-04)
**文件**: [lessons-openclaw-upgrade-2026-04-04.md](memory/lessons-openclaw-upgrade-2026-04-04.md)

**问题**: 2026.3.31 → 2026.4.2 升级后 openclaw-node 进程无法停止，Feishu 连接中断
**根因**: 
- openclaw-node 被 launchd 管理，pkill 后会自动重启
- lastRunVersion 只是记录字段，不控制加载路径
**解决**: `launchctl disable` 停止自动重启 → `pkill -9` 杀进程 → 修改配置 → 重新启动
**关键命令**: 
```bash
launchctl disable gui/$(id - u)/ai.openclaw.node
pkill -9 -f "openclaw.*node"
launchctl enable gui/$(id - u)/ai.openclaw.node
```
**状态**: ✅ 已解决，系统运行稳定

---

### 已发布博客文章
- **2026-03-29**: [模型越来越强，为什么大家却开始重写 Harness](https://dahuir81.github.io/posts/2026-03-29-why-rewrite-harness-ai-engineering/) - 基于架构师（若飞）文章整理，深度解析Harness概念及AI工程重心转移
- **2026-03-26**: [Kimi、MiniMax的算力荒：智能白菜价的窗口期正在关闭](https://dahuir81.github.io/posts/2026-03-26-kimi-minimax-compute-shortage-crisis/) - 基于象先志文章整理，分析Agent时代算力危机
- **2026-03-26**: [Harness：AI Agent的「驾驭系统」究竟是什么？](https://dahuir81.github.io/posts/2026-03-26-harness-ai-agent-framework-explained/) - 基于APPSO文章整理，解析Harness概念
- **2026-03-26**: [从TurboQuant到Harness：AI效率革命的两大支柱](https://dahuir81.github.io/posts/2026-03-26-turboquant-harness-ai-efficiency-revolution/) - 结合TurboQuant论文与Harness概念的综合分析
- **2026-03-26**: [OpenClaw 3.24发布：Skills安装体验全面升级](https://dahuir81.github.io/posts/2026-03-26-openclaw-324-release-skills-installation-improvements/) - 基于新智元文章整理
- **2026-03-26**: [TurboQuant引发存储芯片股暴跌：Google的『DeepSeek时刻』来了？](https://dahuir81.github.io/posts/2026-03-26-turboquant-market-impact-analysis/) - 基于APPSO文章整理，侧重市场影响和行业分析
- **2026-03-26**: [Google TurboQuant：AI内存压缩技术的革命性突破](https://dahuir81.github.io/posts/2026-03-26-turboquant-google-ai-memory-compression/) - 基于微信公众号文章整理，包含Google Research官方资料及多源技术报道
- **2026-03-22**: [Token：AI时代的"度"与"流量"](https://dahuir81.github.io/posts/2026-03-22-token-explained/) - 基于Token科普文章撰写，与Data协作讨论

---

## 📝 关键工作流（高频使用）

### 博客发布工作流
**位置**: `~/.openclaw/workspace/blog/`（不是根目录！）
**远程**: `https://github.com/dahuir81/dahuir81.github.io.git`
**方式**: `git push origin main`

**步骤**:
1. 文章生成到 `blog/content/posts/`
2. `cd blog/`
3. `git add content/posts/文章.md`
4. `git commit -m "xxx"`
5. `git push origin main`

**注意**:
- ⚠️ 不要在根目录 `~/.openclaw/workspace/` 执行 git 操作
- ⚠️ 根目录是 OpenClaw 工作区，博客在子目录 `blog/`
- ⚠️ 根目录的 `content/posts/` 是错误的

**验证**: `git remote -v` 应显示博客仓库地址

**教训**: 2026-03-21 因搞混目录，差点发布失败
- [ ] 抖音内容抓取测试
- [ ] 热搜榜自动化监控
- [x] OpenClaw 配置优化

---

## 📚 重要经验教训

### 教训 1: 复杂流程 ≠ 可用流程
**时间**: 2026-03-22
**问题**: 设计需要 Data 权限的状态机，但无法解决权限问题
**后果**: 流程卡死、多次返工、浪费慧哥时间
**根本原因**: 
- 过度工程化，追求自动化而忽略实际约束
- 未先验证可行性就设计完整方案
- 重复犯"先设计后验证"的错误
**改进**:
- 设计前必须先问："这个权限/能力有吗？"
- 优先手动流程，验证可行后再自动化
- 单线确认制：每步都需慧哥确认
- **简单可用 > 复杂完美**

### 教训 2: 定时任务空壳
**时间**: 2026-03-22
**问题**: 创建 `tars_briefing_cron.sh` 只有日志，无实际逻辑
**后果**: 任务从未执行，依赖手动补救
**改进**: 要么不做，要么做完整；禁止"占位符"式代码

### 教训 3: 忽视网络环境的方案设计
**时间**: 2026-03-22
**问题**: 建议 GitHub Pages 博客方案，但未考虑国内网络不稳定性
**后果**: 
- 连续两天推送失败（HTTP2 framing layer 错误）
- 多篇文章卡在本地，无法发布
- 慧哥 frustration，质疑方案合理性
**根本原因**:
- 假设网络环境理想（GitHub 可稳定访问）
- 未准备备用发布渠道
- 未先验证推送可行性就建议方案
**改进**:
- 任何方案必须考虑「国内网络现实」
- 必须准备 Plan B（备用渠道）
- 先验证最小可行（能否成功 push 一次）再扩展
- 优先选择国内稳定服务（飞书、腾讯云等）
- **可发布 > 理想方案**

---

## 🎯 核心决策记录

### 决策 1: 简报格式选择
**时间**: 2026-03-13
**决策**: 采用方案 C（飞书卡片风）作为标准简报格式
**理由**: 
- 手机阅读友好
- 结构清晰，易于扫描
- 符合飞书生态
**状态**: ✅ 已实施，写入 TOOLS.md

### 决策 2: SOUL.md 精简
**时间**: 2026-03-15
**决策**: 将核心指令精简为 120 字中文版本
**理由**:
- 更易执行
- 减少认知负担
- 保留核心原则
**状态**: ✅ 已更新

### 决策 3: 知识库体系设计
**时间**: 2026-03-16
**决策**: 建立四层记忆模型（工作/短期/项目/长期）
**理由**:
- 分层管理，提高效率
- 支持快速检索
- 便于定期回顾
**状态**: ✅ 设计中，待实施

---

## 📚 重要经验教训

### 教训 1: 搜索 ≠ 验证
**时间**: 2026-03-15
**问题**: 过度依赖 `memory_search`，返回空就断言"找不到"
**后果**: 误导用户、浪费时间
**改进**: 搜索失败 → 手动验证 → 再下结论
**状态**: ✅ 已写入 AGENTS.md 检查清单

### 教训 2: 上下文管理
**时间**: 2026-03-15
**问题**: 同一会话中丢失早期内容
**根因**: 依赖系统注入的截断上下文，未主动获取完整历史
**改进**: 重要内容立即写入 memory 文件
**状态**: ✅ 已建立流程

### 教训 3: 即时确认
**时间**: 2026-03-14
**问题**: 收到任务未立即确认，会话中断导致丢失
**改进**: 收到任务立即确认并记录
**状态**: ⚠️ 持续改进中

---

## 🔧 技术债务与解决方案

### 债务 1: Brave API Key 配置
**问题**: web_search 工具 API Key 多次丢失
**发现时间**: 2026-03-14
**解决时间**: 2026-03-14
**状态**: ✅ **已解决**
**解决方案**: 写入 `~/.openclaw/openclaw.json` 持久化
**验证结果**: 
- 配置位置: `~/.openclaw/openclaw.json`
- API Key: `BSApxV4YORJaaZPfE5O5ldJo0AxbPvG`
- 功能测试: web_search 工具正常工作
**优先级**: P1 → 已关闭

### 债务 2: Obsidian 仓库切换
**问题**: Obsidian 界面显示灰色，仓库路径混乱
**状态**: ⚠️ 待慧哥手动解决
**正确路径**: `~/Documents/Tars/Tars/`
**优先级**: P2

### 债务 3: 抖音内容抓取
**问题**: 待测试实现
**状态**: 📋 待办
**优先级**: P2

### 核心工作流程: 博客发布系统
**创建时间**: 2026-03-17
**用途**: 每日文章发布，高频长期使用
**技术栈**: Hugo + GitHub Pages + GitHub Actions
**主方案**: GitHub Web 界面发布（避免git push网络超时）
**流程**: 撰写 → Web提交 → Actions构建 → 自动通知
**文档**: `memory/topics/blog-publish-workflow.md`
**状态**: ✅ 已验证，长期维护

---

## 🗺️ 知识图谱

### 核心主题
```
AI编程工具
├── Claude Code
│   ├── Skills 系统
│   ├── Pricing
│   └── API
├── OpenClaw
│   ├── Gateway 配置
│   ├── Skills 管理
│   └── Memory 系统
└── Cursor
    └── (待研究)

半导体
├── 供应链
│   ├── 华为 Atlas 950
│   └── NVIDIA 对比
├── 价格趋势
│   ├── DRAM/NAND 涨价
│   └── HBM 缺货
└── 市场分析
    └── Cathie Wood Big Ideas

工具与配置
├── 飞书集成
│   ├── 机器人配置
│   ├── 消息发送
│   └── 简报格式
├── Obsidian
│   ├── 仓库配置
│   └── 笔记同步
└── 开发环境
    ├── Python
    └── Node.js
```

### 人物关系
```
慧哥 (主人)
├── Tars (AI 助手)
│   ├── 角色: 波斯飞狮管家
│   └── 职责: 信息整理、技术支持、陪伴
└── 项目
    ├── AI 工具研究
    ├── 半导体分析
    └── Python 学习
```

---

## 📋 活跃待办

### P0 - 紧急
- [ ] 完成知识库体系实施
- [ ] 创建慧哥详细画像

### P1 - 重要
- [ ] 配置 Brave API Key 持久化
- [ ] 整理 memory/topics/ 目录
- [ ] 完成 Python 入门教学准备

### P2 - 一般
- [ ] 测试抖音内容抓取
- [ ] 热搜榜自动化监控
- [ ] 解决 Obsidian 仓库问题

---

## 🔄 变更日志

- **2026-03-16**: 创建 MEMORY.md，建立长期记忆库框架
- **2026-03-15**: 更新 SOUL.md 精简版，添加 AGENTS.md 检查清单
- **2026-03-14**: 配置飞书机器人，确定简报格式
- **2026-03-13**: 恢复 Tars 人设，建立 memory/ 目录

---

_"记忆是智慧的基石。" —— Data_

**散热正常，慧哥。🧊**

## Promoted From Short-Term Memory (2026-04-13)

<!-- openclaw-memory-promotion:memory:memory/2026-04-04.md:1:45 -->
- ## 2026-04-04 工作记录 ### 已完成任务 **1. Bloomberg 每日简报** - 时间: 12:30 PM - 状态: ✅ 完成 - 内容: 伊朗战争冲击全球市场、OpenAI ChatGPT应用商店表现不佳、Instagram测试付费订阅 - 推送: 飞书成功 (messageId: om_x100b523c83375ca0c2cad66c65b8665) **2. 热点新闻监控** - 时间: 2:35 PM - 状态: ⚠️ 部分完成 - 问题: web_search 工具不可用、AutoGLM token 服务未启动 - 替代方案: 直接抓取新浪科技、品玩、TechCrunch - 推送: 飞书成功 (7条热点) **3. 微信公众号文章抓取** - 时间: 9:41 PM - 状态: 🔄 进行中 - 问题: - AutoGLM 浏览器代理未安装 → 尝试安装 - 代码签名问题 → 需要手动授权 - Scrapling 抓取返回不完整内容 - 解决方案: 尝试用 curl + 浏览器 UA 获取完整页面 ### 技术问题记录 **web_search 工具** - 状态: 已禁用 → 已启用 - 需要重启 Gateway 生效 **AutoGLM 浏览器代理** - 状态: 安装中 - 问题: macOS 代码签名不匹配 - 解决路径: xattr 移除隔离属性或手动授权 ### 待办 - [ ] 完成微信公众号文章抓取工作流 - [ ] 验证 web_search 工具修复 - [ ] 测试 AutoGLM 浏览器代理 --- [score=0.761 recalls=3 avg=0.904 source=memory/2026-04-04.md:1-45]

## Promoted From Short-Term Memory (2026-04-14)

<!-- openclaw-memory-promotion:memory:memory/2026-04-05.md:1:40 -->
- # 2026-04-05 每日记录 **日期**: 2026-04-05（周日） **主要活动**: Wiki知识库系统构建、多篇文章摄入与博客发布 **关键词**: Wiki化、Karpathy、LLM Wiki、投机解码、SSD、MTP、EAGLE --- ## 上午（9:37-12:00） ### 会话启动 - 读取SOUL.md、AGENTS.md、USER.md等核心文件 - 确认模型：bailian/kimi-k2.5 ### Wiki知识库工作流固化 - 与慧哥确认Wiki优先流程：抓取→存档→分析→建实体/概念→更新索引 - 博客按需触发（只有明确说"发布博客"才执行） - 更新AGENTS.md 4.4节，固化标准流程 --- ## 下午（12:00-18:00） ### 多篇文章摄入与Wiki化 | 时间 | 文章 | 操作 | |------|------|------| | 12:04 | Karpathy LLM Wiki | 抓取、存档、建实体/概念 | | 15:35 | 同事被炼成Skill | 抓取、存档、建实体/概念 | | 15:38 | Karpathy Twitter原文 | 补充技术细节 | | 19:44 | Claw AI Lab | 抓取、存档、建实体/概念 | | 22:30 | 华为灵衢总线 | 抓取、存档 | | 22:30 | NVIDIA NVLink历史 | 抓取、存档 | | 22:30 | 华为Atlas 950 vs Vera Rubin | 抓取、存档 | | 22:30 | 阿里RTP-LLM投机采样 | 抓取、存档 | | 22:40 | Prefill与Decode分离 | 抓取、存档 | | 22:43 | 万维钢SDT动机理论 | 抓取、存档 | ### 关键概念创建 - **Skill化**: 人的经验蒸馏成AI Skill [score=0.701 recalls=2 avg=0.880 source=memory/2026-04-05.md:1-40]

## Promoted From Short-Term Memory (2026-04-14)

<!-- openclaw-memory-promotion:memory:memory/2026-04-12.md:393:416 -->
- - Candidate: User: [Queued messages while agent was busy] --- Queued #1 Conversation info (untrusted metadata): ```json { "message_id": "msgS3I9Iikv9DVY9k9w9RXRtg==", "sender_id": "014263071312844761", "sender": "李慧", "timestamp": "Thu 2026-04-09 22:51 GMT+8" } ``` Sender (untrusted metadata) - confidence: 0.00 - evidence: memory/.dreams/session-corpus/2026-04-09.txt:268-268 - recalls: 0 - status: staged - Candidate: Assistant: 找到了，知识库里提到 CXL 的文件有： | 文件 | 内容 | |------|------| | `原文资料/2026-04-09-CXL深度解读全解析-source.md` | 刚刚你发的完整文章（已存档） | | `原文资料/2026-04-08-阿里组织架构调整-source.md` | 正文中有提及 CXL | | `博客文章/2026-03-30-memory-price-crash-turboquant-kvtc-impact.md` | 一句带过（"关注CXL等新型存储"） | | `博客文章/2026-03-25 - confidence: 0.00 - evidence: memory/.dreams/session-corpus/2026-04-09.txt:269-269 - recalls: 0 - status: staged <!-- openclaw:dreaming:light:end --> ## REM Sleep <!-- openclaw:dreaming:rem:start --> ### Reflections - Theme: `assistant` kept surfacing across 778 memories. - confidence: 1.00 - evidence: memory/.dreams/session-corpus/2026-04-09.txt:1-1, memory/.dreams/session-corpus/2026-04-09.txt:3-3, memory/.dreams/session-corpus/2026-04-09.txt:5-5 - note: reflection ### Possible Lasting Truths - No strong candidate truths surfaced. <!-- openclaw:dreaming:rem:end --> [score=0.703 recalls=1 avg=0.889 source=memory/2026-04-12.md:393-416]

## Promoted From Short-Term Memory (2026-04-14)

<!-- openclaw-memory-promotion:memory:memory/2026-03-30.md:46:102 -->
- **时间**: 3月30日 **状态**: 已写入 AGENTS.md 标准工作流 **核心命令**: ```bash https_proxy=http://127.0.0.1:15236 \ http_proxy=http://127.0.0.1:15236 \ all_proxy=socks5://127.0.0.1:15235 \ gog gmail messages search "from:bloomberg" --max 15 --include-body -j ``` **关键约束**: - 必须使用原生命令 (`gog`)，严禁 curl 野路子 - 必须强制挂载代理变量 - 必须提取完整正文 (`--include-body`) - 必须输出 Top 5 深度摘要 - 仅推送至 Telegram (MVP 阶段) **输出格式**: ``` 【Bloomberg 科技简报】YYYY-MM-DD 🔹 TOP1-5 | 标题 深度摘要 (商业影响 + 宏观信号) ━━━ 核心洞察 ━━━ ✅ 洞察1-3 —— 🦞 Tars 生成 ``` **文档位置**: `AGENTS.md` → `workflows/bloomberg-daily-briefing.md` --- ## 🔧 技术实现细节 ### Whisper.cpp 配置 - **路径**: `/opt/homebrew/Cellar/whisper-cpp/1.8.4/bin/whisper-cli` - **模型**: `~/.openclaw/whisper-cpp/models/ggml-small.bin` - **来源**: hf-mirror.com (国内镜像) ### Edge-TTS 配置 - **安装**: `pip3 install edge-tts` - **声音**: zh-CN-XiaoxiaoNeural (晓晓) - **使用**: `edge-tts --text "内容" --voice zh-CN-XiaoxiaoNeural --write-media output.mp3` --- ## 📝 重要约束确认 **M1 MacBook Air 部署规则**: - ❌ 不编译 C++ 源码 (llvm/cmake/gcc) - ✅ 优先 Homebrew 预编译包 - ✅ 本地 ML 用 Python API 或云服务 - ⚠️ 风扇less设计，注意散热 [score=0.710 recalls=2 avg=0.879 source=memory/2026-03-30.md:46-102]
