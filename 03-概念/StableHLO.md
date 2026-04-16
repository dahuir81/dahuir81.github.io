# StableHLO

**类型**：中间表示（IR）/ 算子集
**用途**：AI 框架与编译器之间的统一中间层

## 定义
StableHLO（Stable High-Level Operations）是一套精简的算子集（约 110 个算子），作为 AI 框架（PyTorch/JAX）与编译器（XLA）之间的统一中间表示。

## 技术意义
PyTorch 有约 300 个 Aten 算子，JAX 有约 110 个算子。TorchTPU 的核心创新就是把 Aten 的 300+ 算子映射到 StableHLO 的精简算子集，打通两条原本隔离的技术栈：

```
PyTorch → Aten → StableHLO → OpenXLA → TPU
JAX → StableHLO → OpenXLA → TPU
```

**StableHLO 是统一中间层**，让 PyTorch 和 JAX 共享同一套编译优化路径。

## 对比
| 框架 | 算子层 | 算子数量 | 编译器后端 |
|------|--------|----------|------------|
| PyTorch | Aten | ~300 | Triton/GPU 或 XLA/TPU |
| JAX | StableHLO | ~110 | OpenXLA/TPU |
| TorchTPU | Aten→StableHLO | 映射层 | OpenXLA/TPU |

## 关联
- 相关概念：[[XLA]]、[[TorchTPU]]、[[Aten]]
- 来源文章：[[2026-04-14-TorchTPU-source]]
