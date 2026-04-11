# J.P. Morgan 台积电CoWoS与先进封装核心洞察

**原文**: [[2026-04-08-JP-Morgan-TSMC-CoWoS-Advanced-Packaging]]
**报告标题**: TSMC: CoWoS and Advanced Back-end Updates
**发布日期**: 2026年4月8日
**分析师**: Gokul Hariharan, Jennifer Hsieh, David Chou, Jason Chen, Subham Singhania
**评级**: Overweight（看好）
**目标价**: NT$2,400（2026年12月）
**当前价**: NT$1,950（2026年4月8日）

---

## 核心观点速览

J.P. Morgan上调了台积电CoWoS和SoIC产能预期，反映了AI芯片需求的强劲增长。报告详细分析了NVIDIA、Broadcom、Google、AMD等主要客户的CoWoS需求变化，以及2028年后Feynman架构的技术路线。

---

## 一、CoWoS产能预测上调

### 1.1 台积电CoWoS产能规划

| 时间节点 | CoWoS产能 (wfpm) | 变化 |
|----------|------------------|------|
| 2026年底 | **115K** | 上调 |
| 2027年底 | **155K** | 上调 |
| 2028年底 | **175K** | 上调 |

**非台积电CoWoS产能**（ASE、Amkor等）：
- 2027年底: ~25K wfpm
- 2028年底: ~35K wfpm

### 1.2 SoIC产能大幅提升

| 时间节点 | SoIC产能 (wfpm) | 驱动因素 |
|----------|----------------|----------|
| 2027年底 | **35K** | 2nm AI ASIC、硅光/CPO |
| 2028年底 | **65K** | TPU v9、Trainium 4、Meta MTIA、OpenAI ASIC |

**SoIC需求驱动**:
- 2nm级AI ASIC采用3D封装
- 硅光子/CPO（共封装光学）需求增长
- TSMC COUPE平台使用SoIC进行EIC-PIC集成

### 1.3 CoPoS（面板级封装）

- **时间点**: 2028年及以后
- **状态**: 目前仍处于工程和试产阶段
- **潜力**: 可能成为2028年后产能扩张的重点

---

## 二、NVIDIA：Blackwell上调，Rubin下调

### 2.1 2026年预测调整

| 产品 | 原预测 | 新预测 | 变化 | 原因 |
|------|--------|--------|------|------|
| Blackwell | 4.3M units | **5.8M units** | +35% | 需求强劲 |
| Rubin | 2.8M units | **2.2M units** | -21% | HBM4供应问题 |
| **GPU总出货量** | - | **8.3M units** | +34% YoY | - |
| CoWoS晶圆 | 703K | **675K** | -4% | 产品结构变化 |

### 2.2 2027年预测

- CoWoS预测**上调3%**
- 所有Rubin Ultra GPU采用**2-die per interposer**设计
- 主流方案: 4-die per package
- 2-die方案CoWoS晶圆效率更高（~10 dies per wafer）

### 2.3 Feynman（2028年）技术路线

**高端版本**:
- 制程: TSMC A16（1.6nm）
- 封装: **3D SoIC**（堆叠多个逻辑die，可能GPU+SRAM）

**基础版本**:
- 制程: TSMC N2P（2nm）
- 封装: 2.5D，2-die-on-interposer

**封装技术**:
- 可能采用**CoPoS**（取决于技术成熟度和良率）

---

## 三、Broadcom：TPU需求大幅上调

### 3.1 CoWoS预测大幅上调

| 年份 | 原预测 | 新预测 | 变化 |
|------|--------|--------|------|
| 2026 | - | **250K** | 大幅上调 |
| 2027 | - | **400K** | 大幅上调 |

### 3.2 TPU出货量预测

| 产品 | 2026 | 2027 |
|------|------|------|
| TPU v7 (Ironwood) | 4.3M units | 6.9M units |
| TPU v8 (Sunfish/Zebrafish) | - | - |

**驱动因素**: 外部客户需求增加（特别是Ironwood和Sunfish）

### 3.3 TPU v9（2028年）双轨竞争

Google设计团队正在开发两个竞争方案：

| 方案 | 供应商 | 技术路线 | 风险 |
|------|--------|----------|------|
| **Pumafish** | Broadcom | 3D SoIC + TSMC CoWoS-L | 较低 |
| **Humufish** | MediaTek | 3D SoIC + Intel EMIB-T | **较高** |

**MediaTek方案风险**:
1. Serdes: 300G vs Broadcom 400G
2. Intel EMIB封装无AI加速器经验
3. 多die设计窗口紧张

---

## 四、其他客户动态

### 4.1 AWS Trainium 3

- 2026年CoWoS预测**下调13%**（时间推迟）
- 2027年预测**上调19%**
- 生命周期总出货量: **4.4M units**
- 需求来源: Anthropic和AWS内部工作负载
- 2027年可能外包部分产能给ASE

### 4.2 AMD

- 2026年CoWoS预测**下调**（77K vs 90K）
- 原因: MI450延迟（2nm top-die重新流片、HBM4表征挑战）
- 2027年预测**不变**
- 潜在上行: Venice CPU、MI450顺利量产

### 4.3 Meta MTIA

- 2026年预测**保持低迷**
- 2027年供应链准备**不温不火**

### 4.4 Microsoft MAIA

- 2027年预测**略微乐观**

---

## 五、技术趋势

### 5.1 封装技术演进

| 时间 | 技术 | 应用 |
|------|------|------|
| 2024-2026 | CoWoS-S/L | 主流AI芯片 |
| 2027 | CoWoS-L + SoIC | TPU v9、Rubin Ultra |
| 2028+ | **3D SoIC** + **CoPoS** | Feynman、下一代ASIC |

### 5.2 制程节点竞争

| 客户 | 2026 | 2027 | 2028 |
|------|------|------|------|
| NVIDIA | N3P (Blackwell) | N3P (Rubin) | A16/N2P (Feynman) |
| Google TPU | N3P (v7) | N3P (v8) | N2 (v9) |
| AMD | N3P/N2 (MI450) | N2 | - |

---

## 六、投资要点

### 6.1 看好理由

1. **CoWoS产能持续扩张**: 2026-2028年CAGR ~23%
2. **SoIC成为新增长点**: 2027-2028年需求爆发
3. **客户多元化**: 从NVIDIA一家独大到Broadcom、Google、AMD等多极增长
4. **技术领先**: 3D SoIC、CoPoS等先进封装技术保持领先

### 6.2 风险提示

1. **HBM供应瓶颈**: 影响Rubin等高端产品量产
2. **CoWoS-R产能紧张**: 可能导致部分订单外流至ASE
3. **技术竞争**: Intel EMIB-T等竞争技术可能分流订单

---

## 七、关键数据对比

### J.P. Morgan vs Morgan Stanley CoWoS预测

| 来源 | 2026年底 | 2027年底 | 2028年底 |
|------|----------|----------|----------|
| **J.P. Morgan** | **115K** | **155K** | **175K** |
| Morgan Stanley | 125K | - | - |

**差异**: J.P. Morgan预测略保守，但两者都显示强劲增长趋势。

---

## 八、核心结论

1. **CoWoS需求持续强劲**: 2026-2028年产能CAGR ~23%
2. **SoIC成为新引擎**: 2027-2028年产能翻倍以上增长
3. **客户结构优化**: Broadcom、Google等客户贡献增量
4. **技术持续领先**: 3D SoIC、CoPoS等新技术巩固护城河
5. **目标价NT$2,400**: 对应2026年P/E ~25x，看好评级维持

---

**标签**: #台积电 #TSMC #CoWoS #SoIC #先进封装 #AI芯片 #NVIDIA #Broadcom #JPMorgan
