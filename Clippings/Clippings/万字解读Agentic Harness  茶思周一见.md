---
title: "万字解读Agentic Harness | 茶思周一见"
source: "https://mp.weixin.qq.com/s/lrmTrTTrzOugm0riCBKJPA?poc_token=HLN702mj76Hx02Ldjfw5jciJHteq5rmKHSLw6-cv"
author:
  - "[[茶思编辑部]]"
published:
created: 2026-04-06
description: "为什么说Agent没有护城河，但Harness又如此重要？2nm 及以下芯片缩放挑战解读；英伟达、谷歌等27家机构定义未来十年AI芯片新范式。"
tags:
  - "clippings"
---
原创 茶思编辑部 *2026年4月6日 08:35*

![图片](https://mmbiz.qpic.cn/sz_mmbiz_png/egQttj1YXY868xg9sMI27OmMJrTBcLCF1953JN245RGkMmY2Ebx9z830sVdIYsVpVUt5ygTN8FhcoMewaWVCicIzw6ZjYicCl8TrKj4Hhkq9g/640?wx_fmt=png&from=appmsg&tp=webp&wxfrom=5&wx_lazy=1#imgIndex=0) ![图片](https://mmbiz.qpic.cn/mmbiz_jpg/egQttj1YXYibLJdbthJwgN94AXXribM4GQUmGn6EWCdEgsiakHQTiajf4n39NJZOLAuWlNo2npBiblicTXRxKwEFIHZFb7y2OQXLHKyvUCy8uIoQY/640?wx_fmt=jpeg&from=appmsg&tp=webp&wxfrom=5&wx_lazy=1#imgIndex=1)

*【编者按】为什么说Agent没有护城河，但Harness又如此重要？2nm 及以下芯片缩放挑战解读；英伟达、谷歌等27家机构定义未来十年AI芯片新范式。更多精彩洞察，且看本期周一见——*

***茶思屋特别推荐***

**[Agentic Harness：释放模型能力的关键变量，与一场没有护城河的战争](https://mp.weixin.qq.com/s?__biz=Mzg2MzgwNzE4Mw==&mid=2247523828&idx=1&sn=16adad7473dc22279c293c75acd58860&scene=21#wechat_redirect)**

**摘要：** Agent 赛道，此刻两个互相矛盾的观点正在同时成立。判断一：Agent 不是一个赛道。判断二：Harness 是效果的决定性变量。那问题来了：如果 Agent 没有护城河，Harness 为什么这么重要？如果 Harness 决定效果，它又为什么不能成为护城河？这两个判断其实不矛盾。但要解释清楚，需要一个比"有 / 没有护城河"更精细的框架。

其实如今各类 Agent 独立产品确实没有持久壁垒。而 Agentic Harness，也就是围绕模型搭建的约束、反馈闭环与上下文工程系统，却又的确是当下效果差异的核心变量。注意"当下"两个字。也就是说，这个优势有保质期，而且不同层面的保质期差异很大：有些会在下一代模型发布时迅速归零，有些反而会随模型进步而增值。所以本文要回答的问题是：这个保质期的结构长什么样，以及在窗口关闭之前，AI赛道的产品或技术决策者，又该押注在哪。

![图片](https://mmbiz.qpic.cn/sz_mmbiz_png/egQttj1YXY8wzHI4r9t0qS8rKV0DicF9GEV7se0ZUGy6Kp4E6ORhbpmeqV2RlcHszDASzVev3asgSbZALrtMJjZGLlVjjibbyF66ceL2D5yfk/640?wx_fmt=png&from=appmsg&tp=webp&wxfrom=5&wx_lazy=1#imgIndex=2)

*Harness 作为 AI 的“操作系统”：Model = CPU，Context Window = RAM，Agent Harness = OS，Agent = Application。图源：Philipp Schmid — The Importance of Agent Harness in 2026*

****长按下方二维码，阅读全部内容****

![图片](https://mmbiz.qpic.cn/sz_mmbiz_png/egQttj1YXY8eDtTyb7zSjyVIianFuwiaMSYcIOEgdpFpnDibp9ULeXTYn9SHRhsiaR0jlsxiaPJg8dJ5zhStPfDbRSItknRvwwUmDfIsKxvW8dJ0/640?wx_fmt=png&from=appmsg&tp=webp&wxfrom=5&wx_lazy=1#imgIndex=3)

***小编点评：*** *本文直击 Agent 赛道的核心悖论，厘清了行业长期混淆的核心概念，以时间维度拆解 Harness 的价值衰减逻辑，为行业决策者给出了极具实操性的战略判断框架。*

**大规模计算系统的几何结构 —— 万卡集群的动力学稳定性与结构重构 | 芮博数理工场【结构智能】专栏第4期**

**摘要：** 当计算系统规模从传统的数据中心扩展到“万卡级”集群时，其结构性质发生了根本变化。在中小规模集群中，系统通常可以被视为服务器节点的简单并联，通过网络协议协调任务执行。然而，当系统规模达到数万甚至更多 GPU 或加速卡时，这种简单抽象不再成立。节点之间不仅通过信息网络相互连接，还通过电力供应、热传导以及电磁耦合形成复杂的物理反馈关系。因此，万卡级计算系统更接近于一个大型物理系统，而不仅仅是软件定义的计算平台。从数学角度看，这类系统可以被理解为嵌入在高维参数流形中的非线性动力系统。本期内容将万卡集群建模为高维参数流形上的动力系统，解决由于电流、磁干扰等物理不变量带来的系统性崩溃。

****长按下方二维码，阅读全部内容****

![图片](data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg width='1px' height='1px' viewBox='0 0 1 1' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'%3E%3Ctitle%3E%3C/title%3E%3Cg stroke='none' stroke-width='1' fill='none' fill-rule='evenodd' fill-opacity='0'%3E%3Cg transform='translate(-249.000000, -126.000000)' fill='%23FFFFFF'%3E%3Crect x='249' y='126' width='1' height='1'%3E%3C/rect%3E%3C/g%3E%3C/g%3E%3C/svg%3E)

*【评论摘选】很有趣的数学建模，有个核心假设是能耗/电磁场会对通信带来影响，即离散空间与连续空间的耦合。逻辑上也有道理。我的问题是，在工程实践和生产实际场景，这种耦合因素强吗？*

*作者回复：个人浅见：在传统数据中心，这种耦合因素确实较弱，可以被视为背景噪声 。但在万卡集群这一特定物理流形上，能耗和电磁场不再是外部干扰，而是直接参与系统动力学演化的核心变量 。忽视这种耦合，稳定性就会变成一种无法严格保证的“概率事件” 。*

***一周学术热帖***

**逻辑的穹顶：AI 演进背后的认知范式与技术天花板**

**摘要：** 在信息技术日新月异的今天，我们似乎正置身于一场由新名词构成的风暴中心。面对这些令人振奋的工程奇迹，我们难免会感到目不暇接。然而，在惊叹之余，或许我们可以暂时停下脚步，去思考一个朴素的问题：在这些纷繁复杂的技术手段背后，是否隐藏着某种决定其走向的深层逻辑？

每一项伟大的技术，在给予我们无限可能的同时，也往往在无形中划定了它的边界。本文无意评价具体技术的优劣，也不打算沉溺于代码实现的细节，而是希望以一种交流探讨的姿态，陪你一起拨开术语的层层包装，去观察那些构建起现代AI大厦的“基石”。本系列文章将尝试勾勒这样一条轨迹：我们从图灵那条改变世界的纸带出发，路过乔姆斯基构建的逻辑阶梯，走进当代大语言模型那浩瀚的概率海洋，再跨越 LECUN，Hassabis以及李飞飞等众多大师 正在探索的世界本身的规律，最终回归到我们人类社会那充满约束与温情的现实空间。

****长按下方二维码，阅读全部内容****

![图片](data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg width='1px' height='1px' viewBox='0 0 1 1' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'%3E%3Ctitle%3E%3C/title%3E%3Cg stroke='none' stroke-width='1' fill='none' fill-rule='evenodd' fill-opacity='0'%3E%3Cg transform='translate(-249.000000, -126.000000)' fill='%23FFFFFF'%3E%3Crect x='249' y='126' width='1' height='1'%3E%3C/rect%3E%3C/g%3E%3C/g%3E%3C/svg%3E)

*【评论摘选】“当认知逻辑脱离人类转译”的风险，其实在alphaZero攻克围棋的时候就已经出现了，直接杀死了这个思维赛道。*

**2nm 及以下芯片缩放挑战**

**摘要：** 将芯片工艺缩减至 2nm 及更先进节点已不再是简单的物理尺寸缩小，而是一场涉及架构、材料、制造精度及经济成本的全面变革。虽然性能功耗比（PPW）的提升依然是核心驱动力，但实现这一目标的难度和成本正呈指数级增长。尽管物理极限不断逼近，但通过 GAA 架构、High-NA EUV、背面供电以及 3D 异构集成 的协同创新，半导体行业仍在延续摩尔定律的生命力。然而，这也意味着芯片设计正从单一的电气工程转变为涵盖物理、材料、热力学及经济学的综合系统工程。

****长按下方二维码，阅读全部内容****

![图片](data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg width='1px' height='1px' viewBox='0 0 1 1' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'%3E%3Ctitle%3E%3C/title%3E%3Cg stroke='none' stroke-width='1' fill='none' fill-rule='evenodd' fill-opacity='0'%3E%3Cg transform='translate(-249.000000, -126.000000)' fill='%23FFFFFF'%3E%3Crect x='249' y='126' width='1' height='1'%3E%3C/rect%3E%3C/g%3E%3C/g%3E%3C/svg%3E)

***小编点评：*** *2nm 及以下先进制程的演进，早已不是单纯的物理尺寸缩小，而是架构、材料、制造与成本的全维度变革。行业以多技术协同延续摩尔定律，推动芯片设计迈入跨学科系统工程时代。*

**2026 年，Embedding要怎么选？（实测Gemini 、jina、Qwen、BGE、OpenAI十大模型）**

**摘要：** 本文针对 RAG 开发者入门易、进阶难的嵌入模型选型痛点，指出 MTEB、MMEB 等公开基准未覆盖跨模态、跨语言、长文档、MRL 维度压缩等生产核心场景，因此选取10 个 2025-2026 年热门模型（含 API 与开源形态，搭配经典对照模型），设计了四大专项测试并给出选型建议。作者认为没有全能模型，Gemini Embedding 2综合实力最强（跨语言、长文档能力第一，支持 5 种模态），但 MRL 压缩能力弱，跨模态精度被开源模型超越。

![图片](data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg width='1px' height='1px' viewBox='0 0 1 1' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'%3E%3Ctitle%3E%3C/title%3E%3Cg stroke='none' stroke-width='1' fill='none' fill-rule='evenodd' fill-opacity='0'%3E%3Cg transform='translate(-249.000000, -126.000000)' fill='%23FFFFFF'%3E%3Crect x='249' y='126' width='1' height='1'%3E%3C/rect%3E%3C/g%3E%3C/g%3E%3C/svg%3E)

****长按下方二维码，阅读全部内容****

![图片](data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg width='1px' height='1px' viewBox='0 0 1 1' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'%3E%3Ctitle%3E%3C/title%3E%3Cg stroke='none' stroke-width='1' fill='none' fill-rule='evenodd' fill-opacity='0'%3E%3Cg transform='translate(-249.000000, -126.000000)' fill='%23FFFFFF'%3E%3Crect x='249' y='126' width='1' height='1'%3E%3C/rect%3E%3C/g%3E%3C/g%3E%3C/svg%3E)

***小编点评：*** *评测直击 RAG 生产级核心痛点，填补了 embedding 基准测试的关键场景空白，作者通过厘清通用与专精、开源与闭源模型的能力边界，为开发者选型提供了极具落地价值的参考。*

**东南大学 Nature 子刊：超构表面实现 160° 超大视场全双工高速通信**

**摘要：** 光学无线通信（OWC）凭借超大带宽、高速率、强抗电磁干扰等优势，被公认为 6G 核心关键技术。但长期以来，大角度波束偏转效率暴跌、视场受限、难以兼顾全双工与长距离传输，成为制约其走向实用的核心瓶颈。2026 年，东南大学 / 紫金山实验室团队在《Nature Communications》发表重磅成果，提出两步形状优化策略，研发出形状优化超构表面（SOM），在80° 偏转角度下实现超 80% 效率，构建出超 160° 视场的全双工光无线通信系统，完成200 米远距离传输与225 Gbps 单通道速率的高清低延时视频通话，为 6G 全场景光联提供全新技术路径。

![图片](data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg width='1px' height='1px' viewBox='0 0 1 1' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'%3E%3Ctitle%3E%3C/title%3E%3Cg stroke='none' stroke-width='1' fill='none' fill-rule='evenodd' fill-opacity='0'%3E%3Cg transform='translate(-249.000000, -126.000000)' fill='%23FFFFFF'%3E%3Crect x='249' y='126' width='1' height='1'%3E%3C/rect%3E%3C/g%3E%3C/g%3E%3C/svg%3E)

*基于超表面的 OWC 系统中的信号传输方法概述*

****长按下方二维码，阅读全部内容****

![图片](data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg width='1px' height='1px' viewBox='0 0 1 1' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'%3E%3Ctitle%3E%3C/title%3E%3Cg stroke='none' stroke-width='1' fill='none' fill-rule='evenodd' fill-opacity='0'%3E%3Cg transform='translate(-249.000000, -126.000000)' fill='%23FFFFFF'%3E%3Crect x='249' y='126' width='1' height='1'%3E%3C/rect%3E%3C/g%3E%3C/g%3E%3C/svg%3E)

***小编点评：*** *研究团队提出的原创可量产的两步形状优化超构表面，破解了光学无线通信大角度效率暴跌等核心瓶颈，实现宽视场全双工高速长距传输，算得上是光通信领域里程碑式突破。*

***精彩论文***

**[AI+HW 2035：英伟达、谷歌等27家机构定义未来十年AI芯片新范式](https://mp.weixin.qq.com/s?__biz=Mzg2MzgwNzE4Mw==&mid=2247523629&idx=1&sn=296c44f7ad328a6762c7b6c5233adfd1&scene=21#wechat_redirect)**

**摘要：** 2026年3月，由伊利诺伊大学厄巴纳-香槟分校（UIUC）、加州大学洛杉矶分校（UCLA）、斯坦福大学以及英伟达、谷歌等27家顶尖学术机构与行业巨头联合发布了《AI+HW 2035: Shaping the Next Decade》（AI +HW 2035：塑造下一个十年）一文，提出了一个跨越算法、架构、系统及可持续的十年线路图，勾勒了2035年前AI（人工智能）+HW（硬件）协同发展路线。

该文章不是简单的“硬件升级”或“算法优化”，而是彻底重构AI的计算底层逻辑——AI的未来不再仅仅取决于智能的规模化（Scaling Intelligence），更取决于效率的规模化（Scaling Efficiency），即在不增加无节制算力消耗的前提下，实现每焦耳能量所能承载智能水平的指数级飞跃，文章指出未来十年内AI训练与推理效能将实现1000倍的跨越式提升。为让大家能更好地看懂这篇文章，了解未来AI芯片发展的趋势，本文将对文章的重点进行提炼解读。

![图片](data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg width='1px' height='1px' viewBox='0 0 1 1' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'%3E%3Ctitle%3E%3C/title%3E%3Cg stroke='none' stroke-width='1' fill='none' fill-rule='evenodd' fill-opacity='0'%3E%3Cg transform='translate(-249.000000, -126.000000)' fill='%23FFFFFF'%3E%3Crect x='249' y='126' width='1' height='1'%3E%3C/rect%3E%3C/g%3E%3C/g%3E%3C/svg%3E)

****长按下方二维码，阅读全部内容****

![图片](data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg width='1px' height='1px' viewBox='0 0 1 1' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'%3E%3Ctitle%3E%3C/title%3E%3Cg stroke='none' stroke-width='1' fill='none' fill-rule='evenodd' fill-opacity='0'%3E%3Cg transform='translate(-249.000000, -126.000000)' fill='%23FFFFFF'%3E%3Crect x='249' y='126' width='1' height='1'%3E%3C/rect%3E%3C/g%3E%3C/g%3E%3C/svg%3E)

**OFC2026：CPO耦合封装**

**摘要：** 随着数字技术的加速普及，数据中心对更高带宽、更低能耗以及更多互联连接的需求变得日益迫切。为满足这些需求而出现的一种新兴解决方案是共封装光学（CPO），一种通过将光学器件置于电子封装内部来最大程度减少电气互联长度的前沿技术，用于构建下一代网络交换机和GPU。

关键的技术挑战在于单模光纤阵列与基于硅光PIC的光学互联组装技术，诸如对接耦合、渐缩波导、光栅耦合、模式扩展和辐射耦合等技术各有其独特的优点和局限性，具体取决于应用情况。

Corning的CPO 技术使用带有内置波导和电气连接线的先进玻璃基板，通过亚微米级对齐、表面波耦合和金凸点等实现可扩展的硅光组装，实现 2 dB的光纤到芯片耦合损耗。

![图片](data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg width='1px' height='1px' viewBox='0 0 1 1' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'%3E%3Ctitle%3E%3C/title%3E%3Cg stroke='none' stroke-width='1' fill='none' fill-rule='evenodd' fill-opacity='0'%3E%3Cg transform='translate(-249.000000, -126.000000)' fill='%23FFFFFF'%3E%3Crect x='249' y='126' width='1' height='1'%3E%3C/rect%3E%3C/g%3E%3C/g%3E%3C/svg%3E)

****长按下方二维码，阅读全部内容****

![图片](data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg width='1px' height='1px' viewBox='0 0 1 1' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'%3E%3Ctitle%3E%3C/title%3E%3Cg stroke='none' stroke-width='1' fill='none' fill-rule='evenodd' fill-opacity='0'%3E%3Cg transform='translate(-249.000000, -126.000000)' fill='%23FFFFFF'%3E%3Crect x='249' y='126' width='1' height='1'%3E%3C/rect%3E%3C/g%3E%3C/g%3E%3C/svg%3E)

**Synthesizing Efficient Super-Instruction Sets for Ethereum Virtual Machine**

**推荐理由：** 本文是VMIL 2024（16th ACM SIGPLAN International Workshop on Virtual Machines and Intermediate Languages）的一篇论文。本文提出一种新颖的系统，使用离线字典压缩算法（Re-Pair）与贪心启发式相结合的方法，自动选择并生成超指令（Super-Instruction），用于优化以太坊虚拟机（EVM）解释器的性能。论文主要贡献：

- 新颖的选择策略：采用Re-Pair压缩算法与定制化的贪心启发式算法，有效处理超指令之间的上下文关联和重叠问题。
- EVM元编译器：开发了一款面向 以太坊虚拟机（EVM） 的元编译器，能够生成集成了以太坊特定优化的新型解释器。
- 大规模评估：在以太坊区块链（1100万区块）上评估，实现8.45%的解释器加速。

****长按下方二维码，阅读全部内容****

![图片](data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg width='1px' height='1px' viewBox='0 0 1 1' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'%3E%3Ctitle%3E%3C/title%3E%3Cg stroke='none' stroke-width='1' fill='none' fill-rule='evenodd' fill-opacity='0'%3E%3Cg transform='translate(-249.000000, -126.000000)' fill='%23FFFFFF'%3E%3Crect x='249' y='126' width='1' height='1'%3E%3C/rect%3E%3C/g%3E%3C/g%3E%3C/svg%3E)

\* 本期所选文章已首发于黄大年茶思屋科技网站，点击“阅读原文”了解更多精彩内容。

![图片](data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg width='1px' height='1px' viewBox='0 0 1 1' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'%3E%3Ctitle%3E%3C/title%3E%3Cg stroke='none' stroke-width='1' fill='none' fill-rule='evenodd' fill-opacity='0'%3E%3Cg transform='translate(-249.000000, -126.000000)' fill='%23FFFFFF'%3E%3Crect x='249' y='126' width='1' height='1'%3E%3C/rect%3E%3C/g%3E%3C/g%3E%3C/svg%3E)

**扫码进入茶思屋科技网站**  

加入茶思屋产学研思想碰撞

转载请联系本公众号获得授权

投稿：hdncsw@huawei.com

阅读原文

继续滑动看下一个

黄大年茶思屋科技网站

向上滑动看下一个