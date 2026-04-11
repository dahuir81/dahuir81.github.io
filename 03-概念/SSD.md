# SSD (Speculative Sampling Decoding)

**类型**: LLM推理加速技术  
**全称**: Speculative Sampling Decoding  
**提出**: DeepMind, 2023

---

## 定义

SSD（投机采样解码）是一种LLM推理加速技术，使用小模型（draft model）快速生成候选token序列，再由大模型（target model）并行验证，通过接受/拒绝机制实现加速。

---

## 原理

### 两阶段流程
1. **Draft阶段**: 小模型快速生成多个token
2. **Verify阶段**: 大模型并行验证，接受或拒绝

### 加速效果
- 理想情况: 2-3倍加速
- 取决于draft模型质量
- 与序列特性相关

---

## 与相关技术对比

| 技术 | 层级 | 作用 |
|------|------|------|
| SSD | 系统框架 | 投机解码整体流程 |
| MTP | 训练优化 | 多token预测训练 |
| EAGLE | 模型算法 | 特征层投机采样 |

---

## 相关概念

- [[MTP]] - 多token预测
- [[EAGLE]] - 特征层投机采样
- [[投机采样]] - 通用概念

---

**标签**: #LLM #推理加速 #投机采样 #AI技术
