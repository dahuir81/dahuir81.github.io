# TPU（张量处理单元）

**类型**：AI 加速芯片 / ASIC
**开发方**：[[Google]]
**首次公开**：2016 年
**定位**：专为机器学习与 AI 工作负载设计的定制 ASIC

## 核心特点
- 大规模张量运算能效比领先 GPU
- 从单芯片到 Pod 级（~9000 芯片）线性扩展
- 通过 ICI 网络（2D/3D torus）和 DCN 数据中心网络互联
- 承载 Gemini、Imagen、Veo、AlphaFold 等 SOTA 模型训练

## 产品迭代
| 版本 | 单 Pod 芯片数 | 互联架构 |
|------|---------------|----------|
| Trillium | 256 | 2D torus |
| v3 | ~1000 | 2D torus |
| v4 | ~4000 | 3D torus |
| v5p | ~9000 | 3D torus |

## 生态演变
- **2016-2024**：仅通过 JAX 生态使用，PyTorch 开发者"看得见摸不着"
- **TorchXLA 时代**：需侵入式代码修改（`mark_step()`），不兼容 PyTorch 原生分布式生态
- **2026 TorchTPU**：3 行代码完成 GPU 迁移，TPU 成为 PyTorch 一等公民

## 市场数据
- 过去 12 个月 Google Cloud TPU 用量增长 **8 倍**
- Anthropic、Hugging Face 等是主要云客户
- 支撑 Google 内部 Gemini 等数万芯片规模训练

## 关联
- 相关概念：[[TorchTPU]]、[[XLA]]、[[StableHLO]]、[[异构算力]]
- 对比：[[NVIDIA]] GPU
- 相关实体：[[Google]]、[[Meta]]
- 来源文章：[[2026-04-14-TorchTPU-source]]
