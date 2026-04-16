# CPO（Co-Packaged Optics，共封装光学）

**来源**: Sigurd Microelectronics CTO 田庆诚演讲
**日期**: 2026-04-13存档

## 核心概念

**CPO**: 将光引擎（OE）与交换芯片/XPU共封装，降低功耗和延迟

## 技术演进路线（TSMC）

| 阶段 | 形态 | 带宽 | 时间 | 功耗/延迟 |
|------|------|------|------|-----------|
| Pluggable | OSFP可插拔 | 1.6Tbps | 2025 | 基准 |
| CPO+Switch | OE on Substrate | 6.4Tbps | 2026 | 功耗50%，延迟10% |
| CPO+XPU | OE on Interposer | 12.8Tbps | 研发中 | 功耗10%，延迟5% |

## COUPE技术
- **全称**: Compact Universal Photonic Engine
- **工艺**: SolC-X（EIC-on-PIC 3D堆叠）
- **优势**: 无与伦比的互连密度，最优系统功耗

## CPO封装测试流程

```
EIC晶圆 → CP测试 → 减薄 → 3D SoIC键合
PIC晶圆 → 光学分选 → 检测清洁
→ OE芯片切割 → CPO组装 → 透镜检测 → 插座安装
→ 双面晶圆测试 → 光引擎封装测试 → 光纤连接器 → 系统级测试
```

## 关键挑战

1. **µLens检测与清洁**: AOI自动光学检测
2. **高速测试**: 112-224Gbps，带宽达110GHz
3. **精密对准**: 光纤连接器精度要求极高
4. **自动化生产**: Suruga TW、ficonTEC等全自动产线

## 产业链

| 环节 | 公司 |
|------|------|
| 代工 | TSMC（COUPE/SoIC） |
| OSAT | 矽格（Sigurd） |
| 光引擎 | Browave、Foxconn、Fabrinet |
| 外置激光源 | Coherent、Lumentum、住友 |
| 连接器 | Senko、Corning |
| 测试设备 | MPI、ficonTEC、Cortex Robotics |
| 高速Socket | Winway |

## 投资启示

- **光互联需求**: 800G/1.6T持续旺盛，订单可见度至2028年
- **CPO是AI算力瓶颈突破关键**: NVIDIA已在GTC 2025展示CPO方案
- **测试环节**: 先进测试设备公司受益（MPI、ficonTEC）
- **OSAT**: 矽格全球OSAT排名前12，5100员工，14个工厂
