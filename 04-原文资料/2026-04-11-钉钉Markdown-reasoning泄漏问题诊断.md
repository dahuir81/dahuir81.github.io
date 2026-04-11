# 钉钉 Markdown 模式 reasoning 内容泄漏问题诊断

**来源**: CC (Claude Code) 技术诊断  
**时间**: 2026-04-11 21:41  
**问题**: 钉钉对话中出现英文 thinking 内容  
**诊断者**: CC (Claude Code)  
**报告对象**: 慧哥

---

## 一句话结论

钉钉 Markdown 模式的 `reply-strategy-markdown.ts` 在 `deliver` 方法里**完全没有判断 `isReasoning` 字段**，把模型的英文 thinking 内容当成正式回答直接发给用户。飞书没事是因为飞书有独立的 `StreamingCardController` 把 reasoning 和 answer 彻底分开了。

---

## 触发链路

```
百炼 API 总是返回 reasoning_content（即使没开 thinking）
    ↓
OpenClaw 4.9 把它标记成 isReasoning: true 的 block
    ↓
框架 buffered dispatcher 把所有 block 都缓冲下来
    ↓
inbound-handler.ts:1907 调用 strategy.deliver({..., isReasoning: true})
    ↓
钉钉 Markdown 策略不看 isReasoning 字段，直接 emitAnswerSuffix
    ↓
英文 thinking 出现在钉钉对话里
```

---

## 雪上加霜的 Bug

在 `inbound-handler.ts:1953` 的 `bufferedFinal` 回退路径里**硬编码了 `isReasoning: false`**，意味着即使下游想过滤也过滤不了。

---

## 为什么是 4.9 之后才有

4.9 那条 "default missing reasoning effort to high" 的变更让框架更积极地保留 reasoning 字段。之前可能这些内容在框架层就被丢弃了，4.9 之后被原样传到了 channel 插件，而**钉钉插件根本没准备好处理它**。

---

## 修复方案（按优先级）

### P0 必改

**文件**: `reply-strategy-markdown.ts`  
**位置**: `deliver` 方法  
**修改**: 添加 isReasoning 判断

```typescript
if (payload.isReasoning === true) {
  return;
}
```

### P1 加固

**文件**: `inbound-handler.ts:1953`  
**问题**: `isReasoning: false` 硬编码  
**修改**: 根据实际内容判断，或者用 `splitCardReasoningAnswerText` 二次过滤

### P2 顺手

**修改**: 两个 "✅ Done" 改成 "✅ 完成"

### P3 可选

**文件**: `getReplyOptions`  
**修改**: 注册一个空的 `onReasoningStream` 回调，告诉框架 reasoning 流已经被消费了

---

## 修复建议

P0 那一行改完之后，先在常用场景测一下（图片处理、文件操作、查资料），确认英文不再出现。如果还有零星泄漏，再上 P1 的二次过滤兜底。不要一次改太多，否则出问题不好定位是哪个改动引入的。

---

## 相关技术点

- **OpenClaw 4.9**: 变更了 reasoning effort 默认值
- **百炼 API**: 总是返回 reasoning_content
- **钉钉 Markdown 策略**: `reply-strategy-markdown.ts`
- **飞书策略**: `StreamingCardController`（已正确分离 reasoning/answer）
- **框架层**: `inbound-handler.ts`, `buffered dispatcher`

---

## 标签

#OpenClaw #钉钉 #Markdown #Reasoning #Bug修复 #技术诊断 #CC
