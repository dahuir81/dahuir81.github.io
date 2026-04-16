# XLA（Accelerated Linear Algebra）

**类型**：编译器 / 计算图优化引擎
**开发方**：[[Google]]
**用途**：AI 模型的图级编译和硬件后端优化

## 定位
XLA 是连接 AI 框架（PyTorch/JAX）与硬件后端（TPU/GPU）的编译中间层。

## 技术栈位置
```
PyTorch/FX 图 → XLA → StableHLO → TPU 二进制
JAX → XLA → StableHLO → TPU 二进制
```

## 在 TorchTPU 中的角色
TorchTPU 选择 XLA 而非 GPU 上的 Inductor 作为编译引擎，三重考量：
1. XLA 在 TPU 上经过近十年生产验证，成熟度极高
2. 可复用 TorchTPU Eager 路径的算子实现，缩短开发周期
3. XLA 能跨算子边界优化集合通信与计算的重叠，对大规模分布式训练至关重要

## 挑战
- **静态图特性**：动态形状输入会触发重复编译（正在通过 XLA 有界动态性机制解决）
- **首次预热时间过长**：正在构建预编译的 Aten 算子 TPU 内核库

## 关联
- 相关概念：[[TorchTPU]]、[[TPU]]、[[StableHLO]]、[[torch.compile]]
- 相关实体：[[Google]]
- 来源文章：[[2026-04-14-TorchTPU-source]]
