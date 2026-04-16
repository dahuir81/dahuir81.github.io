# 拆解 Hermes Agent 的三层学习机制：OpenClaw 加自总结 Skills 后，差异还剩什么？

**来源**：架构师（JiaGouX）微信公众号
**作者**：若飞
**日期**：2026-04-13
**URL**：https://mp.weixin.qq.com/s/twOGltgevrfhLv6f90SCgg

---

昨天那篇《OpenClaw vs Hermes：一文深入理解两大通用 Agent》发出去后，评论区有个问题很值得单独拎出来讲。

大意是：如果给 OpenClaw 加一套自我总结、自动沉淀 skills 的机制，那它和 Hermes 还有什么区别？

我重新翻了一遍 Hermes Agent 的官方文档和本地仓库源码，也补看了 OpenClaw 官方 memory 文档。

## 太长不看版

- Hermes 的内置记忆使用 MEMORY.md 和 USER.md 两个小型 Markdown 文件，而非 SQLite
- Hermes 的 SQLite + FTS5 主要服务 session_search，是档案室不是随身备忘录
- Hermes 最值得拆的是 skill_manage，把"这类任务以后怎么做"写成 skill
- OpenClaw 现在也有 Honcho、memory_search 和 experimental dreaming
- 如果 OpenClaw 也把自动 skill 沉淀做成系统主路径，它在 learning loop 这一层会非常接近 Hermes

## 三层记忆

**第一层：事实记忆** - MEMORY.md + USER.md，小而硬（约 1300 tokens），frozen snapshot 保护 prompt cache
**第二层：会话检索** - SQLite + FTS5 是档案室，需要时翻历史
**第三层：过程记忆** - skill_manage，把做事方法沉淀为可执行流程

## 核心洞察

OpenClaw 给加了自总结 skills，learning loop 层面会非常接近。差异从"有没有"变成"系统重心放在哪"——OpenClaw 偏 Gateway 控制面，Hermes 偏自我提升的执行者。

