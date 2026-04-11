# Prefill（预填充）

**定义**: 大模型接收用户输入后的一次性并行预处理阶段  
**对应阶段**: Decode（解码）之前  
**核心任务**: 计算prompt的KV Cache，生成第一个输出token

---

## 核心特点

### 计算特性
- **计算密集型**: 大规模矩阵-矩阵乘法
- **并行高效**: 一次性计算所有token之间的关联
- **GPU利用率高**: 可达70%以上
- **计算量**: 与prompt长度的平方成正比

### 关键操作
1. **Token化**: 将prompt拆分成最小单位
2. **注意力计算**: Transformer架构计算所有token关联
3. **KV Cache生成**: 生成每个token的Key和Value向量
4. **第一个token输出**: 生成第一个输出token

---

## 与Decode对比

| 维度 | Prefill | Decode |
|------|---------|--------|
| **输入** | 完整prompt（几百+ tokens） | 单个token |
| **计算方式** | 并行计算 | 自回归逐个计算 |
| **瓶颈** | 算力瓶颈 | 显存带宽瓶颈 |
| **GPU利用** | 高（70%+） | 低（~1%） |
| **计算量** | 与长度平方成正比 | 与长度线性增长 |
| **次数** | 每请求1次 | 每请求多次 |

---

## 为什么需要分离

### 1. 计算特性差异
- Prefill: 并行，充分利用GPU
- Decode: 串行，无法并行加速
- **合并问题**: 顾此失彼，要么Prefill并行潜力无法发挥，要么Decode阶段计算单元闲置

### 2. 资源瓶颈不同
- **Prefill优化**: Tensor Core加速、量化技术
- **Decode优化**: KV Cache压缩、分页管理

### 3. 工程落地需求
- 短prompt: 优化Prefill响应速度
- 长prompt: 优化Prefill显存占用 + Decode KV Cache管理

---

## 分离效果

**性能提升**:
- 内存占用降低: 60%+
- 生成速度提升: 3-5倍

**异构资源匹配**:
- Prefill → GPU集群（计算密集）
- Decode → CPU或边缘设备（轻量）

---

## 华为昇腾策略

**芯片分化**:
- **Ascend 950PR**: Prefill和推荐系统（HiBL 1.0低成本HBM）
- **Ascend 950DT**: Decode和训练（HiZQ 2.0高性能HBM）

---

## 相关概念

- [[Decode]] - 解码阶段
- [[KV Cache]] - 键值缓存
- [[投机采样]] - 加速Decode的技术
- [[昇腾950]] - 华为AI芯片

## 相关文章

- [[2026-04-05-prefill-decode-separation-explained-source|Prefill与Decode分离解析]]

---

**标签**: #LLM #Prefill #Decode #推理优化 #AI架构 #昇腾
