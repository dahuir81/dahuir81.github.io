---
url: https://mp.weixin.qq.com/s/D-McErxxyBb2hQ6fSpU79Q
article_id: D-McErxxyBb2hQ6fSpU79Q
date: 2026-03-28
source: 云头条
status: archived
---

# 打崩内存股的「谷歌论文」被质疑：方法、理论、实验全被追问

**云头条**

2026年3月28日 09:22 河南

---

2026年3月27日，RaBitQ系列论文作者Cheng Long在ICLR OpenReview发布公开评论，随后Jianyang Gao也在知乎、X上发声，直指Google Research的ICLR 2026论文《TurboQuant: Online Vector Quantization with Near-optimal Distortion Rate》在描述既有工作RaBitQ时，存在方法关系交代不准确、理论比较失实、实验披露不充分等问题。

按照RaBitQ作者的说法，这些问题在TurboQuant投稿前就已通过邮件明确指出，但最终仍被保留在论文版本中，而论文又在被ICLR 2026接收后经Google官方渠道大规模传播，导致相关争议被迅速放大。

这场争议，不只是因为两篇论文都落在"高维向量量化"这一技术方向，更因为TurboQuant此前被Google作为"重新定义AI效率"的成果重点宣传。

Google在博文中将其描述为一种面向大模型KV cache压缩和向量检索的高效量化方法，称其可在不训练、不微调的情况下，将KV cache压缩到约3 bit级别，在长上下文任务中尽量维持精度，并在H100上实现attention logits计算的显著加速。论文本身也把TurboQuant定位为一种接近信息论下界、兼顾MSE与inner product distortion的在线向量量化算法。

该论文导致Micron、Western Digital、SanDisk、Seagate等多只与内存、存储相关的股票集体回落。

RaBitQ作者此次公开提出的异议，核心集中在三个层面。

## 一、方法层面的描述存在实质性不完整

TurboQuant多次将随机旋转描述为其方法的关键步骤，但在介绍RaBitQ时，主要将其归结为一种基于网格的PQ框架，却省略了Johnson-Lindenstrauss变换／随机旋转，而这恰恰是两种方法之间最重要的联系之一。更关键的是，即便两位审稿人都曾要求作者澄清并讨论Johnson-Lindenstrauss变换／随机旋转，TurboQuant的ICLR定稿版仍未补充相关讨论，反而把正文中原本对RaBitQ的描述移到了附录。

## 二、理论层面的描述也缺乏支撑

TurboQuant将RaBitQ的理论保证描述为"次优"，并将原因归结为"分析较松"，但并未给出任何解释。而用户方在2024年9月发布的论文中，已经明确声称其结果具备渐近最优性，与Alon和Klartag的最优界一致。即便这一问题在2025年5月的邮件沟通中已被明确提出并解释，作者在提交给ICLR的论文版本中，仍未系统说明TurboQuant的理论保证与RaBitQ系列工作的关系。

## 三、实验层面的对比同样缺乏充分披露

Majid在2025年1月的邮件中曾表示，他把用户方RaBitQ的C++实现翻译成了Python，并请求协助调试。到2025年5月，他又进一步承认，在论文报告的运行时间实验设置中，RaBitQ基线是在单个CPU上运行，且关闭了multiprocessing；而TurboQuant方法本身则运行在A100 GPU上。但公开论文在给出效率比较结论时，并未清楚披露这一实验设置。这个问题也曾在2025年5月的私下邮件中被明确指出。

当前的争议并不自动等同于"TurboQuant没有技术价值"，而是在于这项价值应当如何被准确表述，它与RaBitQ等先行工作的关系，应当如何被诚实摆在台面上。

---

**RaBitQ论文作者高健扬知乎全文如下**

作者：gaoj00179
链接：https://zhuanlan.zhihu.com/p/2020969476166808284
来源：知乎
著作权归作者所有。

大家好，我叫高健扬，目前在苏黎世联邦理工学院做博士后，我是RaBitQ系列工作的第一作者。

"Google Research于2026年1月被ICLR 2026会议接收的论文'TurboQuant: Online Vector Quantization with Near-optimal Distortion Rate'中，有关已有的RaBitQ向量量化算法的描述，理论结果对比，实验对比均存在严重问题（详细情况后文会展开描述）。"

这些问题在论文投稿至ICLR 2026前已被我们通过邮件明确指出，TurboQuant团队也明确表示已知情，但选择了不予修正。论文随后被ICLR 2026会议接收，然后通过Google官方渠道大规模推广，在社交媒体浏览量已达到数千万次。

我们此时公开说明，是因为错误的学术叙事一旦广泛传播，纠正的成本会越来越高。

---

## 背景：RaBitQ是什么

RaBitQ系列论文（如下所列）于2024年发表，提出了一种高维向量量化方法，并从理论上证明其达到了理论计算机顶级会议论文（Alon-Klartag, FOCS 2017）给出的渐近最优误差界。

- RaBitQ（arXiv:2405.12497，2024年5月，随后发表于顶级会议SIGMOD 2024）
- 扩展版（arXiv:2409.09913，2024年9月，随后发表于顶级会议SIGMOD 2025）

RaBitQ的核心想法之一是在量化前对输入向量施加随机旋转（random rotation / Johnson-Lindenstrauss变换），利用旋转后坐标分布的性质做向量量化，在理论上实现最优误差界。

---

## TurboQuant论文问题一：系统性地回避TurboQuant方法与已有RaBitQ方法的相似性

RaBitQ与TurboQuant在方法层面有直接的结构联系，两者都在量化前对输入向量施加随机旋转（Johnson-Lindenstrauss变换）。这是两篇论文方法设计中最核心、最接近的部分。

TurboQuant的作者在ICLR OpenReview审稿平台上对审稿人的回复中，亲自这样描述自己的方法：

> "We achieve this by first normalizing the vectors by their l2 norm and then applying a random rotation（随机旋转）to ensure the entries of the vectors will have a beta distribution post rotation."

然而在这段回复、TurboQuant论文中的方法介绍乃至整篇论文中，从未正面说明这一结构与RaBitQ完全一致。这一回避发生在以下背景之下：

2025年1月（TurboQuant论文在arXiv发布的数月前），TurboQuant论文的第二作者Majid Daliri主动联系我们，请求帮助调试他自己基于RaBitQ C++代码实现的Python版本。他详细描述了自己复现的步骤、代码片段和具体报错，这一点可以说明TurboQuant团队对RaBitQ的技术细节有充分的了解。之后在2025年4月他们在arXiv发布的论文版本，以及2025年9月他们在ICLR 2026会议投稿的论文版本中，他们将RaBitQ描述为grid-based PQ，并且在描述中忽略了RaBitQ中核心的random rotation的步骤。ICLR的一位审稿人也在审稿意见中独立指出："RaBitQ and variants are similar to TurboQuant in that they all use random projection"，并明确要求更充分的讨论和比较。尽管如此，在ICLR会议最终版本论文中，TurboQuant的作者不仅没有加入对RaBitQ讨论，甚至反而还将原本正文中对RaBitQ不完整描述移到了附录中。

为此，我们于2026年3月通过邮件联系了TurboQuant所有作者，提出了以上问题及纠正请求后，TurboQuant作者在回复中以

> "The use of random rotation and Johnson-Lindenstrauss transformations has become a standard technique in the field, and it is not feasible for us to cite every method that employs them."

为由拒绝了这一请求。我们认为这一回应是在转移矛盾：作为在相同问题设定下率先将随机旋转（Johnson-Lindenstrauss变换）与向量量化结合、并建立最优理论保证的具体先行工作，RaBitQ应当在文中被准确描述，其与TurboQuant方法的联系应当充分讨论。

---

## TurboQuant论文问题二：错误描述RaBitQ的理论结果

TurboQuant论文在不提供任何论据的情况下，将RaBitQ的理论保证定性为"次优"。TurboQuant论文写道：

> "While the paper's theoretical guarantees are suboptimal, likely due to loose analysis — as practical performance surpasses theoretical bounds"

这句话直接将RaBitQ的理论保证定性为"次优（suboptimal）"，将原因归结为"较粗糙的分析（loose analysis）"。但论文没有提供任何推导、对比或证据来支撑这一判断。

事实是：我们在拓展版RaBitQ论文（arXiv:2409.09913）的Theorem 3.2中，已经严格证明RaBitQ的误差界达到了理论计算机顶级会议论文（Alon-Klartag, FOCS 2017）给出的渐近最优误差界。因为这一结果，我们被邀请至理论计算机科学顶级会议FOCS的Workshop进行报告。

为此，我们于2025年5月通过邮件与TurboQuant的第二作者Majid Daliri进行了多轮详细的邮件技术讨论，逐条澄清了TurboQuant团队对我们理论结果的错误解读。Majid Daliri在邮件中明确表示已将这些讨论告知全体共同作者。

然而后面TurboQuant论文在提交至ICLR 2026、经过审稿、被接收，最终大规模宣发的全过程中，这个对RaBitQ理论保证的错误定性始终未被修正。

一个没有证据支撑的断言，在被原作者具体指出错误、且TurboQuant作者方已明确知情的情况下，仍被保留在正式发表的TurboQuant论文中，我们认为这已超出普通失误的范畴。

---

## TurboQuant论文问题三：刻意创造不公平的实验环境

TurboQuant论文使用劣化的实现、关闭多线程使用单核CPU测试RaBitQ的效果，却使用A100 GPU测试TurboQuant的效果。TurboQuant报告的RaBitQ量化速度比我们开源实现的实际速度慢了数个数量级。

2025年5月的邮件中，Majid Daliri本人解释了这一差距的来源：

> "we were using a single-core CPU instance, and multiprocessing was indeed disabled [...] we weren't fully utilizing parallelism, which explains why it was significantly slower"

我们的官方RaBitQ代码在论文发布至arXiv时（2024年5月与2024年9月）就已经公开，并且默认采用多线程并行。并且，Majid Daliri在2025年1月的邮件中还说明，他成功跑通RaBitQ的代码用以测试，但他用于实验的仍是自己翻译的Python版本。这意味着，TurboQuant论文中对RaBitQ速度的报告，叠加了两层系统性的不公平条件：

1. 使用自己翻译的Python代码，而非我们开源的C++实现
2. 使用单核CPU，关闭多线程并行测试RaBitQ算法，但却使用NVIDIA A100 GPU测试TurboQuant算法

以上两点均未在论文中充分披露。读者看到的是RaBitQ比TurboQuant慢数个数量级这一结论，却无从知道这一结论建立在刻意创造的不公平的实验条件之上。

---

## 事件完整时间线

- **2024年5月**：RaBitQ论文在arXiv发布，同时源代码公开（后面发表在顶级会议SIGMOD 2024）
- **2024年9月**：拓展版RaBitQ论文在arXiv发布，同时源代码公开（后面发表在顶级会议SIGMOD 2025）
- **2025年1月**：TurboQuant论文第二作者Majid Daliri联系我们，请求协助调试Python版RaBitQ实现
- **2025年4月**：TurboQuant论文在arXiv发布
- **2025年5月**：我们跟Majid Daliri通过邮件询问了实验条件的差异并清楚解释了RaBitQ的理论保证最优性，Majid Daliri表示他已告知全体作者，但在我们要求修正TurboQuant论文中的事实性错误之后，Majid Daliri停止回复
- **2025年11月**：我们发现TurboQuant论文被提交至ICLR 2026会议，且论文中的事实性错误并未修正，为此我们联系了ICLR 2026 PC Chairs，未获回应
- **2026年1月**：TurboQuant论文被ICLR 2026接收
- **2026年3月**：TurboQuant团队通过Google官方渠道持续推广，社交媒体相关浏览量已达数千万次
- **2026年3月**：我们正式向TurboQuant全体作者发送邮件，阐述以上三个事实性问题并要求做出修正及澄清。截至目前为止，我们仅收到TurboQuant论文第一作者Amir Zandieh的笼统答复，承诺会修正问题二和问题三，但拒绝修正问题一（即讨论TurboQuant与RaBitQ在技术上的相似性）。并且，他们仅愿意在ICLR 2026正式会议结束之后才做相应修正

---

## 我们已经做了什么

- 在ICLR OpenReview发布公开评论: https://openreview.net/forum?id=tO3ASKZlok
- 向ICLR General Chairs, PC Chairs, Code and Ethnics Chairs再次提交正式投诉，附完整证据包

---

## 我们接下来会做什么

- 在arXiv发布详细的关于TurboQuant和RaBitQ的技术报告
- 考虑向相关机构进一步反映

---

## 最后

我们提出这些问题，目标是让公共学术记录准确地反映各方法之间的真实关系。一篇论文被Google以数千万曝光量推向公众，在这种体量下，论文中错误的叙事不需要主动传播，只需要不被纠正，就会自动成为共识，这也是我们选择公开记录的原因。

在此我们也恳请大家让更多人知道TurboQuant论文背后存在的问题，我们相信真理越辩越明。

---

**原文链接**: https://mp.weixin.qq.com/s/D-McErxxyBb2hQ6fSpU79Q

**抓取时间**: 2026-03-28

**归档位置**: 原文资料/2026-03-28-云头条-D-McErxxyBb2hQ6fSpU79Q.md
