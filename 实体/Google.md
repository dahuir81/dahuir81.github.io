# Google

## 基本信息

- **公司类型**: 科技巨头 / Alphabet子公司
- **核心业务**: 搜索、广告、云计算、AI
- **AI战略**: 全栈自研，从芯片到模型到应用

## AI芯片布局

### TPU演进路线

| 代际 | 时间 | 标志性事件 |
|------|------|-----------|
| TPU v1 | 2016 | AlphaGo一战成名 |
| TPU v2/v3 | 2017-2018 | 云端大规模部署 |
| TPU v4 | 2021 | 大规模集群训练 |
| TPU v5e/v5p | 2023 | 能效优化 |
| TPU Ironwood | 2025 | 专为Gemini大模型设计 |

### Ironwood核心优势

1. **双Die设计**: 单芯片两颗计算核心，专为AI优化
2. **SparseCore**: 第四代稀疏计算单元，解决Embedding和通信瓶颈
3. **全局共享内存**: 1.77PB可寻址内存，打破分布式训练通信墙
4. **OCS光互联**: 自研光电路交换机，万卡级无损扩展
5. **能效领先**: 29.3 TFLOPS/W，比上一代翻倍

## 与竞品对比

| 维度 | Google TPU | NVIDIA GPU |
|------|-----------|-----------|
| 设计理念 | 专用AI芯片 | 通用计算 |
| 软件生态 | JAX/TensorFlow | CUDA生态 |
| 部署模式 | 云优先(TensorFlow Cloud) | 云+本地灵活 |
| 集群扩展 | OCS光互联，共享内存 | NVLink/InfiniBand |
| 能效比 | 29.3 TFLOPS/W | ~15-20 TFLOPS/W (H100) |

## 战略意义

Google通过TPU Ironwood展示了**垂直整合**的终极形态：
- 自研芯片架构 → 自研互联技术 → 自研数据中心 → 自研大模型(Gemini)
- 全链路优化，没有一处是通用的
- 这是对抗NVIDIA CUDA生态护城河的核心武器

## 相关链接

- [[TPU]] - 张量处理单元技术详解
- [[Gemini]] - Google大模型家族
- [[AI芯片]] - AI芯片行业概览
- [[2026-04-07-Google-TPU-Ironwood-架构全解析-source]] - 本文原文
