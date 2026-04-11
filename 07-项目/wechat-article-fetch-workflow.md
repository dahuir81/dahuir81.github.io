# 微信公众号文章抓取工作流

**创建时间**: 2026-04-05  
**更新**: 2026-04-05（强制记住！）  
**状态**: ✅ 已固化  
**标签**: #微信 #文章抓取 #Scrapling #工作流

---

## ⚠️ 重要提醒

**慧哥强调：必须记住这个流程，不要再重复犯错！**

---

## 标准抓取流程

### 1. 首选方案：web-content-fetcher skill（Scrapling）

**适用**: 微信公众号文章（mp.weixin.qq.com）

**命令**:
```bash
python3 ~/.openclaw/workspace/skills/web-content-fetcher/scripts/fetch.py <url> 30000
```

**示例**:
```bash
python3 ~/.openclaw/workspace/skills/web-content-fetcher/scripts/fetch.py "https://mp.weixin.qq.com/s/gc8Qj06LWJ01fkbjTpG3Aw" 30000
```

**为什么用Scrapling？**
- Jina Reader 会被微信公众号阻断（403错误）
- Scrapling 使用真实浏览器引擎，能绕过反爬
- 自动处理JavaScript动态加载内容

---

### 2. 备选方案：web-content-fetcher skill（自动模式）

**适用**: 普通网页、知乎、CSDN、技术博客等

**自动策略**:
```
URL
 ↓
1. Jina Reader（首选）- 快，200次/天免费配额
 ↓
2. Scrapling + html2text（Jina失败时）
 ↓
3. web_fetch 直接抓（静态页面兜底）
```

**域名快捷路由**（自动跳过Jina）:
- `mp.weixin.qq.com` → 直接用Scrapling
- `zhuanlan.zhihu.com`、`juejin.cn`、`csdn.net` → 优先Scrapling

---

### 3. 兜底方案：autoglm-browser-agent

**适用**: 复杂动态页面、需要交互的页面

**注意**: 需要Chrome浏览器和AutoGLM扩展支持

---

## 失败案例分析

### ❌ 错误做法（不要再犯）

1. **直接用 web_fetch 抓微信文章**
   - 结果：只能拿到页面骨架，没有正文
   - 原因：微信文章是JavaScript动态加载

2. **用 Jina Reader 抓微信文章**
   - 结果：403 Forbidden
   - 原因：微信会阻断Jina的请求

3. **用 AutoGLM 作为首选**
   - 结果：启动慢、可能遇到签名问题
   - 原因：微信页面检测到自动化工具会阻断

4. **重复尝试已失败的方法**
   - 结果：浪费时间，慧哥 frustration
   - 原因：没有先查工作流和记忆

---

## 正确执行顺序

```
收到微信文章链接
    ↓
立即使用 Scrapling 方案（不要试其他方法！）
    ↓
python3 ~/.openclaw/workspace/skills/web-content-fetcher/scripts/fetch.py <url> 30000
    ↓
成功 → 继续博客撰写流程
失败 → 检查网络/代理，再试一次
    ↓
两次失败 → 记录为"无法提取"，询问慧哥
```

---

## 相关文件

- **Skill文档**: `~/.openclaw/workspace/skills/web-content-fetcher/SKILL.md`
- **AGENTS.md**: 博客发布工作流 4.2节
- **脚本路径**: `~/.openclaw/workspace/skills/web-content-fetcher/scripts/fetch.py`

---

## 更新日志

- **2026-04-05**: 创建本文档，固化微信文章抓取流程（慧哥强制要求记住）

---

_记住：简单可用 > 复杂完美。先用Scrapling，不要绕弯子。_
