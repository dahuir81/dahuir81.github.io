# CMX（Context Memory eXtension）

## 核心定义

CMX是NVIDIA的上下文内存扩展方案，利用NVMe SSD闪存存储为AI推理长上下文提供低成本高容量存储层。

## 技术架构

| 组件 | 职责 |
|------|------|
| **BlueField-4 DPU** | 数据面处理 |
| **Spectrum-X以太网** | 网络传输 |
| **DOCA Memos** | 软件栈 |

## 关键特征
- **存储介质**: NVMe SSD闪存
- **延迟**: 微秒级
- **容量**: PB级别
- **场景**: 长上下文、多轮AI推理

## 与CXL的竞争
- **CMX**: 用SSD做KVCache分层存储
- **CXL**: 用扩展内存做KVCache池化
- 两者都是解决AI推理长上下文问题的方案

## 关联
- [[NVIDIA]]、[[CXL]]、[[KVCache管理]]
- [[NVLink]]、[[华为灵衢UB]]、[[内存池化]]
