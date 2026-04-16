# TorchTPU

**类型**：开源项目 / 硬件适配层
**开发方**：[[Meta]] × [[Google]] 联合发布
**发布时间**：2026 年 4 月（PyTorch 欧洲大会，巴黎）
**状态**：即将开源

## 定义
打通 PyTorch 框架与 Google TPU 硬件的原生解决方案。TPU 在 PyTorch 中的地位和 CUDA 一样。

## 技术架构
```
PyTorch → Aten → StableHLO → OpenXLA → TPU
```
核心创新：将 PyTorch 的 300+ Aten 算子映射到 StableHLO 的精简算子集（约 110 个），复用 XLA 十年编译优化。

## 三大设计原则
| 原则 | 说明 |
|------|------|
| 易用性 | TPU 在 PyTorch 中使用体验与 CUDA 完全一致 |
| 可移植性 | 标准 PyTorch 模型零修改运行 |
| 性能 | 释放 TPU 硬件潜力，触及 JAX 级别效率 |

## 关键能力
- **3 行代码迁移**：`cuda`→`tpu`，`nccl`→`tpu`，无需 `mark_step()`
- **PrivateUse1 后端**：TPU 与 CUDA 同等"一等公民"待遇
- **三种 Eager 模式**：Debug / Strict / DeferAndFuse（独创，快 1.5-2 倍）
- **完整分布式支持**：DDP / DTensor / FSDPv2 / MPMD / SPMD
- **68.8% HuggingFace 模型零修改运行**：Llama3/4、Qwen2/3、DeepseekV3 等

## 性能数据
| 指标 | 数据 |
|------|------|
| 线性扩展 | 8→256 TPU，吞吐量提升 31.7 倍（99%+ 效率） |
| torch.compile 加速 | 比 Strict 模式快 3-5 倍 |
| DeferAndFuse 加速 | 比 Strict 快 1.5-2 倍 |

## 2026 路线图
- GitHub 开源 + 文档教程
- Helion 内核（类 Triton Pythonic TPU 编程）
- vLLM 原生集成
- TorchTitan 适配
- torch.compile 动态形状支持
- tpuBLAS 加速库
- Pod 级及以上线性扩展验证

## 商业意义
- **NVIDIA CUDA 护城河第一次有了真正的框架级替代**
- PyTorch 开发者不再被锁定在 GPU
- 异构算力集群成为行业标准
- "最好的硬件是你恰好需要的那一种，不是被迫锁定的那一种"

## 关联
- 相关概念：[[TPU]]、[[XLA]]、[[StableHLO]]、[[异构算力]]、[[PrivateUse1]]
- 相关实体：[[Google]]、[[Meta]]、[[NVIDIA]]
- 来源文章：[[2026-04-14-TorchTPU-source]]
