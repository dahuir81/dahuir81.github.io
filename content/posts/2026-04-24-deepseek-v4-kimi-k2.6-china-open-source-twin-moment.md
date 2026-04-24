---
title: 'DeepSeek V4 和 Kimi K2.6 同周发布：中国开源模型的双子时刻'
date: 2026-04-24
draft: false
tags: ['DeepSeek', 'V4', 'Kimi', 'K2.6', 'MoE', '开源', '中国AI', 'MLA', 'Muon']
categories: ['AI前沿']
---

同一周，两个万亿参数中国开源模型先后落地。

DeepSeek V4，1.6万亿参数，Codeforces评分3206（人类第23），KV缓存砍到前代的十分之一。Kimi K2.6，万亿MoE，支持300个子Agent协同，OpenRouter调用量全球第一。

这不是巧合。回头看过去15个月，这两家的技术路线和发布时机对齐到令人怀疑是约好的。

<!--more-->

## 顶尖玩家的山口相遇

| 时间 | DeepSeek | Kimi |
|------|----------|------|
| 2025.1 | R1 推理模型 | K1.5 多模态思考模型（同日上线，差2小时） |
| 2025.2 | NSA 原生稀疏注意力论文 | MoBA 混合块注意力论文 |
| 2025.4 | Prover-V2 数学推理 | Kimina-Prover 数学推理 |
| 2026.1 | mHC 流形约束超连接 | — |
| 2026.3 | — | 注意力残差（获 Karpathy 称赞） |
| 2026.4 | **V4 万亿参数开源** | **K2.6 万亿参数开源** |

OpenAI 的论文里也提到，这两家是最早复现 o1 思维链的团队。

## 技术上的互相加持

最值得关注的是底层技术的交叉引用。

Kimi K2 的注意力机制采用了 DeepSeek 首创的 **MLA**（Multi-head Latent Attention）——把 Q/K/V 压缩到低秩 latent 向量，推理时只需缓存压缩向量再解压，大幅缩减 KV 缓存。

反过来，DeepSeek V4 采用了 Kimi 团队验证的 **Muon 优化器**——不搞 AdamW 那种对每个参数独立自适应缩放，而是对整个梯度矩阵做正交化，让更新方向在矩阵空间中更均匀。Kimi 的 Moonlight 论文首次在 2025 年初把 Muon 扩展到大规模训练，V4 技术报告明确引用：Muon 带来更快的收敛和更好的训练稳定性。

三条平行推进的工程线：

- **KV 缓存**：Kimi 的 Mooncake 做分离式存储和调度，V4 设计异构 KV 缓存把压缩 KV 和滑动窗口 KV 分开管理
- **长上下文**：Kimi 2024 年率先验证百万上下文可行性，V4 用 CSA/HCA 把推理算力降到 V3.2 的 27%
- **注意力架构下一步**：DeepSeek 押稀疏注意力（筛选有价值的 token），Kimi 探索线性注意力（改写计算规则本身）

## 全球市场的验证

老黄的 PPT 就是最好的背书：GTC 2026 上展示 Rubin NVL72 性能时，**训练基准用 DeepSeek，推理吞吐和 token 成本基准用 Kimi**。同一张 slide，两个中国开源模型。

Meta Muse Spark 的代码困惑度对比里，拿来对标的也是 Llama 4、DeepSeek V3.1 和 Kimi K2。

Cursor 的 Composer 2 被开发者扒出底座是 Kimi K2.5，Cursor 创始人承认"基于困惑度评估，Kimi K2.5 是我们测试过的最强基座模型"。日本乐天 Rakuten AI 3.0 的底座也被发现是 DeepSeek V3。

OpenRouter 调用量排行榜：Kimi K2.6 以 297B tokens 排第一，DeepSeek V3.2 以 204B 排第四，中间夹着 Claude。

## 芯片暗线

V4 技术报告明确写到细粒度专家并行同时在 NVIDIA GPU 和华为 Ascend NPU 上完成验证。Kimi 的 Prefill-as-a-Service 引入分离式架构，推进国产芯片的混合推理方案。

两位创始人梁文锋和杨植麟都先后参加了总理座谈会，都是中国 AI 领域被点名的代表。

## 竞争是表面，加速是结果

如果只有一家，可以说是个例。但同一周两个万亿参数开源模型同时落地，技术互相渗透，被 GTC 和 Meta 选为基准，被 Cursor 和 Rakuten 拿去当底座。

当某些闭源模型还在互相猜忌的时候，这两家已经在论文里互相引用、在代码里互相复用了。

这就是开源最硬的复利。

---

*参考：[新智元公众号](https://mp.weixin.qq.com/s/CZWNnF-bS1ELq9GPIHDu3A)、DeepSeek V4 技术报告、Kimi K2.6 技术报告、OpenRouter 排行榜*
