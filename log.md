# 知识库操作日志

## 2026-04-12 (00:16)

**操作**: 知识库目录重构 + 简报归档规则确立
**来源**: 慧哥与 Tars/Claude Code 对话确认

**重大变更**:
1. **简报归档规则确立**: 非博客类内容（简报/研报摘要/数据表分析）统一归档到 `08-参考/主题/`，不进入 `05-博客/`
   - 按主题分子目录：`AI芯片/`、`HBM/`、`Bloomberg/` 等
   - PDF 原件仍存 `04-原文资料/`，简报存 `08-参考/`
2. **AGENTS.md 新增 §6.3**: 简报/研报归档流程
3. **00-MOC.md 更新**: `08-参考/` 补充 AI芯片/、HBM/ 子目录链接
4. **历史文件清理**:
   - `TARS-WORKFLOW.md` → 删除（内容已被 AGENTS.md 完全替代）
   - `CHECKLIST.md` → `09-归档/legacy-docs/`
   - `PUBLISH_WORKFLOW.md` → `09-归档/legacy-docs/`
   - `README.md` → `09-归档/legacy-docs/`

**已归档简报**:
- `08-参考/HBM/2026-04-11-HBM产能简报-三大厂商产线布局.md`
- `08-参考/AI芯片/2026-04-11-中国AI芯片十小龙技术对比简报.md`

**处理器**: Claude Code

## 2026-04-11 (23:41)

**操作**: HBM产能数据表 → 简报整理
**来源**: 慧哥提供的图片数据表

**三大厂商产能对比**:
| 厂商 | 年初产能 | 年末产能 | 增长 |
|------|---------|---------|------|
| Samsung | 630K | 700K (+11%) |
| SK hynix | 560K | 605K (+8%) |
| Micron | 345K | 365K (+6%) |
| **合计** | **1,535K** | **1,670K (+9%)** |

**关键新产线**:
- **Samsung P4L**: 2025/3Q投产，10K → 65K（+55K）
- **SK hynix M15x**: 2026/2Q投产，5K → 40K（+35K）
- 新产线合计贡献+90K（占行业增长的67%）

**地域分布（年末）**:
- 韩国: 930K（56%）
- 台湾: 240K（14%，美光OMT）
- 中国: 190K（11%，SK海力士无锡）

**关键洞察**:
- Samsung保持领先（41%市占率）
- 新产线是增长主驱动力
- AI HBM需求约250K WPM，占总产能15%

**简报文件**: 
- 08-参考/AI芯片/2026-04-11-中国AI芯片十小龙技术对比简报.md
- 08-参考/HBM/2026-04-11-HBM产能简报-三大厂商产线布局.md
**处理器**: Tars

## 2026-04-11 (23:37)

**操作**: SoIC概念详解 → 知识库
**来源**: 慧哥提问"SOIC具体什么什么技术"

**SoIC技术要点**:
- **全称**: System-on-Integrated-Chips（系统级集成芯片）
- **类型**: 3D封装技术（vs CoWoS是2.5D）
- **核心技术**: 铜-铜直接键合（Cu-Cu Bonding）
- **互连间距**: ~9微米（CoWoS ~55微米）
- **互连密度**: ~100K/mm²（CoWoS ~10K/mm²）

**两种技术路线**:
- SoIC-P: 聚合物粘合，适合存储器堆叠
- SoIC-C: 铜键合，适合高性能计算

**应用场景**:
- 当前: AMD 3D V-Cache、MI300X
- 2028年: Google TPU v9、AWS Trainium 4、NVIDIA Feynman高端版

**产能预测**:
- 2027年底: 35K wfpm
- 2028年底: 65K wfpm（翻倍）

**核心优势**:
- 互连密度提升10倍
- 延迟降低50%
- 功耗降低30%

**技术挑战**:
- 散热困难
- 设计复杂度高
- 测试难度大

**新建概念**: [[SoIC封装]]
**处理器**: Tars

## 2026-04-11 (22:15)

**操作**: J.P. Morgan台积电CoWoS研报 → 知识库归档
**来源**: 慧哥上传PDF（2026-04-08发布）
**报告**: TSMC: CoWoS and Advanced Back-end Updates (16页)

**核心内容**:
1. **CoWoS产能上调**: 2026年底115K → 2027年底155K → 2028年底175K wfpm
2. **SoIC产能爆发**: 2027年底35K → 2028年底65K wfpm（反映2nm AI ASIC和CPO需求）
3. **NVIDIA动态**:
   - Blackwell: 5.8M units (+35%，需求强劲)
   - Rubin: 2.2M units (-21%，HBM4供应问题)
   - Feynman: 2028年高端A16+3D SoIC，基础N2P+2.5D
4. **Broadcom TPU**: 2026年250K → 2027年400K CoWoS晶圆（大幅上调）
5. **TPU v9竞争**: Broadcom Pumafish vs MediaTek Humufish双轨开发
6. **其他客户**: Trainium 3推迟但2027年上调，AMD MI450延迟

**关键数据**:
- 台积电目标价: NT$2,400（当前NT$1,950）
- 评级: Overweight
- 非台积电CoWoS: 2027年25K → 2028年35K wfpm（ASE、Amkor）

**对比Morgan Stanley**:
- JPM: 2026年底115K vs MS: 125K（略保守）
- 两者都看好CoWoS和SoIC增长趋势

**归档文件**:
- PDF: 04-原文资料/2026-04-08-JP-Morgan-TSMC-CoWoS-Advanced-Packaging.pdf
- MD: 04-原文资料/2026-04-08-JP-Morgan-TSMC-CoWoS-Advanced-Packaging.md
- 洞察: 04-原文资料/2026-04-08-JP-Morgan-TSMC-CoWoS-核心洞察.md

**处理器**: Tars

## 2026-04-11 (22:12)

**操作**: CC技术诊断报告归档 → 知识库
**来源**: 慧哥转发CC关于钉钉Markdown reasoning泄漏问题的诊断

**问题描述**:
- 钉钉对话中出现英文 thinking 内容（如 "Let me...", "I need to..."）
- 飞书正常，不受影响
- OpenClaw 4.9 版本后出现

**根因分析**:
- 直接原因: `reply-strategy-markdown.ts` 的 `deliver` 方法未判断 `isReasoning` 字段
- 深层原因: 百炼API总是返回reasoning_content + OpenClaw 4.9更积极保留reasoning字段
- 雪上加霜: `inbound-handler.ts:1953` 硬编码 `isReasoning: false`

**修复方案**:
- **P0必改**: `reply-strategy-markdown.ts` 添加 `if (payload.isReasoning === true) return;`
- **P1加固**: `inbound-handler.ts:1953` 根据实际内容判断
- **P2顺手**: "✅ Done" → "✅ 完成"
- **P3可选**: 注册空的 `onReasoningStream` 回调

**归档文件**:
- 原文: 04-原文资料/2026-04-11-钉钉Markdown-reasoning泄漏问题诊断.md
- 概念: 03-概念/OpenClaw-Reasoning泄漏问题.md

**新建概念**: [[OpenClaw-Reasoning泄漏问题]]
**处理器**: Tars

## 2026-04-11 (21:35)

**操作**: 中国AI芯片十小龙深度分析 → 博客文章+简报
**来源**: 慧哥要求深入分析报告中的十小龙技术对比和价格数据

**博客文章1**: 中国AI芯片十小龙深度解析：技术对比与价格竞争力分析
- **文件**: 05-博客/2026-04-11-china-ai-chip-10-dragons-analysis.md
- **字数**: ~6000字
- **核心内容**:
  - 十小龙全景图（华为昇腾50%+市场份额）
  - 三大技术路线对比（自研架构/x86兼容/通用GPU）
  - 性能对比：7nm节点TPP不输A100，华为昇腾每瓦性能领先32%
  - 价格竞争力：国产芯片价格30-60%，每美元性能领先50-200%
  - TCO对比：3年总拥有成本降低66-72%
  - 估值分析：中芯国际7.7x、北方华创7.5x（看好）；海光33x、寒武纪51x（偏高）
  - 投资机会与风险提示

**博客文章2**: 中国AI芯片十小龙技术对比简报
- **文件**: 05-博客/2026-04-11-中国AI芯片十小龙技术对比简报.md
- **字数**: ~3000字
- **形式**: 表格化简报，便于快速查阅

**关键数据提炼**:
- 华为昇腾910B: TPP 320 TFLOPS (+2.6% vs A100), 每瓦性能+32%
- 天数智芯天垓200: TPP 330 TFLOPS (+5.8% vs A100)
- 价格优势: 国产芯片$6,000-8,000 vs A100 $10,000
- TCO优势: 华为方案3年$60,000 vs H200方案$215,000 (-72%)

**状态**: 两篇博客文章已生成，待GitHub发布
**处理器**: Tars

## 2026-04-11 (21:30)

**操作**: Morgan Stanley 国产GPU研报 → 博客发布
**来源**: 慧哥上传PDF，要求提取原文并发布博客
**报告**: Global and China AI GPU Industry – Can China Close the Gap with the US? (58页)

**博客文章**: 摩根士丹利深度研报：中国AI GPU能否追上美国？
- **文件**: 05-博客/2026-04-11-morgan-stanley-china-gpu-gap-analysis.md
- **字数**: ~5000字，7大章节
- **核心内容**:
  1. 全球AI半导体市场：万亿美元俱乐部
  2. 台积电：AI时代的"卖铲人"
  3. 中国AI GPU：十小龙的崛起
  4. 技术差距评估：7nm节点的拐点
  5. 产业链脱钩：两套体系的诞生
  6. 投资机会：摩根士丹利的评级
  7. 核心结论与最终判断

**关键数据**:
- 2026年全球云资本支出: $6320亿 → 2028年: $1万亿
- 2030年中国AI芯片TAM: $670亿，自给率: 76%
- 2027年国产芯片价值首次超越美国芯片
- 7nm工艺下国产芯片性能不输A100，每美元性能显著领先

**原文存档**:
- PDF: 04-原文资料/2026-04-11-Morgan-Stanley-国产GPU研究报告-完整版.pdf
- Markdown: 04-原文资料/2026-04-11-Morgan-Stanley-国产GPU研究报告-完整版.md

**状态**: 博客文章已生成，待GitHub发布（token问题待解决）
**处理器**: Tars

## 2026-04-11 (21:15)

**操作**: Morgan Stanley 国产GPU研究报告入库
**来源**: 慧哥上传PDF文件
**原始文件**: Morgan_Stanley-国产_GPU.pdf（58页）
**发布日期**: 2026年3月12日
**分析师**: Charlie Chan, Daniel Yen, Daisy Dai 等（Morgan Stanley台湾/香港团队）

**核心内容**:
1. **全球AI半导体市场**: 2026年云资本支出$6320亿，2030年半导体市场$1万亿
2. **台积电产能**: CoWoS 2026年扩至125kwpm，AI半导体收入占比将达60%（2029e）
3. **中国AI芯片市场**: 2030年TAM $670亿，自给率76%，2027年国产芯片价值超越美国
4. **技术差距**: 7nm同代工艺下国产芯片性能不输A100，每美元性能显著领先
5. **产业链**: 华为昇腾市场份额>50%，中芯国际N+2→N+3演进
6. **瓶颈**: WFE设备、EDA工具、EUV光刻机受限

**新建实体**:
- [[Morgan Stanley]]（投资银行/研究机构）
- [[台积电]]（TSMC，晶圆代工龙头）
- [[中芯国际]]（SMIC，国产AI芯片制造核心）
- [[华为昇腾]]（Ascend，中国AI芯片领导者）

**新建概念**:
- [[AI芯片自给率]]（中国76%目标路径）
- [[CoWoS封装]]（2.5D先进封装技术）

**存档**:
- [[2026-04-11-Morgan-Stanley-国产GPU研究报告.pdf]]（PDF原文）
- [[2026-04-11-Morgan-Stanley-国产GPU-核心洞察]]（核心洞察整理）

**索引**: 已更新
**处理器**: Tars

## 2026-04-11 (13:36)

**操作**: DeepSeek V4 情报整理 + 光学压缩论文解析 → 知识库入库
**来源**: 慧哥与Tars对话讨论（2026-04-11 13:05-13:36）
**原始信源**:
- 腾讯新闻《创智记》: https://news.qq.com/rain/a/20260410A024R200
- ZOL: https://ai.zol.com.cn/1162/11620761.html
- AITOP100: https://www.aitop100.cn/deepseek-v4
- 新浪: https://k.sina.cn/article_7857201856_1d45362c001904472g.html
- 论文: https://arxiv.org/abs/2510.18234
- 代码: https://github.com/deepseek-ai/DeepSeek-OCR

**内容1 - DeepSeek V4 情报:**
- 定档4月下旬发布，万亿参数MoE，百万上下文
- 定价每百万token仅0.3美元，比GPT旗舰便宜10倍
- 首次适配华为昇腾等国产芯片
- 四大突破：长期记忆(Engram)、编程跃升、原生多模态、AI搜索强化
- **信源核实**: 芯片市场报道为二手信息，无原始出处；昇腾适配≠生产可用

**内容2 - DeepSeek-OCR 光学压缩技术:**
- 核心思路：视觉token代替文本token，压缩比10-20倍
- 架构：DeepEncoder(SAM+16倍卷积压缩+CLIP) + DeepSeek 3B MoE解码
- 10×压缩下精度>96%，20×压缩仍有~60%精度
- 单张A100-40G每天3300万页
- 可能是V4百万上下文的关键技术底座
- 原理：二维排版天然携带语义，注意力计算从O(n²)暴降

**新建概念**: [[光学压缩]]（完整技术解析）
**更新实体**: [[DeepSeek]]（V4情报+OCR技术+产业影响+信源核实）
**存档**: [[2026-04-11-DeepSeek-V4情报与光学压缩技术讨论-source|原文存档]]
**索引**: 已更新
**处理器**: Tars

## 2026-04-11 (00:15)

**操作**: 处理两篇微信文章入库
**来源1**: https://mp.weixin.qq.com/s/s-ztuNJ1LvlpIlI_KUwqzQ (词元抖动 / AIFUT大会)
**来源2**: https://mp.weixin.qq.com/s/F9zdoO5dARs-cKk5ob1YiA (中国IDC圈 / 字节阿里IDC规划)

**文章1 - AIFUT大会与卡兹克门童哲学:**
- 卡兹克十年历程：UI设计师→全栈设计师→AI内容创业者→万人大会发起人
- AIFUT数据：1518人到场，200万+场观，3500㎡展区，34家企业参展
- Agent三阶段模型：ChatGPT(1x) → Agent(10-50x) → 自学习(100x+)
- 核心洞察：84%的人还没跟AI说过话，「感知差」是门童工作的价值锚点
- 金句：「想出那个题目才是真正重要的事」「Agent越强，人的判断力越值钱」
- **新建实体**: [[卡兹克]]、[[傅盛]]、[[罗振宇]]、[[朱广翔]]、[[谢思远]]
- **新建概念**: [[门童哲学]]、[[15度夹角理论]]、[[感知差]]、[[系统0]]
- **存档**: [[2026-04-11-AIFUT大会与卡兹克门童哲学-source|原文存档]]

**文章2 - 字节阿里IDC规划与国产替代:**
- 字节2026国内IDC需求1.4-1.5GW（全球1.8GW），Q1已完成1GW招标
- 阿里2026 IDC需求约2GW，4月启动首批500MW招标
- 国产替代加速：阿里20-30%、字节15-20%，且持续上升
- 字节自研芯片：2026年预计出货5万颗，性能对标H20，与三星对接代工
- 液冷成标配：新招标95%机柜21kW+5%达50kW，超过21kW必须液冷
- 服务器电源需求：通用130万个 vs AI服务器220万个
- 交付周期拉长：2026年招标部分2027年交付，字节Q1仅40%年内交付
- **新建实体**: [[字节跳动]]、[[阿里巴巴]]、[[华为昇腾]]
- **新建概念**: [[重资产博弈]]、[[能耗指标]]、[[液冷标配]]
- **存档**: [[2026-04-11-字节阿里IDC规划与国产替代-source|原文存档]]

**索引**: 已更新
**处理器**: Tars

## 2026-04-10 (10:35)

**操作**: 处理微信文章 — Anthropic 炒作大辞典
**来源**: https://mp.weixin.qq.com/s/MyqqY0RY6VFSgJc6vv0iFg
**来源**: 品玩（PingWest）作者王兆洋
**存档**: [[2026-04-10-Anthropic炒作大辞典-source|原文存档]]
**核心发现**: 35 个 Anthropic 术语的"说人话"翻译，揭示从科普到商战到政策游说的三层演变
**索引**: 已更新
**处理器**: Tars

## 2026-04-10 (10:15)

**操作**: Anthropic自研芯片深度分析整理入库
**来源**: Reuters独家报道（2026-04-09）+ 证券时报/TradingKey/新浪财经等综合
**关键信息**: Reuters 4/9独家披露Anthropic探索自研芯片，早期阶段，无团队，可能仅采购外部芯片
**分析要点**: 动机（算力需求暴涨+OpenAI竞赛）、现有布局（3.5GW TPU+多云多芯）、可行性（资金充裕但成本高周期长）、商业判断（信号意义>实质，IPO叙事）
**存档**: [[2026-04-10-Anthropic自研芯片深度分析-source|原文存档]]
**索引**: 已更新
**处理器**: Tars

## 2026-04-10 (08:04)

**操作**: 今早阿里讨论整理入库
**来源**: 多平台新闻综合（新浪财经、财新、The Information、Benzinga、知乎、雪球等）
**存档**: [[2026-04-10-阿里AI战略与HappyHorse深度分析-source|原文存档]]
**新建实体**: [[张迪]]（可灵之父/淘天未来生活实验室）、[[HappyHorse]]（AI视频模型）
**索引**: 已更新
**处理器**: Tars

## 2026-04-09 (23:39)

**操作**: 处理微信文章 — 脱口秀 Skill 与神之一手
**来源**: https://mp.weixin.qq.com/s/7y__hScgDkmoOtexYG4F4A
**来源**: 白鸽（灵感来源：卡兹克开源 Skill）
**存档**: [[2026-04-09-脱口秀Skill与神之一手-source|原文存档]]
**新建概念**: [[神之一手]]、[[AI创作方法论]]
**索引**: 已更新
**处理器**: Tars

## 2026-04-09 (23:35)

**操作**: 处理三篇架构师（若飞）微信文章 — Claude Agent 战略系列
**来源**:
1. https://mp.weixin.qq.com/s/WsNQWXz1_kAQtHRvBtC11Q — Claude Managed Agents 深度解读
2. https://mp.weixin.qq.com/s/L0fGwMIh4HOXrg-Xi_BcWA — Coding Agent 六大核心组件
3. https://mp.weixin.qq.com/s/SBkOZ2VyHG2Q2BCIJawNIg — Claude Code 长任务 Runtime 深度解读

**存档**:
- [[2026-04-09-Claude-Managed-Agents-source|原文存档 1]]
- [[2026-04-09-Coding-Agent-六大组件-source|原文存档 2]]
- [[2026-04-09-Claude-Code-长任务-Runtime-source|原文存档 3]]

**新建概念**: [[Agent运行底座]]、[[SessionMemory]]
**新建实体**: [[Claude Managed Agents]]
**博客**: 2026-04-09-anthropic-agent-strategy-deep-dive.md → 已发布
**索引**: 已更新
**处理器**: Tars

## 2026-04-09 (23:05)

**操作**: CXL 内容整合 — 多源合并为完整 Wiki
**来源**: 慧哥提供文章 + 知识库已有内容交叉整合
**处理人**: Tars

### 整合来源
1. `原文资料/2026-04-09-CXL深度解读全解析-source.md` — 六大板块完整文章
2. `博客文章/2026-03-25-arm-agi-cpu.md` — Arm AGI CPU 中的 CXL 3 支持信息
3. 存储芯片价格暴涨背景下的 CXL TCO 价值关联

### 创建文件
1. `Concepts/CXL.md` — **完整 Wiki**（10 大板块，6500 字）
2. `Concepts/内存墙.md` — CXL 要解决的核心瓶颈
3. `Concepts/缓存一致性.md` — CXL.cache 子协议核心能力
4. `Concepts/华为灵衢UB.md` — 华为自主互连协议，CXL 的竞争路线
5. `Entities/Intel.md` — CXL 联盟发起者
6. `Entities/Arm.md` — AGI CPU 原生支持 CXL 3
7. `Entities/阿里云.md` — CXL 双场景落地实践
8. `index.md` — 更新索引和概念条目

### CXL Wiki 十大板块
1. 诞生背景：三大核心瓶颈
2. 协议架构：CXL.io/cache/mem + 三种设备类型
3. 技术演进：1.0→4.0 路线图
4. 巨头战略：Intel/AMD/Nvidia/谷歌
5. 中国实践：阿里云/华为/Arm AGI CPU
6. 行业争议：SemiAnalysis 修正共识
7. 产业链全景：协议层/芯片层/IP 层
8. 三方案对比：CXL vs 灵衢 UB vs NVLink
9. 存储涨价关联：CXL 的 TCO 价值
10. 关键时间线：2019→2028

---

## 2026-04-09 (12:35)

**操作**: 执行 Wiki 知识库工作流 - UBS：SK海力士 Key Call
**来源**: UBS Securities（Nicolas Gaudois 等）
**处理人**: Tars

### 创建文件
1. `原文资料/2026-04-09-UBS-SK-Hynix-Key-Call.md` - UBS研报完整存档
2. `Entities/SK海力士.md` - 韩国存储芯片巨头
3. `Concepts/DRAM周期.md` - UBS判断30年一遇的存储周期
4. `index.md` - 更新索引

### 核心信息

**UBS评级**: Buy，目标价₩1,700,000（当前₩916,000，上行+86%）

**30年一遇的存储周期**:
- DRAM短缺持续至2027Q4
- HBM需求蚕食DDR产能（2026年25% → 2027年31%）
- 晶圆产能扩张受限，新增主要投HBM

**盈利预测大幅上调**:
- 2026E OP ₩286万亿（超共识57%）
- 2027E OP ₩443万亿（超共识88%）
- 2026E EPS +22%，2027E +29%

**ASP暴涨**:
- DRAM +167%（2026E），DDR +264%
- NAND +213%（2026E）
- HBM +36%（2027E）

**利润率**: DRAM OP margin 84.3% → 86.3%

**HBM份额**: 2026年51% → 2027年44%（仍保持领先）

---

## 2026-04-09 (12:30)

**操作**: 执行 Wiki 知识库工作流 - 科技早报 2026-04-09
**来源**: 知识星球「Global Semi Research」
**处理人**: Tars

### 创建文件
1. `原文资料/2026-04-09-科技早报-source.md` - 完整早报存档
2. `Entities/Tecto.md` - 拉美数据中心运营商
3. `Concepts/AI硬件强应用弱.md` - AI产业链分化趋势
4. `Concepts/AI算力基建.md` - 全球数据中心扩张潮
5. `Concepts/数据主权.md` - 数据本地化监管趋势
6. `index.md` - 更新索引

### 核心信息

**市场**: 美伊停火协议引爆风险资产，标普+2.5%/纳指+2.9%，沪指逼近4000点

**AI硬件强应用弱**:
- IGV与SOX收益差-727bp创五年最差
- 年内半导体vs软件收益差距35%
- 资金只认"卖铲子"逻辑

**台积电**: Q1毛利率67%，2026/2027营收+35%/+27%，资本开支560亿/650亿美元

**Anthropic**: 年化收入3月190亿→4月突破300亿美元，估值3500亿，员工惜售等IPO

**数据中心全球扩张**:
- TikTok 10亿欧元芬兰建第二座
- Tecto 20亿美元巴西建5座
- 全球算力基建进入"圈地时代"

---

## 2026-04-09 (10:31)

**操作**: 执行 Wiki 知识库工作流 - Hermes Agent vs 小龙虾对比
**来源**: https://mp.weixin.qq.com/s/8rB9Sf08Of89tCeljtjOXg (AI范儿)
**处理人**: Tars

### 创建文件
1. `原文资料/2026-04-09-Hermes-Agent-vs-OpenClaw-source.md` - 完整原文存档
2. `Concepts/程序性记忆.md` - Hermes 核心卖点：AI 自动写 Skill
3. `index.md` - 更新索引

### 补充发现
- **开箱即用**: 28 工具 + 92 skills 默认配置，比小龙虾上手简单
- **14 种性格**: /personality 即时切换（含 catgirl、pirate 等整活型）
- **三级渐进式加载**: 只加载技能名称描述(~3000 token)，按需完整加载
- **外部记忆插件**: 8 个支持(Honcho/Mem0/Hindsight 等)
- **框架级安全**: 危险 Skill 直接拒绝安装，--force 才放行
- **重要信息**: Claude 已封杀 Hermes 订阅，只能用 API（与小龙虾同命运）

---

## 2026-04-09 (10:17)

**操作**: 执行 Wiki 知识库工作流 - Hermes Agent 架构拆解
**来源**: https://mp.weixin.qq.com/s/dyamkjN7w-3q2ggzxRq0sg (架构师·若飞)
**处理人**: Tars

### 创建文件
1. `原文资料/2026-04-09-Hermes Agent 架构拆解-source.md` - 完整原文存档
2. `Entities/Hermes Agent.md` - Nous Research 开源 Agent Runtime
3. `Entities/Nous Research.md` - AI 研究机构
4. `Concepts/闭环学习循环.md` - Hermes 核心机制
5. `Concepts/七层纵深防御.md` - Hermes 安全模型
6. `Concepts/Harness.md` - AI Agent 模型之外的系统层
7. `index.md` - 更新索引

### 核心信息

**Hermes vs OpenClaw 定位差异**:
- OpenClaw = 网关 (多渠道调度)
- Hermes = 引擎 (执行循环 + 自我进化)

**Skill 沉淀机制**:
- 非硬触发，best-effort 后台 review
- 系统提示引导 5+ 工具调用时保存
- 每 10 轮工具迭代触发子 Agent 复盘
- 122 个内置 SKILL.md，26 个类目

**记忆分层**:
- MEMORY.md (~800 tokens)
- USER.md (~500 tokens)
- state.db (SQLite + FTS5，无限)

**安全**: 七层纵深防御，30+ 危险命令正则匹配

**最新版本**: v0.8.0 (2026-04-08)，支持会话中途 /model 切换

---

## 2026-04-09 (10:00)

**操作**: 执行Wiki知识库工作流 - 豆包AI购物闭环分析
**来源**: https://mp.weixin.qq.com/s/m2ZUoOA2A9sHEFr6t8TRMw (虎嗅·黄青春)
**处理人**: Tars

### 创建文件
1. `原文资料/2026-04-09-豆包AI购物闭环-source.md` - 完整原文存档
2. `Entities/豆包.md` - 字节跳动 AI 产品
3. `Entities/抖音电商.md` - 电商平台实体
4. `Entities/梁汝波.md` - 字节跳动 CEO
5. `Concepts/AI购物.md` - AI 购物商业模式
6. `index.md` - 更新索引

### 核心信息

**豆包数据**: 2.26 亿 MAU（AI 应用第一），春晚 DAU 1.45 亿
**抖音电商 GMV**: 3.43 万亿（+35%，增速显著放缓）

**电商入口三次跃迁**:
1. PC 搜索框（淘宝/百度，人找货）
2. 移动直播间（抖音/快手，货找人）
3. AI 对话框（豆包/通义千问，AI 代办）

**竞品进度**:
- 通义千问: 春节 6 天 1.2 亿笔 AI 下单，接入全生态
- 京东 AI 购: 言犀大模型
- 美团小美: 即时零售
- ChatGPT: Instant Checkout

**五大挑战**: 信任缺失、AI 幻觉、封闭生态、履约短板、商家生态冲击

**关键判断**: AI 购物是军备竞赛，当前各厂都是封闭闭环，真正的"一站式全网购物"不存在

---

## 2026-04-09 (09:55)

**操作**: 执行Wiki知识库工作流 - Hermes Agent vs OpenClaw 对比分析
**来源**: https://mp.weixin.qq.com/s/8rB9Sf08Of89tCeljtjOXg (AI范儿)
**处理人**: Tars

### 创建文件
1. `原文资料/2026-04-09-Hermes-Agent-vs-OpenClaw-source.md` - 完整原文存档
2. `Entities/Nous Research.md` - 出品方实体
3. `Entities/Hermes Agent.md` - 竞品实体，与 OpenClaw 对比
4. `Concepts/程序性记忆.md` - AI 自动学习 Skill 概念
5. `Concepts/框架级安全.md` - 框架级 vs 模型级安全
6. `Concepts/OpenClaw.md` - 更新，增加与 Hermes Agent 对比
7. `index.md` - 更新索引

### 核心信息

**Hermes Agent**:
- Nous Research 出品，融资 6500 万美元，MIT 开源
- GitHub 两个月从零到 3 万+ 星
- 原生支持 Anthropic Provider，可直接用 Claude Code 凭证

**四大差异**:
1. Skills: 人写 5700+ vs AI 自动提炼（程序性记忆）
2. 记忆: 纯 Markdown vs 三层结构 + SQLite 全文检索
3. 安全: 模型级 vs 框架级（命令审批、Skill 扫描、容器隔离）
4. 生态: 34.5 万星+中文丰富 vs 3 万星+中文几乎为零

**关键判断**: 两只虾不冲突，设计哲学不同（指挥 vs 放手），建议两个都装

---

## 2026-04-08 (07:28)

**操作**: 执行Wiki知识库工作流 - 新增DeepSeek产品分层分析
**来源**: https://mp.weixin.qq.com/s/1GbOEIXLysmuzs_2B8IRLg
**处理人**: Tars

### 创建文件
1. `原文资料/2026-04-08-DeepSeek-快速模式-专家模式-source.md` - 完整原文存档
2. `Entities/DeepSeek.md` - AI公司实体
3. `Concepts/AI产品分层.md` - 商业模式概念
4. `index.md` - 更新索引

### 核心信息

**DeepSeek 网页端更新**:
- **快速模式**: V4 Lite，适合日常对话，即时响应，支持多模态
- **专家模式**: V4 正式版，擅长复杂问题，推理能力更强
- **Vision模式**: 即将上线，多模态视觉理解

**战略意义**:
- 从「全免费无分层」转向产品分层
- 算力调度：深度推理走专家模式，日常对话走快速模式
- 商业化铺垫：架构搭好后，付费体系技术上可行

**实测差异**:
- 物理仿真：专家模式更符合物理直觉
- 数学推理：专家模式逐步拆解，推导清晰
- 创意写作：差距不明显

---

## 2026-04-07 (21:42)

**操作**: 执行Wiki知识库工作流 - 新增Claude Code橙皮书
**来源**: https://my.feishu.cn/wiki/JK1WwrRgJiYfRok7YxxceS5qn1J
**处理人**: Tars

### 创建文件
1. `原文资料/2026-04-07-Claude-Code-橙皮书-source.md` - 完整原文存档
2. `Entities/花叔.md` - AI工具创作者实体
3. `Concepts/Claude Code.md` - AI编程工具概念
4. `Concepts/OpenClaw.md` - AI编程辅助平台概念
5. `index.md` - 更新索引

### 核心信息

**花叔作品**:
- 《Claude Code从入门到精通》橙皮书 v2.0.0
- 《OpenClaw橙皮书：从入门到精通》
- 均已上架微信读书

**学习资源**:
- B站视频: BV11zXCBFEMo
- 飞书Wiki文档
- PDF附件: Claude Code从入门到精通-v2.0.0.pdf

**关联知识**:
- [[Claude Code]] - Anthropic AI编程助手
- [[OpenClaw]] - AI编程辅助平台
- [[微信读书]] - 电子书发布平台

---

## 2026-04-07 (20:47)

**操作**: 执行Wiki知识库工作流 - 新增Citrini独立研究机构研究
**来源**: https://mp.weixin.qq.com/s/ag5KKu3jirLOgUFWuDrKuQ
**处理人**: Tars

### 创建文件
1. `原文资料/2026-04-07-去了霍尔木兹海峡的Citrini是谁-source.md` - 完整原文存档
2. `Entities/Citrini.md` - 独立AI研究机构实体
3. `Entities/James Citrini.md` - Citrini创始人实体
4. `Entities/SemiAnalysis.md` - 半导体研究机构实体（79人，年花500万美元买Claude）
5. `Entities/Substack.md` - 知识订阅平台实体
6. `Concepts/独立研究机构.md` - 新型研究机构范式
7. `Concepts/马赛克理论.md` - "魔鬼藏在细节"的信息获取方法论
8. `Concepts/Ghost GDP.md` - AI导致的虚幻GDP现象
9. `Concepts/Scared Trade.md` - AI引发的市场恐慌交易
10. `index.md` - 更新索引

### 核心洞察

**Citrini研究机构**:
- 总部曼哈顿，仅10人，创始人James Citrini（前Citadel对冲基金）
- 信奉"马赛克理论"：财富藏在细节碎片中
- 爆款报告《AI2028》预言Ghost GDP和Scared Trade

**AI驱动的研究"极客化"**:
- SemiAnalysis年花500万美元买Claude服务
- 79人团队，人均AI支出超6万美元
- 建立RAG系统追踪半导体供应链
- 买方机构已将AI使用设为KPI，卖方投行几乎不用AI工具

**平台经济改变商业模式**:
- Substack提供支付闭环、邮件直达、私域流量所有权
- Citrini年费数千美金，直接筛选高净值客户
- 绕过传统券商繁琐合规审查，表达更自由尖锐

**灰色监管与马赛克理论**:
- 一线实地调研（如霍尔木兹海峡数油轮）获取非公开信息
- 法律上解释为"拼凑碎片+逻辑推断"，非内幕信息
- 类似机构：Doomberg（能源）、SemiAnalysis（芯片）、MacroCompass（流动性）、Hindenberg（做空）

### 趋势判断
> "有理由相信，AI会在不久的将来，深刻影响，甚至颠覆，我所熟悉的卖方研究。" —— 陈李（东吴证券研究所）

---

## 2026-04-07 (18:15)

**操作**: 新增华为2025年年报完整版(147页)
**来源**: https://www-file.huawei.com/admin/asset/v1/pro/view/3022d6c92652427fa0d7f72dcc72daa2.pdf
**处理人**: Tars

### 创建文件
1. `原文资料/2026-04-07-华为2025年年报-完整版-source.md` - 完整年报原文(147页)
2. `Concepts/华为2025年年报深度解读.md` - 深度Wiki分析条目
3. `index.md` - 更新索引

### 核心财务数据

**整体业绩**:
- 销售收入：8,809亿元（+2.2%）
- 净利润：680亿元（+8.7%）
- 经营现金流：1,274亿元（+44.1%）
- 研发投入：~1,762亿元（20%+收入占比）

**分业务收入**:
| 业务 | 收入(亿) | 增速 |
|-----|---------|------|
| ICT基础设施 | 3,750 | +2.6% |
| 终端业务 | 3,445 | +1.6% |
| 数字能源 | 773 | +12.7% |
| 智能汽车 | 450 | +72.1% |
| 云计算 | 322 | -3.5% |

### 战略要点

**孟晚舟致辞核心**:
> "人工智能可能是人类历史上最后一场技术变革"

**五大生态进展(2025年底)**:
- 鸿蒙：开发者1,000万+，设备3,600万+
- 鲲鹏：合作伙伴6,800+，开发者380万
- 昇腾：合作伙伴3,000+，开发者400万
- 华为云：合作伙伴59,000+，开发者1,000万+
- 欧拉/openGauss：装机1,600万套

**关键突破**:
- 昇腾384超节点规模商用
- 5G-A用户突破6,000万
- 智能汽车累计辅助驾驶里程70亿公里
- 全球千兆用户突破4.5亿

### 深度洞察

1. **从"产品竞争"到"生态竞争"**: 华为正在完成从产品公司向生态平台公司的转型
2. **智能汽车爆发**: 72%增速，正在复制手机成功路径，年发货量3,800万件
3. **计算产业崛起**: 昇腾+鲲鹏生态形成与NVIDIA竞争的新选择
4. **质量文化**: "以质取胜"端到端贯彻，追求"有利润的收入、有现金流的利润"

---

## 2026-04-07 (17:52)

**操作**: 新增华为2025财报与业务结构分析
**来源**: https://mp.weixin.qq.com/s/bMqSw-ehLS68CHA_Svswhw
**处理人**: Tars

### 创建文件
1. `原文资料/2026-04-07-华为2025财报ICT最赚钱-source.md` - 完整原文
2. `Concepts/华为2025财报与业务结构分析.md` - 中文Wiki条目
3. `index.md` - 更新索引（更新华为实体信息）

### 关键洞察

**营收结构**:
- 总营收8809亿元（$1260亿），同比增长2.2%
- ICT基础设施：3750亿（42%）——真正的现金牛
- 终端业务：3444亿（39%）——增速仅1.6%
- 智能汽车：450亿（5%）——增速72.1%，未来引擎

**核心发现**:
- 最赚钱的不是手机、汽车，而是B2B的ICT基础设施
- 研发强度21.8%，10年投入13820亿，16.5万件专利
- 国内依赖度过高（69.3%），地缘政治风险敞口大
- 智能汽车正在复制手机成功路径

**投资启示**:
- 华为模式：研发驱动型增长，技术护城河深厚
- 风险点：地域集中、终端疲软、汽车赛道拥挤
- 关注点：智能汽车能否持续72%增速，海外拓展进展

---

## 2026-04-06

**操作**: 新增平头哥半导体专题研究  
**来源**: 雷峰网7篇报道整理  
**处理人**: Tars

### 创建文件
1. `项目笔记/平头哥半导体研究/2026-04-06-平头哥半导体深度分析报告.md` - 完整研究报告
2. `Entities/平头哥半导体有限公司.md` - 新实体
3. `Concepts/平头哥半导体.md` - 新概念
4. `index.md` - 更新索引

### 关键洞察
- 平头哥形成"真武PPU+镇岳510+玄铁RISC-V"三大产品线
- "通云哥"黄金三角：阿里是全球唯二具备"大模型+云+芯片"全栈的公司
- 真武芯片已商用：47万片交付，百亿收入，涨价34%，供不应求
- **新增**: 慧哥提供PPU内部结构（1.0/1.1/1.5版本拆解）
- **新增**: 微信文章披露研发时间线（2020年启动，2022年底完成）
- **新增**: 重点拓展车企、金融行业（广西某银行中标）
- **重要区分**: 真武PPU（AI芯片，47万片）vs 镇岳510（存储主控，50万+片）
- 风险：副总裁孟建熠离职，RISC-V业务前景待观察

---

## 2026-04-07 (16:35)

**操作**: 新增福邦投顾PCB载板产业研究报告
**来源**: 慧哥发送PDF文件
**处理人**: Tars

### 创建文件
1. `原文资料/2026-04-07-PCB载板产业缺料加剧-source.md` - 原文存档
2. `Concepts/PCB载板产业供需分析.md` - 中文Wiki条目
3. `index.md` - 更新索引

### 关键洞察

**四大紧缺材料**:
- **石英布**: LPX Rack驱动，2027年缺口60%+
- **玻布**: LowDK 2代和T-Glass为主要缺货来源
- **HVLP4铜箔**: 月需求2500-3000吨，2026H2-2027明确吃紧
- **高阶钻针**: 报价翻升，毛利率提升

**IC载板产能缺口**:
- 2027年: 缺口26%
- 2028年: 缺口扩大至46%
- 欧美大客户抢占ABF产能，ASIC体系面临抢料+抢产能

**海外产能布局**:
- 定颖、金像电准备速度优于同业
- 获得ASIC/GPU大单
- 高阶产能2026-2027年持续吃紧

**美国政策催化**:
- OBBBA法案: 企业所得税35%→21%，资本支出全额抵减
- AAAP计划: 加速AI基础设施建设，输出AI技术给盟友
- 主权AI(Sovereign AI)概念兴起

### 建议关注标的
- 载板: 南电(8046)、欣兴(3037)
- PCB: 臻鼎(4958)、定颖(3715)、金像电(2368)
- 上游: 台光电(2383)、尖点(8021)、富乔(1815)

---

## 2026-04-07 (16:30)

**操作**: 新增 SemiAnalysis 两篇英文文章中文Wiki化
**来源**: Obsidian/Clippings 重复文章处理
**处理人**: Tars

### 创建文件
1. `原文资料/2026-04-07-blackwell-tensor-cores-microbenchmark-source.md` - Blackwell微架构原文存档
2. `原文资料/2026-04-07-gpu-shortage-rental-price-index-source.md` - GPU租赁市场原文存档
3. `Concepts/Blackwell微架构深度解析.md` - 中文Wiki条目（技术深度）
4. `Concepts/GPU租赁市场与算力短缺.md` - 中文Wiki条目（市场分析）
5. `index.md` - 更新索引

### 关键洞察

**Blackwell微架构**:
- TMEM显式管理取代隐式寄存器存储
- tcgen05指令单线程CTA级发出（vs Hopper warp级）
- 2SM MMA实现完美弱扩展性（2x资源=2x性能）
- LDGSTS吞吐6.6TB/s，TMA适合大负载规则访问
- Die-to-die延迟300 cycles（B200双芯片封装）
- SemiAnalysis开源microbench-blackwell基准测试

**GPU租赁市场**:
- H100租赁价格半年涨40%（$1.70→$2.35/hr/GPU）
- Anthropic ARR单季度3倍增长（$90亿→$300亿+）
- 所有按需容量售罄，合同续约至2028年
- Agent AI需求爆发（Claude Code占2026年底20%+代码提交）
- Neocloud策略180度转变：从竞争定价到挑选客户
- 三个监测节点：GB300铺开、硅片短缺、ARR增长

### 重复处理
- 删除Clippings目录中重复的两篇英文原文
- 保留中文Wiki条目作为知识库核心资产

---

## 2026-04-07 (14:32)

**操作**: 新增 NVIDIA B200 成本拆解  
**来源**: https://mp.weixin.qq.com/s/WRmaZQzao92c2XWTYkSf4Q  
**处理人**: Tars

### 创建文件
1. `原文资料/2026-04-07-NVIDIA-B200-成本拆解-source.md` - 完整原文
2. `Entities/NVIDIA.md` - 新实体
3. `Concepts/AI芯片经济学.md` - 新概念
4. `index.md` - 更新索引

### 关键洞察
- **结构性转变**: HBM内存占B200 COGS的45%（$2,900），超越逻辑芯片成为最大成本驱动因素
- **成本翻倍**: B200 COGS约$6,400，几乎是H100（$3,320）的两倍
- **定价权**: 尽管COGS上涨93%，NVIDIA仍维持84%毛利率（ASP $40,000）
- **双芯片设计**: 两颗800mm²芯片以封装复杂度换取硅片良率优化
- **HBM依赖**: 8堆栈HBM3e，供应商寡头（SK Hynix 50%、三星30%、美光20%）掌握定价权
- **云服务商压力**: B200训练70B模型成本$120-150万，云GPU定价$4-5/小时

### B200 vs H100 成本对比
| 成本项 | B200 | H100 | 变化 |
|--------|------|------|------|
| HBM | $2,900 (45%) | $1,350 (41%) | +115% |
| 封装 | $1,100 (17%) | $750 (23%) | +47% |
| 逻辑芯片 | $850 (13%) | $300 (9%) | +183% |
| 测试组装 | $1,550 (24%) | $920 (27%) | +68% |
| **总COGS** | **$6,400** | **$3,320** | **+93%** |
| **毛利率** | **84%** | **88%** | **-4%** |

### 战略意义
- AI芯片经济学从"算力主导"转向"内存主导"
- NVIDIA利润率对HBM市场动态高度敏感
- 训练成本门槛提升，加速AI算力集中化趋势

---

## 2026-04-07 (13:37)

**操作**: 新增 华为超节点384 vs NVL72 网络拓扑对比  
**来源**: https://mp.weixin.qq.com/s/NmmV1NjXdVLA5BMnxS1-Uw  
**处理人**: Tars

### 创建文件
1. `原文资料/2026-04-07-华为超节点384-vs-NVL72-网络拓扑对比-source.md` - 完整原文
2. `Entities/华为.md` - 新实体
3. `Concepts/超节点架构.md` - 新概念
4. `index.md` - 更新索引

### 关键洞察
- **拓扑同构**: 华为384与NVIDIA NVL72网络拓扑类型几乎相同——无中心、全对等
- **规模差异**: 华为384卡 vs NVIDIA 72卡，华为单节点规模领先5.3倍
- **5184之谜**: NVL72的5184根铜缆 = 72×18×2×2（GPU×Switch×差分对×双工），非简单72²
- **分层设计**: 华为两层Switch(Layer1/2)，NVIDIA单层18个NVSwitch
- **未来竞赛**: 华为8192卡SuperPoD下半年交付 vs NVIDIA NVL144/288/576系列

### 规模对比
| 厂商 | 当前 | 规划中 |
|------|------|--------|
| 华为 | 384卡 | **8192卡** (2026H2) |
| NVIDIA | 72卡 | 576卡 |

### 技术哲学
> "同一层中'平等'的Switch数量越多，就意味着相互独立的、可供选择的通道也就越多，就越不容易发生堵塞，就越接近事实上的'全连接'。"

---

## 2026-04-07 (13:35)

**操作**: 新增 YASA 蚂蚁多语言静态分析框架  
**来源**: https://mp.weixin.qq.com/s/ERJIiKfwHZ6ViNx0ILRjfw  
**处理人**: Tars

### 创建文件
1. `原文资料/2026-04-07-YASA-蚂蚁多语言静态分析框架-source.md` - 完整原文
2. `Entities/蚂蚁集团.md` - 新实体
3. `Concepts/静态程序分析.md` - 新概念
4. `index.md` - 更新索引

### 关键洞察
- **学术认可**: FSE 2026 Industry Track（CCF A类会议）录用，工业级验证获国际认可
- **技术突破**: UAST统一抽象语法树，77.3%规则跨语言复用，新增语言成本仅16-27%
- **性能领先**: 31.8 KLOC/min，是CodeQL的3.4倍、Joern的1.9倍
- **实际战果**: 扫描2万+应用，发现300+漏洞路径（含0-day）
- **全面开源**: YASA-UAST + YASA-Engine 双仓库开源
- **支持语言**: Java、JavaScript、Python、Go，覆盖11个主流框架

### 技术对比（vs CodeQL/Joern）
| 维度 | YASA | CodeQL | Joern |
|------|------|--------|-------|
| 规则复用率 | 77.3% | 4.5% | 低 |
| 扫描性能 | 31.8 KLOC/min | 9.4 | 16.7 |
| 污点灵敏度提升 | +14-26% | 基准 | 基准 |

---

## 2026-04-07 (13:05)

**操作**: 新增 Google TPU Ironwood 架构解析  
**来源**: https://mp.weixin.qq.com/s/yBH6_7BBEWJ7X6C59Qe8Ig  
**处理人**: Tars

### 创建文件
1. `原文资料/2026-04-07-Google-TPU-Ironwood-架构全解析-source.md` - 完整原文
2. `Entities/Google.md` - 新实体
3. `Concepts/AI芯片架构.md` - 新概念
4. `index.md` - 更新索引

### 关键洞察
- **算力跃升**: Ironwood单芯片4614 TFLOPS，比TPU v5p高10倍+
- **架构创新**: 第四代SparseCore专门解决Embedding和通信瓶颈
- **内存革命**: 1.77PB全局共享内存，打破分布式训练通信墙（世界纪录）
- **能效领先**: 29.3 TFLOPS/W，比上一代翻倍，数据中心电力成本优势显著
- **全栈整合**: 谷歌展示垂直整合终极形态，从芯片到数据中心全链路优化
- **战略意义**: 不是堆参数，而是掐死大模型算力痛点，这才是真正的AI护城河

### 与NVIDIA对比
| 维度 | Google TPU Ironwood | NVIDIA GPU |
|------|---------------------|------------|
| 设计理念 | 专用AI芯片 | 通用计算 |
| 集群扩展 | OCS光互联+共享内存 | NVLink+传统分布式 |
| 能效比 | 29.3 TFLOPS/W | ~15-20 TFLOPS/W |
| 软件生态 | JAX/TensorFlow | CUDA生态 |

---

## 2026-04-06

**操作**: 新增 Gemma 4 文章归档  
**来源**: https://mp.weixin.qq.com/s/HpOnuJrHwS-zjyLur7Mi5w  
**处理人**: Tars

### 创建文件
1. `原文资料/2026-04-06-Gemma-4-全面解读-source.md` - 完整原文
2. `Entities/Google DeepMind.md` - 新实体
3. `Entities/Jeff Dean.md` - 新实体
4. `Entities/DataLearnerAI.md` - 新实体
5. `Entities/Hugging Face.md` - 新实体
6. `Concepts/Gemma.md` - 新概念
7. `Concepts/Apache 2.0.md` - 新概念
8. `Concepts/MoE.md` - 新概念
9. `Concepts/Arena AI.md` - 新概念
10. `index.md` - 新建索引

### 关键洞察
- Gemma 4 首次采用 Apache 2.0，许可证变化比性能更重要
- 31B Dense Arena 排名第3，但推理速度被吐槽（11 vs 60 tokens/s）
- 124B 模型传闻被雪藏，可能超越 Gemini 3 Flash-Lite

---

## 2026-04-09 (补充处理)

**操作**: 执行 Wiki 知识库工作流 - iPhone本地跑Gemma 4火了，0 token时代还有多远？
**来源**: https://mp.weixin.qq.com/s/UJSwqTh3Lf1smlnx_dELdA (机器之心)
**处理人**: Tars

### 创建/更新文件
1. `原文资料/2026-04-06-iphone-gemma4-local-llm-source.md` - 补全 YAML frontmatter + 完整原文
2. `Entities/MLX.md` - 新实体，Apple ML 框架
3. `Entities/Google AI Edge Gallery.md` - 新实体，Google 官方端侧模型 App
4. `Entities/Google DeepMind.md` - 更新，新增关联实体
5. `Concepts/端侧AI.md` - 新概念，端侧运行大模型
6. `Concepts/0 Token时代.md` - 新概念，端侧替代云端 Token 的范式转移
7. `Concepts/Token经济.md` - 更新，新增端侧 AI 对 Token 商业模式的威胁分析
8. `index.md` - 更新索引

### 核心信息

**端侧性能突破**:
- Gemma 4 E2B(2.3B)/E4B(4.5B) 可在 iPhone 上本地运行
- MLX 优化后 >40 token/秒
- 128K 上下文窗口，三星 Galaxy 思考模式下类似速度
- Google AI Edge Gallery 官方 App，非极客也能用

**局限性**:
- Agent 场景扛不住（工具调用、结构化输出、长上下文稳定性）
- 换成 qwen3-coder 后同样环境正常跑
- 智力水平仍有差距，开源小模型 vs 闭源旗舰还有距离

**趋势判断**:
- 短期：云端闭源模型在复杂推理和大规模多代理协作领先
- 长期：端侧蚕食云端高频简单任务（查询、聊天、简单推理、图像理解）
- Token 商业模式面临洗牌，厂商必须卷"真正难啃"的部分

---

## 2026-04-09 (补充处理)

**操作**: 执行 Wiki 知识库工作流 - 你的下一只龙虾何必是龙虾（OpenClaw）？
**来源**: https://mp.weixin.qq.com/s/25Rmx51xQoqP4_EvgCEL7Q (DracoVibeCoding)
**处理人**: Tars

### 创建/更新文件
1. `原文资料/2026-04-06-你的下一只龙虾何必是龙虾-source.md` - 完整原文存档（安装指南+学习路径+快速参考）
2. `Entities/DracoVibeCoding.md` - 新实体，Hermes 中文文档站创建者
3. `Entities/Nous Research.md` - 更新，新增产品矩阵（Hermes-4 405B/Psyche/API Portal）
4. `Entities/Hermes Agent.md` - 更新，新增 Gateway/语音/RL/ACP/MCP 等详细特性列表
5. `index.md` - 更新索引

### 核心信息

**用户体验**:
- 将一半"养虾"时间转向 Hermes Agent，内禀 skills 自我强化养成效率远超 OpenClaw
- 透明的工具调用链，飞书/钉钉/企微等 channel 能力齐备
- CLI 能力齐全（飞书CLI/企微CLI/Obsidian CLI/Google CLI）

**Nous Research 产品矩阵**:
- HERMES 系列大模型（HERMES-4 达 405B）
- Psyche 分布式训练基建
- Hermes AGENT 开源 Agent Runtime
- API Portal 基于订阅的 LLM 服务
- 定位："小众版 DeepSeek"

**Hermes 详细能力（新补充）**:
- 15+ LLM 供应商支持（Nous Portal/Anthropic/智谱/Kimi/MiniMax/通义千问/HuggingFace 等）
- Gateway 支持 7 种消息平台（Telegram/Discord/Slack/WhatsApp/Signal/Email/Home Assistant）
- 语音模式：CLI 麦克风输入 + TTS（faster-whisper / ElevenLabs）
- RL 训练：内置强化学习微调（Tinker/Atropos 后端）
- ACP 编辑器集成：VS Code/Zed/JetBrains
- 定时任务：cron 自动运行
- MCP 服务器支持

**中文贡献**:
- DracoVibeCoding 创建 Hermes Agent 中文文档站（hermes-doc.aigc.green，Vercel 托管）
- 翻译复刻了全部官方文档

---

## 2026-04-09 (补充处理)

**操作**: 执行 Wiki 知识库工作流 - 万字解读Agentic Harness | 茶思周一见
**来源**: https://mp.weixin.qq.com/s/lrmTrTTrzOugm0riCBKJPA (华为茶思屋)
**处理人**: Tars

### 创建/更新文件
1. `原文资料/2026-04-06-huawei-chasiwu-ai-weekly-agent-harness-2nm-chip-source.md` - 补全 YAML frontmatter
2. `Entities/茶思屋.md` - 新实体，华为旗下科技媒体
3. `Concepts/Harness.md` - 更新，新增 Agentic Harness 定义、核心悖论、保质期结构
4. `index.md` - 更新索引

### 核心信息

**Agentic Harness 核心悖论**:
- Agent 没有护城河（独立产品无持久壁垒），但 Harness 是效果决定性变量
- Harness 优势有保质期：部分随下一代模型归零，部分随模型进步增值
- 类比：Model=CPU, Context Window=RAM, Agent Harness=OS, Agent=Application

**本期其他话题**:
- 万卡集群动力学稳定性（电磁-热-通信耦合是核心挑战）
- 2nm芯片缩放挑战（GAA/High-NA EUV/背面供电/3D异构集成）
- Embedding 模型选型（Gemini Embedding 2 综合实力最强）
- AI+HW 2035：27家机构定义 Scaling Efficiency（1000倍效能提升目标）
- CPO 共封装光学（Corning 玻璃基板方案 2dB 耦合损耗）

## 2026-04-09 (14:56)

**操作**: 处理微信文章 - 豆包接入抖音电商：AI购物是下一代消费入口？
**来源**: https://mp.weixin.qq.com/s/m2ZUoOA2A9sHEFr6t8TRMw
**来源**: 虎嗅黄青春频道
**存档**: [[2026-04-09-豆包AI购物闭环-source|原文存档]]
**新建实体**: [[通义千问]]、[[京东AI购]]、[[小美]]、[[字节跳动]]（更新：[[豆包]]）
**新建概念**: [[AI代办]]、[[意图竞价广告]]（更新：[[AI购物]]）
**索引**: 已更新（2026-04-09 条目）
**处理器**: Tars

## 2026-04-09 (22:50)

**操作**: 执行 Wiki 知识库工作流 - CXL 深度解读全解析
**来源**: 慧哥提供（会议/文章整理）
**存档**: [[2026-04-09-CXL深度解读全解析-source|原文存档]]
**新建实体**: [[澜起科技]]、[[Astera Labs]]、[[Synopsys]]、[[Cadence]]
**新建概念**: [[CXL]]、[[内存池化]]、[[内存即服务MaaS]]、[[KVCache管理]]、[[NVLink]]、[[CMX]]
**索引**: 已更新（2026-04-09 条目）
**处理器**: Tars

### 核心信息

**CXL 技术演进**:
- CXL 1.0/1.1 (2019-2020): 三大子协议，基础内存扩展
- CXL 2.0 (2020): **关键转折点**，新增 Switch 交换，多主机共享内存池
- CXL 3.0 (2022): 带宽 64 GT/s，Fabric 组网，跨机架共享
- CXL 4.0 (2025): 带宽 128 GT/s，超大规模 AI 集群优化

**巨头战略分化**:
- Intel/AMD: 开放标准推动者，但商用化滞后 2-3 年
- Nvidia: 坚守 NVLink (7200GB/s) + CMX (闪存 KV Cache 方案)，CXL 仅备选
- 谷歌: TPU v8 激进方案，CXL 替代 HBM，三层解耦架构，单 TPU 内存×4

**中国实践**:
- 阿里云: PolarDB CXL 服务器（扩展性×16），AI 推理 TTFT 降 82.7%，Engram 内存池化
- 华为: UB 协议自主路线，UB 2.0 规划 8192 颗 NPU，跨机架 200 米光纤

**行业争议**:
- SemiAnalysis "CXL 已死" 部分正确：不适合 AI 训练（需<50ns），但推理/数据库/池化不可替代
- 三大挑战：百纳秒延迟控制、2027 年才大规模起量、生态深度适配不足

**产业链**:
- 协议层：CXL 联盟（250+ 成员），JEDEC
- 芯片层：澜起科技（MXC 龙头）、Astera Labs（Retimer 市占第一）
- IP 层：Synopsys（首款 CXL IP）、Cadence（CXL 3.0 验证 IP）、Arteris IP（NoC 龙头 31.3%）

---

## 2026-04-09 (22:43)

**操作**: 手机截图解读 - 存储芯片价格暴涨走势
**来源**: 东北证券研究所研报截图
**存档**: [[2026-04-09-存储芯片价格暴涨走势-source|原文存档]]
**关联概念**: [[存储芯片]]、[[DRAM]]、[[SSD]]、[[NAND]]、[[TurboQuant]]、[[CXL]]、[[华为灵衢UB]]
**索引**: 已更新（2026-04-09 条目）
**处理器**: Tars

### 核心信息

**全线暴涨**:
- DDR5 16GB: 从 ~$0 涨至 ~$70+，从零起步涨幅巨大
- DDR4 8GB: 从 ~$10 涨至 ~$40+，约 4 倍
- 2TB PCIe 4.0 SSD: 从 ~$100 涨至 ~$300+，约 3 倍
- 1TB PCIe 4.0 SSD: 从 ~$60 涨至 ~$180+，约 3 倍
- 1TB QLC Wafer: 从 ~$4 涨至 ~$34，约 8.5 倍
- 1TB TLC Wafer: 从 ~$5 涨至 ~$35+，约 7 倍

**关键判断**:
- 2025年底开始加速上涨，2026年4月仍在上升通道，无见顶迹象
- 驱动因素：AI训练集群扩容、数据中心需求、终端设备容量升级
- 与之前 UBS SK海力士研报（30年一遇存储周期）相互印证

**产业影响**:
- 受益方：三星、SK海力士、美光、澜起科技
- 受损方：终端厂商、数据中心运营商、消费者（设备涨价）

## 2026-04-09 (15:03)

**操作**: 处理微信文章 - 阿里云百炼记忆库上线
**来源**: https://mp.weixin.qq.com/s/SymdhOpGzk4TqNN31VOM6g
**来源**: 阿里云官方公众号
**存档**: [[2026-04-09-阿里云百炼记忆库-source|原文存档]]
**新建实体**: [[阿里云百炼]]
**新建概念**: [[长期记忆系统]]
**索引**: 已更新（2026-04-09 条目）
**处理器**: Tars
## 2026-04-09 (23:29)
**操作**: 处理微信文章 - Claude Code 长任务 Runtime 深度解读
**来源**: https://mp.weixin.qq.com/s/L0fGwMIh4HOXrg-Xi_BcWA
**来源**: 架构师（若飞）
**存档**: [[2026-04-09-Claude-Code-长任务-Runtime-source|原文存档]]
**新建概念**: [[上下文治理]]、[[SessionMemory]]
**关联**: [[Claude Code]]、[[长期记忆系统]]
**索引**: 已更新（2026-04-09 23:29 条目）
**处理器**: Tars

## 2026-04-09 (23:29)
**操作**: 处理微信文章 - Claude Managed Agents 深度解读
**来源**: https://mp.weixin.qq.com/s/WsNQWXz1_kAQtHRvBtC11Q
**来源**: 架构师（若飞）
**存档**: [[2026-04-09-Claude-Managed-Agents-source|原文存档]]
**新建实体**: [[Claude Managed Agents]]
**新建概念**: [[Agent运行底座]]、[[AI工程化]]
**索引**: 已更新（2026-04-09 23:29 条目）
**处理器**: Tars

## 2026-04-09
- 存档：[[互联网行业的两台利润粉碎机]]（晚点LatePost，截图OCR）
- 📝 博客发布：[[2025年互联网行业利润格局]](https://dahuir81.github.io/posts/2026-04-09-internet-profit-crushers-analysis/) - 基于晚点LatePost数据可视化文章整理分析
