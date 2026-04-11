# OpenClaw 钉钉渠道空消息故障排查

**日期:** 2026-04-11
**状态:** 根因已定位，修复待定，系统维持现状观察
**标签:** #运维 #OpenClaw #故障排查 #钉钉

---

## 问题描述

本地 OpenClaw（Tars）主模型为 bailian/qwen3.6-plus，长期存在以下现象：

- **飞书渠道:** 简报推送内容完整，正常显示
- **钉钉渠道:** 每次推送内容为空，只有"✅ Done"或完全空白
- **Cron 报错:** hot-news-briefing-v3、preflight-health-check 频繁出现 message failed、job execution timed out
- **对话输出:** Tars 频繁出现英文片段和"我需要…"、"Let me…"类元叙述

---

## 根因分析

### 根因链

```
Qwen3.6-plus API 返回 reasoning_content 字段（百炼端强制行为）
 → pi-ai (@mariozechner/pi-ai) 把 reasoning_content 打成 thinking content block
 → OpenClaw dispatch 管道判定 isReasoning === true
 → dispatch 中 onBlockReply 和最终回复循环都跳过 isReasoning 内容
 → queuedFinal 永远停留在初始值 false
 → DingTalk 插件 fallback 检查 typeof bufferedFinal === "string" 失败
 → 钉钉收到空消息（deliveredFinalCount=0）
```

### 为什么飞书没事

飞书是 OpenClaw 内置渠道，直接从 LLM 流式响应中提取文本投递，不经过 dispatch 的 isReasoning 过滤。钉钉是外部插件，依赖 dispatch pipeline 的 block/final 回调，所有被 isReasoning 标记的内容一律被丢弃。

**这是模型 API + 中间件 + dispatch 三层叠加的设计冲突，不是 bug。**

### 为什么 openclaw.json 改不了

- `reasoning: false` 只控制是否向 API 发送 `enable_thinking` 参数
- 即使不请求 thinking，百炼 API 仍会返回 `reasoning_content` 字段
- pi-ai 看的是实际收到的字段，不看请求参数
- openclaw.json 没有 `isReasoning` / `treatAsReasoning` / `suppressReasoning` 配置项
- `extraParams` / `minScore` 等字段被 schema 拒绝

---

## Cron message tool 的独立 bug 链

钉钉插件的 message 工具实现有三个独立 bug：

1. **jsonResult is not a function** — 插件编译/导出问题
2. **staffId.notExisted** — target 用 ou_xxx 格式但走 staffId 查询
3. **Action send requires a target** — agent 有时省略 target 参数

根因修好后，简报走 dispatch 正常 final payload 路径，这三个 bug 自动绕过。

---

## 无效/有害方案

| 方案 | 结果 | 教训 |
|------|------|------|
| 把 qwen3 加进 reasoning 正则 | 已回滚 | 方向反了 |
| 给模型配置加 `extraParams.enable_thinking: false` | schema 拒绝 | 百炼不认这个字段 |
| 给 modelstudio 插件加 `minScore: 0.5` | schema 拒绝 | 插件没设计这个字段 |
| 停用 hot-news-briefing-v3 cron job | 已回滚 | **严重失误**——停了等于关业务 |
| 改 Qwen enable_thinking 参数 | 死路 | 关了 thinking 请求，API 照样返回 reasoning_content |

---

## 保留的有效改动

| 改动 | 状态 |
|------|------|
| reply-strategy-markdown.ts 加分片+重试逻辑 | ✅ 已生效 |
| SOUL.md 加输出铁律（禁止"我需要"/"Let me"开头） | ✅ 已生效 |
| AGENTS.md 记忆读取改通配符 `memory/YYYY-MM-DD*.md` | ✅ 已生效 |
| cardMode: true 已删除 | ✅ 已生效 |
| hot-news-briefing-v3 已重新启用 | ✅ 已恢复 |

---

## 修复方向（按优先级）

### P1：OpenClaw 项目提 issue

建议作者加配置项：
- `channels.dingtalk.acceptReasoningBlocks: true`
- 或 `treatReasoningAsText: true`

### P2：研究渠道级 hook

读插件 SDK 文档，确认钉钉能否注册"接收所有 block（包括 reasoning）"的回调。

### P3：查百炼 API 官方参数

确认是否有 `include_reasoning: false` 类请求参数。

### P4（最后手段）：换模型

给简报线换 Kimi 等模型，需先在测试环境跑通、对比输出质量、确认不返回 reasoning_content。

---

## 核心教训

### 1. 渠道差异 = 投递路径差异
"A 正常 + B 异常"时，根因在投递路径差异，不在内容生成或模型配置。

### 2. 停用任务前必看 payload
正确流程：list → 看 payload → 确认业务影响 → 再决定。

### 3. 不改 dist 和 node_modules
修复走配置项、插件 hook、上游 issue。

### 4. CC 会忠实执行错误指令
给 CC 强制指令前，人必须先想清楚方向。

### 5. 稳定性优先于速度
已经存在的问题晚一天不糟，仓促修复引入新问题可能直接不可用。

### 6. 模型选择影响工具链兼容性
选模型时除了能力和成本，还要评估 API 输出格式与现有工具链的兼容性。

---

## 当前系统状态

| 项目 | 状态 |
|------|------|
| 主模型 | bailian/qwen3.6-plus |
| Fallback | bailian/kimi-k2.5、openrouter/qwen3.6-plus 等 |
| Cron | hot-news-briefing-v3 enabled |
| 钉钉 | 收不到完整内容（根因未修） |
| 飞书 | 正常 |

---

## 检查清单

- [ ] 飞书简报每日正常推送（7:25 / 13:25 / 21:25）
- [ ] 主对话英文/元叙述泄漏频率下降
- [ ] 记忆文件读取正常（通配符匹配）
- [ ] gateway.log deliveredFinalCount=0 仍每次出现
- [ ] OpenClaw 项目是否有人遇到同类 issue

---

## 关联
- [[OpenClaw]]
- [[Kimi K2.5]]
