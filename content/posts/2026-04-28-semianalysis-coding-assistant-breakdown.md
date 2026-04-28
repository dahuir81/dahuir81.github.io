---
title: "SemiAnalysis 万字横评：GPT 5.5、Opus 4.7、DeepSeek V4，谁在赢？"
date: 2026-04-28T15:50:00+08:00
draft: false
tags: ["AI", "大模型", "Coding Assistant", "GPT-5.5", "Claude Opus", "DeepSeek", "SemiAnalysis"]
---

SemiAnalysis 4 月 24 日发了一篇重磅：团队实测 GPT 5.5、Claude Opus 4.7 和 DeepSeek V4，顺带把基准测试的底裤扒了。这篇文章信息密度极高，我拆解出来供参考。

---

## 一、GPT 5.5：OpenAI 终于交了一次真正的预训练答卷

GPT-4.5 失败之后，OpenAI 急需要一个翻身仗。「Spud」预训练的 GPT 5.5 就是那张牌。

**定价直接翻倍**：$5/M input + $30/M output，是 GPT-5.4 的两倍，比 Opus 4.7 还贵。但 OpenAI 这次学聪明了，推出了 **priority tier**——2.5 倍价格换 SLA 保证（>50 tok/s，99% 时间达标），跟之前的 fast mode（模糊承诺）完全不是一回事。

**产品矩阵也清晰了**：
- GPT-5.5：标配
- GPT-5.5 Pro：$30/$180 per M token，专攻科学研究和长程推理，BrowseComp 和 FrontierMath 双料 SOTA
- GPT-5.3-Codex-Spark：Cerebras 硬件上跑的蒸馏小模型

OpenAI 宣称「training on 100k GB200 NVL72」，但 SemiAnalysis 指出这只是后训练（RL），非预训练——表述上打了擦边球。

**实测最关键的信号**：SemiAnalysis 工程师开始**Codex 与 Claude 交替使用**。过去他们几乎清一色用 Claude，现在 GPT 5.5 在 Codex 里拉取大量上下文后再改代码的模式，天然适合 PR review 和 bug hunt。

---

## 二、Claude Opus 4.7：小幅迭代，但藏着 35% 的隐形涨价

Opus 4.7 是 4.6 的平替，不是革命。SemiAnalysis 工程师「勉强」采用——**因为没有 fast mode**。

**五个关键变更**：
1. 高分辨率图像支持，RL 训练用截图优化前端样式
2. 「xhigh」推理档位（high 和 max 之间）
3. 思考内容默认隐藏——但你照常付费
4. **Task Budget**（Beta，仅 API），给模型一个效率提示，太严它会耍滑头或拒绝
5. **新 tokenizer**，token 用量最多增 35% → 隐形涨价 35%

**一个值得注意的 bug 披露**：Anthropic 在 4 月 23 日承认 Claude Code 存在 3 个 bug（跨度 3 月 4 日至 4 月 20 日），影响几乎全部用户。

工程师反馈：Opus 4.7 经常快速 Explore 后就动手改，架构决策和代码风格仍然比竞品好。但没 fast mode，很多人宁可牺牲质量要速度。

---

## 三、DeepSeek V4：100 万上下文 + KV Cache 压缩 90%，但还不是最前沿

V4 是两个模型：Pro（1.6T/49B active）和 Flash（284B/13B active）。核心卖点：上下文窗口从 128K 拉到 **100 万**。

三项核心技术：
- CSA（压缩稀疏注意力）
- HCA（重度压缩注意力）  
- mHC（流形约束超连接）

百万 token 场景下，单 token 推理 FLOPs 只要 V3.2 的 27%，KV cache 只要 10%。而且 DeepGEMM 里包含支持 **华为昇腾 NPU 的 Mega-Kernel**——对国产硬件生态是实打实的利好。

**但现实是**：H200 FP8 首日吞吐才约 150 tok/s（V3 是 1300-2300），差距巨大。预计数周内优化。高难度中文写作上，Claude Opus 4.7 依然领先。

SemiAnalysis 的评价很冷静：出色的工程发布，紧跟 SOTA，能力不在最领先位置。他们自己的工作流不会被 DeepSeek V4 取代。

---

## 四、基准测试为什么不可信

各实验室选择性发布对自家有利的基准——这已经是公开的秘密。真正的指标是 **cost per task**（每次任务成本），不是 cost per token。

举一个例子：Mythos 比 Opus 贵 5 倍/token，但因为 token 效率更高，实际任务成本差距大幅缩小。SemiAnalysis 为此上线了 Tokenomics Dashboard，追踪所有主要模型的性能声明、定价、发布日期。

---

## 五、工程师怎么用这些模型

| | Codex (GPT-5.5) | Claude (Opus 4.7) |
|---|---|---|
| 模式 | 拉大量上下文→分析→改代码 | 快速 Explore→直接改 |
| 强项 | PR review、bug hunt | 架构决策、代码风格 |
| 短板 | 风格和架构弱 | 没 fast mode |
| 趋势 | 开始交替使用 | 仍是主力 |

一个重要的观察：模型已经足够好了，日常任务基本都能做对。现在的批评更多关乎**风格、架构、token 效率**，而非功能正确性。模型完全搞砸 commit 的情况越来越罕见。

---

## 六、2026 年格局预判

**竞争者全景**：GLM-5.1、Qwen3.6-Plus、Kimi K2.6、Composer 2、Gemini 3.1 Pro——全在押注 agentic coding。

**两个核心判断**：

1. **Token efficiency 是 2026 的主题词**——模型好不好，先看省不省 token
2. **Fast mode 的成功证明速度 > 绝对质量**。Opus 4.6 Fast 获得了实际采用，Opus 4.7 没 fast mode 反而被「勉强」接受

竞争已经过了「能不能做对」的阶段，进入「做对有多快、多便宜」的阶段。

---

*原文链接：https://newsletter.semianalysis.com/p/the-coding-assistant-breakdown-more*
