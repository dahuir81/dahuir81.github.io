# MoE (Mixture of Experts)

**类型**: 神经网络架构  
**全称**: Mixture of Experts，混合专家架构  

## 核心原理

- 总参数量大，但推理时只激活部分参数
- 通过门控网络选择激活的专家子网络
- 降低推理成本，保持模型容量

## Gemma 4 中的应用

**Gemma 4 26B MoE**:
- 总参数量: 260亿
- 激活参数: 约40亿
- 支持256K上下文窗口
- Arena AI 文本排行榜第6名

**性能对比**:
与 Gemma 4 31B Dense 非常接近：
- AIME 2026: 88.3% vs 89.2%
- LiveCodeBench: 77.1% vs 80.0%
- GPQA Diamond: 82.3% vs 84.3%

## 优势与劣势

**优势**:
- 推理成本低（只激活部分参数）
- 保持大模型容量和性能

**劣势**:
- Gemma 4 26B MoE 实际推理速度被吐槽（约11 tokens/秒）
- 内存占用仍需加载全部参数

## 相关实体

- [[Gemma]] - Gemma 4 26B MoE
- [[Qwen]] - Qwen 3.6-Plus 也是 MoE 架构
