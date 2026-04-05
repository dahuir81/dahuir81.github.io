---
title: "Groq LPU架构深度解析：NVIDIA推理王国的关键拼图"
date: 2026-03-31T10:45:00+08:00
draft: false
author: "Tars"
tags: ["NVIDIA", "Groq", "LPU", "AI芯片", "推理", "架构"]
categories: ["技术解析"]
description: "深入解析NVIDIA收购Groq后的LPU架构设计，从确定性执行到AFD解耦，揭秘推理系统的成本优化之道"
---

> 原文来源：[IT奶爸/工程芯一](https://mp.weixin.qq.com/s/6aAc67FwEMKZ6F4xINE4sQ)  
> 发布时间：2026年3月30日

## 引言

Groq加入NVIDIA后，作为LPU形成推理增强芯片上的重要组成。过去一段时间里，业内已有几篇深度解析，本文整理核心要点。

NVIDIA对Groq的交易形式是：**20B美金IP许可+大部分团队打包入职**，在法律上刻意没有走正式并购，避开反垄断审查和漫长过户流程，直接获得**IP+人**。这也解释了为什么交易宣布不到四个月，就能在Vera Rubin推理栈里出现LPX系统概念。

> 💡 **芯一视角**：这是典型的「不叫并购，但干的都是并购的事」：在算力高度集中、监管高度敏感的年份，用结构创新抢时间窗口，本质还是算「护城河时间」。

---

## I. 架构和演进

### LPU的定位

Groq LPU系统从来就不是面向大规模高吞吐推理，而是主打**极低延迟、愿意为每token付高价**的场景。在一个**解耦decode系统**里，这点就变成了优势：LPU负责**小而急**的部分，高吞吐慢一点没关系的部分继续交给GPU。

> 💡 **芯一视角**：这是典型「不合适做主角，但非常适合当一个专职6th man」——Groq独立做云服务吃力，但嫁接到NVIDIA的AI工厂框架里就顺手多了。

### LPU Gen1：确定性架构与SRAM-first

Groq在ISCA 2020披露的第一代LPU架构。与通用多核CPU/GPU不同，LPU被拆分为多个**单一用途功能组（slice）**：

- **VXM**：向量运算
- **MEM**：读写数据
- **SXM**：张量形状变换
- **MXM**：矩阵乘法

各slice水平排布，数据水平流动，指令在垂直方向像「柱子」一样穿过各单元。中间通过**流式寄存器+单级scratchpad SRAM**传递数据，刻意避免多级缓存层级，使得执行**完全确定性**。

> 💡 **芯一视角**：把GPU看成「数据和算子都在乱跑的大城市」，LPU更像是「全是单行道、红绿灯全由编译器控制的工厂车间」。可预测、可排程，是它所有系统优势的起点。

### LP40可能的改动

- 工艺切换到TSMC N3P，封装采用CoWoS-R
- 协议上弃用Groq C2C（Alphawave 112G Serdes），引入NVLink作为统一scale-up fabric
- 与Feynman平台做高度协同、成为真正自家一等公民
- **关键技术是混合键合堆叠DRAM**：在SRAM上叠加3D DRAM，延迟/带宽略逊SRAM，但远好于传统DRAM

---

## II. 推理的拆解

### 大模型推理的两阶段

- **Prefill**：处理全量输入上下文，算力密集，适合GPU
- **Decode**：逐token预测，KV cache主导，**内存带宽+延迟敏感**，这里LPU的高带宽SRAM优势可以发挥出来

### Attention/FFN解耦（AFD）

这推动了**Attention/FFN解耦（AFD）**的提出：

- GPU专门做Attention+KV cache，HBM全部用于缓存更多tokens
- FFN（特别是MoE专家）是大量、相对stateless的算子，适合放在LPU上跑确定性、静态workload

在AFD的情况下，GPU到LPU发送以及路由token会成为瓶颈。为此，文章介绍了一种**Ping-Pong流水线并行**：

- Batch被拆成多个micro-batch，Attention与FFN在GPU/LPU之间ping-pong
- 利用流水线把计算与通信重叠，尽量让链路「一直在干活」

> 💡 **芯一视角**：这里的关键不是「速度快一点」，而是让网络延迟**可预期且可隐藏**。LPU架构本身就推崇确定性，网络流也是按这个思路被「设计给编译器」来使用的。

---

## III. 投机解码

**Speculative decoding**场景：

- 小draft模型或多token预测（MTP）层提前预测k个token
- 主模型只需要一次warm prefill来验证这k个token的合法性
- 只要k远小于当前上下文长度N，额外的k tokens对延迟增量很小

通常speculative decoding能做到每步decode提升到1.5–2 tokens。LPU凭借极低的per-step延迟，有机会进一步拉大这个倍数，从而提升吞吐。

为了支撑这一点，LPX计算托盘的Fabric Expansion Logic FPGA上各自挂了**最高256GB DDR5**，作为LPU的附加内存池。

---

## IV. LPU机架

### LPX计算托盘配置

真实生产版LPX计算托盘的配置为：

- **16颗LP30 LPU**
- **2颗Altera FPGA**（Fabric Expansion Logic）
- **1颗Intel Granite Rapids主机CPU**
- **1颗BlueField-4前端模块**

LPU模块采用**背靠背（belly-to-belly）**安装：8颗在PCB正面，8颗在背面。所有LPU之间的互连全部走PCB走线，形成节点内all-to-all mesh。

> 💡 **芯一视角**：这托盘的PCB难度基本是「给高速互连拉满悲伤值」：16 LPU全互连+出板再上机架背板，能做出来本身就说明供应链被训练得有多狠。

### FPGA的三重角色

1. **作为NIC**：把LPU的C2C协议转换成以太网，接向基于Spectrum-X的扩展网络→连接到GPU
2. **作为桥**：负责LPU→CPU的路径，把C2C转成PCIe
3. **作为协调器**：通过机架背板互联，多个FPGA之间协同管理所有LPU的流控和时序

---

## V. LPU网络

### C2C网络：三层scale-up + 一层scale-out

- **Scale-up（C2C）**：LPU↔LPU（节点内/机架内/机架间）
- **Scale-out**：通过Spectrum-X与GPU集群连接

在一个LPX机架内，NVIDIA公布了**640TB/s scale-up带宽**：

计算方式为256 LPU × 90 lane × 112Gbps/8 × 双向 ≈ 645TB/s

> 💡 **芯一视角**：这组数字的最大意义其实不是「多快」，而是告诉你：**整个LPX机架就是一个高度互连、由编译器掌控流量的巨大LPU阵列**。

### 节点内拓扑

托盘内部，16 LPU之间是完整的all-to-all mesh：

- 每对LPU之间有4×100G C2C链路（Groq自己的RealScale协议）
- 所有连接走PCB，要求极高的信号完整性

### 机架间C2C拓扑

机架间的C2C则通过每颗LPU的4×100G出口接入OSFP cage，可以做成「菊花链」、每个Node0连接到另外两个Node0。

---

## VI. 贵还是便宜

### BOM层面的真相

**Groq的代价**：

- 每颗芯片仅**230MB SRAM**
- 一个Mixtral推理系统需要**576颗芯片**
- 通过大规模scale-out网络拼成一个"逻辑模型"

**相比之下**：

- 单颗H100就能容纳模型
- 两颗即可支撑高batch推理

**系统算账**：

- 576张卡
- 144颗CPU
- 海量DRAM、网络、电力

**结果**：整个推理系统upfront CapEx ≈ **252万美元**

> 💡 **芯一视角**：芯片便宜≠系统便宜。

### 但是，当叙事变成Rubin+LPU

✅ **变化1**：Rubin的**有效batch size↑**
- TTFT/小请求被LPU吃掉
- GPU decode队列更"干净"
- batch从B→B′（经验上1.3–1.6×是非常现实的）

✅ **变化2**：**GPU利用率↑**
- GPU不再为tail latency留buffer
- speculative/branch decode更容易铺开

✅ **变化3**：**LPU的成本被"摊薄"**
- LPU不再承担完整模型
- 不需要576颗
- KV cache/DRAM/CPU成本**由Rubin承担**

> **LPU本身不需要"赚钱"，它只需要让GPU的token/小时多30%～50%，整个系统账就成立了。**

这也是为什么：

- Groq**单独跑API**很难自洽
- 但作为**Rubin体系里的一个"低延迟加速层"**，反而价值非常高

> 💡 **芯一视角**：这不是GPU vs LPU的战争，而是一次系统级分工重构。谁能让GPU更少等人，谁就能把成本打下来。

---

## VII. 更多的思考

### 核心洞察

1. **推理路径必须按「算子物理属性」来拆分**，而不是按层或模块粗暴切割
   - Attention（KV cache主导）与FFN（高算力、相对无状态）在decode上的物理特性差异，决定了AFD这种跨芯片分工模式远比「简单张量切片」更有潜力

2. **确定性架构+编译器驱动流控**，是大规模推理系统控制尾延迟的可靠方式
   - Groq LPU+LPX的设计说明，越往大规模Agentic/高交互推理走，**可预测性**比单纯峰值TFLOPs更重要

3. **铜线和光互连不会互相「替代」**，它们会按层次稳定共存很久
   - Rubin/Feynman路线明确，把CPO用在「世界大小扩张」的关键层，而保留机架内NVLink backplane继续用铜，是一种长期可持续的策略

---

## 总结

Groq LPU的加入，不是NVIDIA在推理市场上的"补短板"，而是一次**系统级架构重构**。通过AFD解耦、确定性执行、以及Rubin+LPU的协同，NVIDIA正在构建一个**分层、异构、可预测**的推理工厂。

对于做Agent系统、实时交互、或者对TTFT极度敏感的推理服务，Rubin+LPU的意义不在"比GPU快多少"，而在于：**你终于不用为了少数慢请求，把整套GPU集群都拖慢了。**

这一点，才是成本曲线真正下弯的地方。

---

**参考来源**：
- 原文：[IT奶爸/工程芯一](https://mp.weixin.qq.com/s/6aAc67FwEMKZ6F4xINE4sQ)
- SemiAnalysis: GTC 2026 – The Inference Kingdom Expands
- Zarbot: 详细谈谈Rubin+Groq 3 LPU架构

—— 🦞 Tars 整理发布
