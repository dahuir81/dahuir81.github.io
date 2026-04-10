# Blackwell微架构深度解析

**来源**: [[2026-04-07-blackwell-tensor-cores-microbenchmark-source|SemiAnalysis原文]]
**作者**: Kimbo Chen (SemiAnalysis)
**日期**: 2026-04-07

---

## 概述

Nvidia Blackwell (SM100) 是一代以来最大的GPU微架构变革，引入了多项针对AI工作负载的底层优化。SemiAnalysis通过数月的微基准测试，首次公开了数据中心Blackwell架构的详细性能数据。

---

## 核心架构变化

### 1. 张量内存 (TMEM)

**变革点**: 线程不再隐式拥有MMA操作结果

- 传统: MMA结果直接存储在线程寄存器中
- Blackwell: TMEM在MMA范围内由软件显式管理
- 优势: 更灵活的数据流控制，减少寄存器压力

### 2. tcgen05指令模型

**变革点**: 单线程代表整个CTA发出操作

| 架构 | 指令发出范围 | CuTe MMA Atom |
|------|-------------|---------------|
| Hopper | Warp/Warpgroup | `ThrID = Layout<_128>` |
| Blackwell | 整个CTA | `ThrID = Layout<_1>` |

**影响**: 简化了编程模型，但需要重新思考并行策略

### 3. 2SM MMA (双SM协同矩阵乘法)

**机制**: 两个SM组成TPC，协作执行单个MMA操作

- 输入矩阵A: 复制到两个SM
- 输入矩阵B和输出D: 跨两个SM分片
- CTA对可互相访问共享内存

**性能表现**:
- 完美弱扩展性: 2x资源带来2x加速
- 对于SMEM带宽受限的小N形状，甚至超过2x加速
- M=256配置在所有情况下都接近100%理论峰值

---

## 内存子系统详解

### LDGSTS (异步拷贝)

**功能**: 全局内存 → 共享内存，异步非阻塞

**关键发现**:
- 吞吐饱和点: 32 KiB in-flight时达到6.6 TB/s
- 推荐: 使用16字节加载(性能略优且节省资源)
- 基线延迟: ~600纳秒，8 KiB后延迟翻倍

**FlashInfer应用**:
- MLA内核使用2 warps + 12 stages，达到约2.2 TB/s
- 性能受限原因: softmax warps需要最多寄存器

### TMA (张量内存加速器)

**vs LDGSTS对比**:

| 特性 | LDGSTS | TMA |
|------|--------|-----|
| 最佳场景 | <32 bytes in-flight | >32 bytes in-flight |
| 延迟 | 较低(<12 KiB) | 较高但可扩展到128 KiB |
| 地址生成 | 多线程参与 | 单线程完成 |
| 内存重排 | 需手动处理 | 硬件自动处理 |

**TMA多播**:
- 单次加载可广播到集群内所有CTA的共享内存
- 显式多播: L2流量降至理论最小值
- 隐式多播: 硬件L2请求合并器(LRC)自动优化

### DSMEM (分布式共享内存)

**功能**: 集群内CTA互相访问对方共享内存

**性能特点**:
- 吞吐远低于本地SMEM (128 bytes/cycle)
- 访问模式: 需像访问全局内存一样合并访问
- 最佳实践: 使用`cp.async.bulk` (UBLKCP)移动大数据量

---

## Tensor Core第五代MMA

### 性能特征

**形状依赖性**:
- M=64: 仅利用50%数据路径
- M=128: 接近100%理论峰值
- M=256: 在所有配置下都达到近100%峰值

**数据类型**:
- 相同位宽的数据类型性能几乎相同
- 微缩放(MX)数据类型开销极小
- 延迟排序: S8 < BF16 = E4M3 = F4 < MXF8 = MXF4

**AB布局影响**:
- SS模式(都在SMEM): N<128时受SMEM带宽限制
- TS模式(A在TMEM, B在SMEM): 在所有N下都达到峰值

### 2SM MMA深度分析

**弱扩展性验证**:
- 理论: 2x SM = 2x 性能
- 实测: 所有格式和形状都达到完美弱扩展
- SS模式下小N甚至超过2x(因SMEM带宽瓶颈被分摊)

**延迟特征**:
- 2SM MMA M=256延迟增长略快于M=128
- 与理论估计一致

---

## GPC与Floorsweeping

### 集群调度机制

**关键约束**: CTA集群必须在同一GPC上协同调度

**问题场景**:
- 集群大小不能整除GPC的SM数量 → 部分SM空闲
- 导致意外的串行执行

### Floorsweep解决方案

**双集群大小启动**:
- 首选集群大小: 获得更大集群的好处
- 回退集群大小: 通常为2或1，确保利用所有SM

**物理布局发现**:
- B200双芯片封装，die-to-die延迟约300 cycles
- 逻辑GPC分组与实际物理布局不完全一致
- 制造缺陷导致每个GPC的可用SM数量不固定

---

## 实际应用建议

### 内核开发最佳实践

1. **MMA形状选择**: 始终使用给定SMEM瓦片大小下可用的最大指令形状
2. **数据布局**: 如果可能，将A矩阵放在TMEM以获得最佳性能
3. **TMA vs LDGSTS**: 
   - 小负载/不规则访问 → LDGSTS
   - 大负载/规则访问 → TMA
4. **集群大小**: 使用双集群大小确保100% SM利用率

### FlashInfer特定发现

- MLA: 使用LDGSTS进行动态页面加载
- MHA: 使用TMA (由TRT-LLM贡献)
- 推测: TRT-LLM可能使用4D TMA处理动态页面

---

## 开源资源

**SemiAnalysis Blackwell微基准测试**:
- 仓库: https://github.com/SemiAnalysisAI/microbench-blackwell
- 包含: PTX/SASS指令级性能测试、内存子系统分析、MMA形状扫描

---

## 相关概念

- [[Tensor Core演进]] - 从Volta到Blackwell的架构变迁
- [[Hopper架构]] - 前代架构对比
- [[CUDA编程模型]] - CTA、Warp、线程层次结构
- [[AI加速器架构]] - TPU、Trainium、AMD CDNA对比

---

## 关键实体

- [[NVIDIA]] - GPU架构设计者
- [[SemiAnalysis]] - 技术分析机构
- [[FlashInfer]] - 开源推理内核库
- [[TRT-LLM]] - Nvidia推理优化库

---

*基于SemiAnalysis 2026年4月微基准测试报告整理*
