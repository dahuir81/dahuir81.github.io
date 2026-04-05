# LLM Wiki（大语言模型维基）

**定义**: 由LLM持续构建和维护的持久化知识库，介于用户和原始资料之间  
**提出者**: [[Karpathy|Andrej Karpathy]]  
**提出时间**: 2026-04  
**核心思想**: 知识应该被"编译"一次后保持更新，而不是每次提问都重新推导

---

## 与传统RAG的区别

| 维度 | 传统RAG | LLM Wiki |
|------|---------|----------|
| **知识沉淀** | 无，每次从零检索 | 有，持久化存储 |
| **交叉引用** | 临时生成 | 预先建立 |
| **矛盾检测** | 无 | 主动标记 |
| **维护成本** | 低（不维护） | 接近零（LLM维护）|
| **复利效应** | 无 | 随时间增长 |

---

## 三层架构

### 1. 原始资料层 (Raw Sources)
- 文章、论文、图片、数据文件
- **不可变**——LLM只读，不修改
- 事实真相源

### 2. Wiki层 (The Wiki)
- LLM生成的Markdown文件目录
- 摘要、实体页面、概念页面、对比表格
- LLM完全拥有——创建、更新、维护

### 3. 约束架构层 (The Schema)
- 配置文件（CLAUDE.md / AGENTS.md）
- Wiki结构、命名约定、工作流规则

---

## 关键文件

### index.md - 全局索引
- 所有页面的目录
- 链接 + 一句话摘要 + 元数据
- LLM回答问题时先看index

### log.md - 操作日志
- 按时间顺序记录
- 摄入、查询、健康检查
- 只能追加（append-only）

---

## 日常操作

1. **摄入资料 (Ingest)**
   - 新资料放入原始资料库
   - LLM读取、讨论、写摘要
   - 更新目录、实体/概念页面

2. **查询 (Query)**
   - 向Wiki提问
   - LLM搜索、阅读、生成答案
   - 高质量答案存回Wiki

3. **健康检查 (Lint)**
   - 定期审查Wiki
   - 发现矛盾、孤儿页面、缺失引用

---

## 工具栈（Karpathy实际使用）

| 工具 | 用途 | 说明 |
|------|------|------|
| **Obsidian** | IDE前端 | 查看原始数据、wiki、可视化 |
| **Obsidian Web Clipper** | 数据摄入 | 网页转markdown，快捷键下载图片到本地 |
| **Marp** | 输出格式 | Markdown幻灯片 |
| **CLI工具** | 查询处理 | 更大查询通过CLI交给LLM |
| **自研搜索引擎** | 额外工具 | vibe coded的小型搜索工具 |

**关键原则**: LLM编写和维护所有wiki数据，人很少直接触碰。

**规模参考**: ~100篇文章，~400K words（小规模下无需复杂RAG）

---

## 健康检查 (Linting)

Karpathy的具体实践：
- **自动维护**: LLM自动维护索引文件和文档摘要
- **发现不一致**: 运行"health checks"发现数据矛盾
- **补全缺失**: 通过web搜索输入缺失数据
- **发现连接**: 找到新文章候选的有趣连接
- **增量清理**: 持续增强数据完整性

> "The LLMs are quite good at suggesting further questions to ask and look into"

## 未来方向

**合成数据生成**:
- 微调让LLM在权重中"知道"数据
- 而非仅依赖上下文窗口

> "I think there is room here for an incredible new product instead of a hacky collection of scripts"

## 相关实体

- [[Karpathy]] - 理论提出者
- [[Farza]] - Farzapedia实践者
- [[Vannevar Bush]] - 1945年Memex构想提出者

## 相关概念

- [[RAG]] - LLM Wiki替代的传统方案
- [[Memex]] - 80年前的先驱构想
- [[知识编译]] - 从搜索到编译的范式转变

## 相关文章

- [[2026-04-05-karpathy-llm-wiki-paradigm|Karpathy的LLM Wiki范式]]
- [[2026-04-05-xinzhiyuan-llm-wiki-analysis-source|新智元深度分析]]
- [[2026-04-05-karpathy-twitter-llm-knowledge-base-source|Twitter原文]]

## 我们的实践

**试点文章**: [[2026-04-05-karpathy-llm-wiki-paradigm|Karpathy的LLM Wiki范式]]

**原文资料**:
- [[2026-04-05-karpathy-llm-wiki-source|中文翻译版]]
- [[2026-04-05-karpathy-twitter-llm-knowledge-base-source|Twitter原文]]
- [[2026-04-05-xinzhiyuan-llm-wiki-analysis-source|新智元深度分析]]

**实施阶段**:
- 阶段1: index.md + log.md + 原文资料归档
- 阶段2: 实体页面自动创建 + 主题标签
- 阶段3: 知识图谱可视化 + 智能问答

---

**标签**: #知识管理 #AI #Obsidian #方法论 #范式转变
