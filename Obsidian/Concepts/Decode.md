# Decode

**类型**: LLM推理阶段  
**相关概念**: Prefill, KV Cache, 投机采样

---

## 定义

Decode（解码阶段）是LLM推理的第二阶段，模型基于已生成的token逐个预测下一个token，直到生成结束符或达到最大长度。

---

## Prefill vs Decode

| 阶段 | 输入 | 输出 | 计算特点 |
|------|------|------|----------|
| Prefill | 完整prompt | 第一个token | 可并行，计算密集 |
| Decode | 已生成token | 下一个token | 串行，内存密集 |

---

## 优化技术

### KV Cache
缓存Key和Value向量，避免重复计算。

### 投机采样
使用小模型预测多个token，大模型验证。

### Prefill-Decode分离
将两个阶段分配到不同硬件资源。

---

## 相关概念

- [[Prefill]] - 推理第一阶段
- [[KV Cache]] - 缓存优化
- [[投机采样]] - 加速解码

---

**标签**: #LLM #推理 #优化 #AI技术
