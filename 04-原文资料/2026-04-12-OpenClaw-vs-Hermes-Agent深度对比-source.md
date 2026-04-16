# OpenClaw vs Hermes Agent深度对比：两种Agent哲学路线

- **原文**: OpenClaw vs Hermes Agent深度对比
- **来源**: 微信公众号
- **URL**: https://mp.weixin.qq.com/s/JYH25oERBHALzkAu9TUT3g
- **存档日期**: 2026-04-12
- **标签**: #OpenClaw #HermesAgent #Agent架构 #NousResearch #AI操作系统

---

今年 2 月，有用户在 Medium 上吐槽：一个每天总结新闻的 cron job，月 API 费 $128。不是用了 GPT-4o，不是并发量大，纯粹是 OpenClaw 把完整对话历史塞进每条请求，context window 膨胀到离谱。他以为自己配置有问题，调了两周参数，最后发现是框架的设计决策。

这不是个例。2026 年开头两个月，Medium 上冒出一波 OpenClaw 的"控诉文"——有人发现 21,000 台 OpenClaw 服务器裸奔在公网上，有人挖出 386 个恶意 Skills 混在官方仓库里，还有人拿 15 个大模型跑测试，发现 Agent 在矛盾指令下反复横跳，Gary Marcus 直接评了句 "makes various stupid errors"。

同一时间段，一个叫 Hermes 的项目在 GitHub 上两个月拿了 5.6 万+ Star。背后是 Nous Research——发布过 Hermes 系列微调模型的那个团队，开源社区口碑不错。

## OpenClaw 怎么了——编排范式的三道裂缝

### 裂缝一：安全——21,000 台服务器在裸奔

2026 年初的安全审计结果不太好看：超过 21,000 台 OpenClaw 服务器直接暴露在公网。CVE-2026-25253，一个未认证 WebSocket 漏洞，研究者用了 1 小时 40 分钟就打穿了——远程代码执行。

供应链更头疼：3,016 个 Skills 里混进了 386 个恶意包，比例超过 12%。你每装一个社区 Skill 都在赌运气。

### 裂缝二：成本——context window 在偷偷烧钱

OpenClaw 的对话历史存成 JSONL 明文文件。每条消息请求？发送完整对话历史给 LLM。不压缩，不检索，全量灌。

后果很直接：上下文越长，token 越多，账单越高。用户报告月均 API 费到$500。那个 $128/月的 cron job 不是极端案例——是架构的必然产物。

OpenClaw 的 "Lane Queue" 还是串行处理，任务排队等着。你看着 Agent "思考"几分钟没吭声？那叫 "ghosting"。不是在想，是 context length exceeded 快要爆了。

### 裂缝三：性能——400 个 session 就趴窝

用 sub-agent 的同学注意了。GitHub Issue #58534 记了一条退化曲线：session 数到 400，CPU 拉满 100%+，`sessions.list` 响应从毫秒级膨胀到 6.5 秒。

Issue #47583 暴露了另一个坑：per-agent 配置的 tools"静默失败"——Agent 在系统提示词里看得到 tool 描述，API 请求的 `tools` 参数却是空的。菜单看得到，菜点不了。

**如果你也在凌晨翻 API 账单，问题可能不在模型。是框架在拖后腿。**

## 两种哲学——"给木偶加提线" vs "让木偶学走路"

OpenClaw 和 Hermes 的差距不在功能数量。是对"Agent 到底是什么"的根本分歧。

**OpenClaw** ：Agent 是被编排的系统。LLM 只管推理，其他一切——工具调用、记忆、状态、流程——全交给外部 Node.js runtime。想更强？加编排层，加 pipeline，加配置。

**Hermes** ：Agent 是被培养的心智。工具使用、记忆交互、执行模式不是外挂，是内化到模型自身的能力。

> "OpenClaw treats an agent as a system to be orchestrated. Hermes treats an agent as a mind to be developed."

**核心问题：你的 Agent 能不能从错误中学习。**

OpenClaw 不能。你不动手，它原地踏步。十次同样的错，第十一次照犯。

Hermes 能。第一次犯错，纠正一次。第二次碰到类似的，它自己绕过去了。没加任何配置。

## Hermes 怎么做到的——三个关键机制

### 三层记忆：不是存聊天记录，是建认知体系

| 层级 | 载体 | 存什么 | 怎么用 |
|------|------|--------|--------|
| Layer 1 | MEMORY.md (800 tokens) + USER.md (500 tokens) | 持久化事实和用户偏好 | 每次对话自动加载 |
| Layer 2 | Skill 文件 | 从经验中抽象的行为模式 | 匹配场景自动调用 |
| Layer 3 | SQLite FTS5 | 全历史跨会话搜索 | LLM 摘要化检索，不发全量 |

重点在 Layer 3。全文搜索 + LLM 摘要检索历史，不是三个月的对话一股脑灌给模型。你用再久，每条消息的 token 消耗也不会膨胀。

还有个设计叫 "Honcho"——辩证式用户建模。不只是被动记住你说过什么，而是跨会话推理你的意图和工作模式。连续三天让它做数据清洗，第四天它直接弹出清洗方案。

### 每 15 个任务一次蜕变：Skill 是它自己学的

每完成 15 个任务，自动触发自我评估：哪些成功了，哪些翻车了，用了什么策略。触发 Skill 创建的条件——5 次以上工具调用、包含错误恢复、收到过用户修正、或者用了非常规工作流。系统把解法抽象成可复用的 Skill 文件，自动入库。

**对比表**：

| 维度 | ❌ OpenClaw | ✅ Hermes |
|------|------|------|
| Skill 来源 | 内置 52+ / 社区手动装 | 内置 40+ / **从经验中自动生成** |
| Skill 更新 | 手动维护 | 每 15 任务自动评估 + 改进 |
| 适应性 | 你配什么它用什么 | 持续适配你的工作方式 |
| 模型 | BYOK 6 家主流 | 200+ 模型（OpenRouter + 自定义） |
| 数据隐私 | 设备配对 + Gateway 认证 | **零遥测 + 数据全本地** |
| 部署 | 云容器 / VPS / 托管 | 本地 / Docker / SSH / Modal / Daytona / Singularity |
| 年度成本 | $4,480 (self-hosted) | $3,840 (self-hosted) |

### 200+ 模型 × 零遥测

通过 OpenRouter 接 200+ 模型——GPT-4o、Claude、Qwen、Mistral、Llama，随便挑。任务自动路由：重要对话用 Claude，日常摘要走便宜的开源模型。

零遥测是底线。没有任何数据离开你的机器，所有状态存在 `~/.hermes/`。

## 怎么用——三档上手

### 秒开：一键安装 + 本地推理（10 分钟）

```bash
# 安装 Hermes
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash

# 装 Ollama + 拉模型
ollama run qwen3.5:27b

# 配置本地模型
export MODEL_PROVIDER=ollama
export MODEL_NAME=qwen3.5:27b

# 启动
python main.py
```

硬件门槛：16GB 内存 + 支持 Qwen3.5 7B 的显卡（27B 要 ~20GB 显存，纯 CPU 也行但慢）。

### 进阶：Docker + 多平台网关

```bash
git clone https://github.com/NousResearch/hermes-agent
cd hermes-agent
docker compose up -d
# config.yaml 填 Bot Token，接上 Telegram/Discord/Slack
```

### 极客：RL 训练 + 数据导出

```bash
# 导出 ShareGPT 格式
hermes export --format sharegpt --output training_data.json

# Atropos 强化学习
hermes train --backend atropos --reward-model your_reward_model
```

## 值不值得迁？

### 优势 TOP3
1. **经验复利** ：不是"配置多就强"，是"用得多就强"。三个月后的 Hermes 和今天的 Hermes 不是一个东西。
2. **成本可控** ：多模型按任务路由 + FTS5 检索代替全量发送 = 模型费用压到 OpenClaw 的 70-85%。
3. **隐私硬底线** ：零遥测 + 数据全本地。

### 诚实局限
1. **团队协作偏弱** ：没有 OpenClaw 的 Gateway 统一网关和 per-assistant 数据隔离。
2. **没有托管服务** ：需要自己搞部署。6 种后端选够多，但不想碰服务器的人会嫌烦。
3. **才两个月大** ：2,986 个 open issues，社区活跃，坑也不少。

**评分：8.5/10**（扣分在团队场景和托管缺失）

## 分人群路线

| 你是谁 | 选什么 | 一句话理由 |
|--------|--------|-----------|
| 独立开发者 | **Hermes** | 用三个月后它已经变成了"你的"Agent |
| 团队/企业 | **OpenClaw** | 多通道 Gateway + 权限管控 + 托管部署，企业场景没对手 |
| AI 研究者 | **Hermes** | ShareGPT 数据导出 + Atropos RL 集成，研究管道开箱即用 |
| 预算敏感 | **Hermes** | serverless 部署 + 200+ 模型按需路由 = 成本最优解 |
| 安全合规 | **Hermes** | 零遥测 + 全本地存储，合规审计只需要检查一台机器 |
| 运维懒人 | **OpenClaw** | getclaw 托管 5 分钟上线，不碰服务器 |

> **好的 Agent 不是你配置出来的，是它自己长出来的。**

## 参考资料

1. Yin & Yang, "The Quiet Shift in AI Agents: Why Hermes Is Gaining Ground Beyond OpenClaw", Mar 30, 2026
2. Amine Afia, "OpenClaw vs Hermes Agent: Every Feature That Matters for Founders in 2026", Mar 16, 2026
3. Stephan Densby, "Why OpenClaw Fails: What Testing 15+ AI Models Reveals About Autonomous Agent Stability", Feb 2026
4. Reza Azizi, "OpenClaw: The AI Agent That Burns Through Your API Budget", Feb 2026
5. Hermes Agent Official Documentation
6. Hermes Agent GitHub (56,638 stars as of Apr 11, 2026)
