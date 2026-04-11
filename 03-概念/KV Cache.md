# KV Cache

**类型**: LLM推理优化技术  
**全称**: Key-Value Cache  
**应用领域**: 大模型推理加速

---

## 定义

KV Cache是Transformer模型推理时的关键优化技术，通过缓存已计算token的Key和Value向量，避免在生成新token时重复计算，显著降低计算复杂度。

---

## 原理

### 注意力机制回顾
- Query (Q): 当前token的查询向量
- Key (K): 所有token的键向量
- Value (V): 所有token的值向量

### 缓存策略
- 第一次计算时存储所有K和V
- 后续只计算新token的Q
- 复用缓存的K和V

### 复杂度变化
- 无缓存: O(n²)
- 有缓存: O(n)

---

## 优化方向

### KV Cache压缩
- [[TurboQuant]] - Google的量化压缩方案
- [[MQA/GQA]] - 多查询/分组查询注意力

### 内存管理
- 动态分配
- 分页管理
- 量化存储

---

## 相关概念

- [[Prefill]] - 推理第一阶段
- [[Decode]] - 推理第二阶段
- [[投机采样]] - 加速生成

---

**标签**: #LLM #推理优化 #缓存 #AI技术
