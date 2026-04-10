# NVLink

**定义**: NVIDIA GPU之间高速点对点互连技术  
**提出者**: NVIDIA  
**首次发布**: 2014年（NVLink 1.0）  
**核心目标**: 解决多GPU中PCIe的带宽和延迟瓶颈

---

## 发展历程

| 版本 | 时间 | 关键特性 |
|------|------|---------|
| **NVLink 1.0** | 2014 | P100芯片，双向带宽1280Gb/s |
| **NVLink 2.0** | 2017 | V100芯片，双向带宽2400Gb/s，首次引入NVSwitch |
| **NVLink 3.0** | 2020 | A100芯片，双向带宽600GB/s |
| **NVLink 4.0** | 2022 | H100芯片，双向带宽900GB/s |
| **NVLink 5.0** | 2024 | Hopper GPU，双向带宽900GB/s，NVSwitch 3.0 |
| **NVLink Fusion** | 2025 | 开放互联，支持第三方CPU/AI加速器 |

---

## 核心优势

### vs PCIe

| 维度 | NVLink | PCIe Gen 4 |
|------|--------|-----------|
| **带宽** | 900 GB/s（8 GPU配置） | 32 GB/s（单链路） |
| **延迟** | 更低 | 较高 |
| **用途** | GPU间高速互联 | 通用设备连接 |

**关键突破**: GPU之间能在更短时间内传输更多数据，同时降低延迟。

---

## NVSwitch

**作用**: GPU的交换结构，确保每个GPU以NVLink全速与其他GPU通信

**版本演进**:
- **NVSwitch 1.0**: 18端口，每端口50GB/s
- **NVSwitch 2.0**: 36端口，每端口50GB/s
- **NVSwitch 3.0**: 64端口，支持800G光互连

**拓扑**: 6个NVSwitch可实现8颗GPU全连接（Full-Mesh）

---

## NVLink-C2C

**定义**: Chip to Chip（芯片到芯片）连接  
**应用**: Grace Hopper超级芯片（Grace CPU + Hopper GPU）

**带宽**: CPU-GPU双向1.8 TB/s

---

## 与灵衢总线对比

| 维度 | NVLink | 灵衢总线 |
|------|--------|---------|
| **提出者** | NVIDIA | 华为 |
| **通信方式** | 消息传递 | Load/Store直接访问 |
| **时延** | 微秒级 | 百纳秒级 |
| **内存访问** | 需CPU转发 | 芯片间直接读写 |
| **开放性** | 2025年开放（NVLink Fusion） | 2025年开放 |
| **生态** | CUDA生态 | CANN生态 |

---

## 未来方向

1. **光学NVLink**: 硅光子技术，远距离高带宽扩展
2. **与InfiniBand集成**: 收购Mellanox后的网络级GPU集群
3. **开放生态**: NVLink Fusion支持异构计算

---

## 相关实体

- [[NVIDIA]] - 开发者
- [[黄仁勋]] - CEO
- [[Vera Rubin]] - 下一代GPU平台

## 相关文章

- [[2026-04-05-nvidia-nvlink-history-source|NVIDIA NVLink发展历史]]
- [[2026-04-05-huawei-atlas950-vs-nvidia-vera-rubin-comparison-source|华为Atlas 950 vs 英伟达Vera Rubin]]

---

**标签**: #NVIDIA #NVLink #GPU互联 #高速互连 #NVSwitch
