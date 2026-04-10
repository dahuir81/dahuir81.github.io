# 原文资料：阿里RTP-LLM投机采样技术：1000 tokens/秒推理加速

**来源**: 微信公众号（阿里巴巴）  
**原文链接**: https://mp.weixin.qq.com/s/EiSRF2ORy22I1pimCCvcPQ  
**作者**: 赵骁勇（阿里巴巴智能引擎事业部）  
**审校**: 刘侃, Kitty  
**应用**: Aone Copilot fast apply功能  
**抓取时间**: 2026-04-05  
**对应博客文章**: （按需触发）

---

## 核心主题

RTP-LLM通用投机采样框架，实现1000 tokens/秒推理加速，已应用于Aone Copilot。

---

## 背景：LLM推理特点

### Prefill vs Decode

| 阶段 | 输入 | 计算方式 | 瓶颈 |
|------|------|---------|------|
| **Prefill** | 完整prompt（几百+ tokens） | 并行计算 | 算力瓶颈 |
| **Decode** | 单个token | 自回归逐个计算 | 显存带宽瓶颈 |

**关键**: Decode阶段每次只处理1个token，但需要加载全部weights，达到显存带宽瓶颈。

---

## 投机采样原理

### 核心思想

用小模型Mq（Propose Model）猜测大模型Mp（Score Model）可能生成的k个token，让大模型一次性并行计算这k个token，突破带宽瓶颈。

### 三个阶段

1. **Propose Stage**: 小模型提议k个token
2. **Score Stage**: 大模型对k个token并行打分
3. **Verification Stage**: 验证算法决定接受多少个token

### Roofline Model分析

```
Decode（带宽瓶颈） → Score（算力瓶颈）
```

通过调整k值，将原本访存瓶颈的Decode任务转化为计算瓶颈的Score任务。

---

## 延迟分析

### 小模型为GPT模型

**公式**: 加速比 = (Tq × k + Tp) / (L × Tp)

- Tq: 小模型单次Decode耗时
- Tp: 大模型单次Decode/Score耗时
- k: 提议token数
- L: 平均接收长度

**示例**:
- Tq=7ms, Tp=18ms, k=5, L=3
- 每轮耗时: 5×7 + 18 = 53ms
- 加速比: 18/(53/3) = 1.02
- 若L=4: 加速比 = 1.35

### 小模型为规则模型（Prompt Lookup）

Tq≈0，k可设置很大（如1024）

**极限加速比**（A100, qwen72b, TP=2）:
- 128 tokens: 100倍
- 2048 tokens: 148倍

**Aone Copilot实现**: 1000 tokens/秒（32B模型）

---

## 吞吐分析

### 传统认知
投机采样对吞吐有害（因为计算了但可能不接受）。

### 实际场景受益

**1. 显存瓶颈场景**
- 小显存GPU（如L20 48GB）
- 请求输出长，并发度受限
- 投机采样提升算力利用率

**2. 框架限制场景**
- 小模型（如Qwen 1.8B）
- 需要1024并发才能打满算力
- 投机采样在低并发下提升batch size

**3. 超长sequence场景**
- 128个请求凑批 → attention阶段访问128个历史KV Cache
- 投机采样：1个请求k=128 → 只访问1个历史KV Cache
- 计算强度更高，吞吐提升

---

## RTP-LLM通用框架

### 四大模块组件

| 组件 | 功能 |
|------|------|
| **ProposeExecutor** | 小模型提议token（多种实现） |
| **ScoreExecutor** | 大模型打分 |
| **SpeculativeSampler** | 验证算法决定接受数 |
| **SpeculativeUpdater** | 更新token到stream |

**特点**: 无状态、松耦合、易扩展

### 支持算法

- 朴素投机采样（小GPT模型）
- Medusa（额外lm head预测）
- Eagle（新Auto-Regression Head）
- **Prompt Lookup**（n-grams匹配，本文重点）

---

## Prompt Lookup投机编辑

### 适用场景

代码编辑等抽取式场景：
- 大部分输出可直接从输入摘抄
- 仅在差异处特殊处理

### 优化改进

1. **维护游标**: 记录上次匹配成功位置，从之后开始匹配
2. **首轮优化**: 第一轮直接取前k个token作为提议

### 业务效果

| 场景 | 效果 |
|------|------|
| **Aone Copilot Fast Apply** | 1000 tokens/秒，提升10倍 |
| **结构化输出（72B模型）** | Decode延迟3秒→1.2秒，提升60% |
| **训练数据清洗** | 单卡RPS 3→10 |

---

## 未来方向

1. **开箱即用**: Prompt Lookup默认开启，自适应调整
2. **结合DeepSeek MTP**: 简单预测用Prompt Lookup，复杂预测用MTP
3. **更多投机采样方法**: 树采样、动态投机采样等

---

## 关键洞察

> "投机采样把原本逐个token的Decode过程转换成一次性对k个token进行Score并行计算的过程，从而更高效利用GPU算力资源。"

> "在显存瓶颈、框架限制、超长sequence等场景下，投机采样可以通过调整k值，从另一个维度提升batch size，充分利用GPU算力。"

---

## 相关技术

- **RTP-LLM**: 阿里巴巴高性能LLM推理引擎
- **Prompt Lookup**: 基于n-grams匹配的投机采样
- **Speculative Decoding**: 投机解码技术
- **Roofline Model**: 性能分析模型
- **Aone Copilot**: 阿里内部智能化产品

---

**标签**: #阿里巴巴 #RTP-LLM #投机采样 #PromptLookup #LLM推理 #AI加速
