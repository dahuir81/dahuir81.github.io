# Dissecting Nvidia Blackwell - Tensor Cores, PTX Instructions, SASS, Floorsweep, Yield

**来源**: SemiAnalysis Newsletter
**作者**: Kimbo Chen (SemiAnalysis)
**原文链接**: https://newsletter.semianalysis.com/p/dissecting-nvidia-blackwell-tensor
**发布日期**: 2026-04-01
**抓取时间**: 2026-04-07

---

## 核心主题

Microbenchmarking, tcgen05, 2SM MMA, UMMA, TMA, LDGSTS, UBLKCP, Speed of Light, Distributed Shared Memory, GPC Floorsweeps, SM Yield

---

## 文章摘要

Nvidia数据中心Blackwell GPU (SM100)代表了一代以来最大的GPU微架构变革，但至今没有详细的白皮书发布。SemiAnalysis花费数月工程时间，深入剖析Blackwell架构，测量原始PTX指令性能，建立实际的性能上限，并与理论峰值进行比较。

### 主要发现

**Blackwell核心特性变化**:
- 引入张量内存(TMEM)来保存MMA累加器结果
- `tcgen05`操作现在由单线程代表整个CTA发出，而非之前的warp或warpgroup范围
- 支持TPC范围的TMA和MMA跨协调CTA对执行
- 原生支持亚字节数据类型与微缩放

**集群、GPC和Floorsweeping**:
- 自Hopper以来，Nvidia数据中心GPU支持"线程块集群"、"CTA集群"等特性
- CTA在集群中被保证在同一个GPC上协同调度
- 每个GPC产生的SM数量不固定，制造缺陷导致需要灵活的SM映射

**内存子系统**:
- LDGSTS: 异步拷贝，从全局内存到共享内存，非阻塞
- TMA (Tensor Memory Accelerator): 专门用于大量数据移动
- TMA多播: 单次加载可拷贝数据到多个SM的共享内存
- DSMEM (Distributed Shared Memory): 集群内CTA可互相访问共享内存

**第五代Tensor Core MMA**:
- 2SM MMA: CTA对跨2个SM协作执行一个MMA操作
- 性能高度依赖数据形状，M=128时达到近100%理论峰值
- 微缩放数据类型几乎没有开销

**开源资源**:
- Blackwell微架构级基准测试仓库: https://github.com/SemiAnalysisAI/microbench-blackwell

---

*原文为付费订阅内容，此处仅摘录技术要点*
