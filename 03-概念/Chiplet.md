## 核心定义

Chiplet（小芯片）是一种先进封装技术，将原本集成在单片上的大芯片拆分为多个功能独立的小芯片模块，通过高速互连技术（如 UCIe 标准）封装在一起。Chiplet 可提升良率、降低制造成本，并支持异构集成不同工艺节点的模块。

## 关键特征

- **模块化设计**：将 SoC 按功能拆分为 CPU、GPU、I/O、内存控制器等独立 Chiplet
- **良率提升**：小芯片面积更小，制造缺陷概率降低，显著提升整体良率
- **异构集成**：不同 Chiplet 可采用最适合的工艺节点（如计算模块用 3nm，I/O 模块用 7nm）
- **成本优势**：相比单片大芯片，Chiplet 方案的制造成本可降低 30%~50%
- **UCIe 标准**：Universal Chiplet Interconnect Express 开放标准确保不同厂商 Chiplet 的互操作性
- **CoWoS 封装**：台积电 CoWoS（Chip-on-Wafer-on-Substrate）是实现 Chiplet 集成的关键先进封装工艺
- **AI 芯片应用**：NVIDIA、AMD、Intel 等均在 AI 芯片中采用 Chiplet 架构以突破单片集成极限

## 关联

[[先进封装]]、[[CoWoS]]、[[AI芯片]]
