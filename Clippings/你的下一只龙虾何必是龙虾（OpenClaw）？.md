---
title: "你的下一只龙虾何必是龙虾（OpenClaw）？"
source: "https://mp.weixin.qq.com/s/25Rmx51xQoqP4_EvgCEL7Q"
author:
  - "[[DracoVibeCoding]]"
published:
created: 2026-04-06
description:
tags:
  - "clippings"
---
*2026年4月5日 20:00*

在深入体验Hermes Agent两天之后，我决定将最少一半养虾时间放到Hermes Agent上，理由如下：

- • 内禀的skills自我强化（进化）机制，越用越聪明，并且不需要你去刻意提醒和教育，导致Hermes Agent的养成效率要比养虾高太多；
- • 透明的工具调用链，使用过程非常踏实；
- • 飞书/钉钉/企微等channel能力齐备，不明显弱于OpenClaw；
- • CLI能力都可以直接调用，最近的开放出来的飞书CLI、企微CLI、Obsidian CLI、Google CLI等一个不落全能用上；
- • 背后的NOUS RESEARCH是个综合能力颇强的团队，NOUS旗下有HERMES系列大模型（HERMES-4有405B规模）、模型分布式训练基建Psyche、Hermes AGENT、API Portal等，颇有点小众版Deepseek即视感；  
	![vUJYbx](data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg width='1px' height='1px' viewBox='0 0 1 1' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'%3E%3Ctitle%3E%3C/title%3E%3Cg stroke='none' stroke-width='1' fill='none' fill-rule='evenodd' fill-opacity='0'%3E%3Cg transform='translate(-249.000000, -126.000000)' fill='%23FFFFFF'%3E%3Crect x='249' y='126' width='1' height='1'%3E%3C/rect%3E%3C/g%3E%3C/g%3E%3C/svg%3E)

同时，鉴于Hermes Agent中文资料尚少，我就用Hermes Agent创建了Hermes中文站（托管在了Vercel），复刻并翻译了官方的全部Documents：

- • https://hermes-doc.aigc.green/
- • https://hermes-doc.aigc.green/getting-started/quickstart
![60ArmK](data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg width='1px' height='1px' viewBox='0 0 1 1' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'%3E%3Ctitle%3E%3C/title%3E%3Cg stroke='none' stroke-width='1' fill='none' fill-rule='evenodd' fill-opacity='0'%3E%3Cg transform='translate(-249.000000, -126.000000)' fill='%23FFFFFF'%3E%3Crect x='249' y='126' width='1' height='1'%3E%3C/rect%3E%3C/g%3E%3C/g%3E%3C/svg%3E)

![HiO0Sr](data:image/svg+xml,%3C%3Fxml version='1.0' encoding='UTF-8'%3F%3E%3Csvg width='1px' height='1px' viewBox='0 0 1 1' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'%3E%3Ctitle%3E%3C/title%3E%3Cg stroke='none' stroke-width='1' fill='none' fill-rule='evenodd' fill-opacity='0'%3E%3Cg transform='translate(-249.000000, -126.000000)' fill='%23FFFFFF'%3E%3Crect x='249' y='126' width='1' height='1'%3E%3C/rect%3E%3C/g%3E%3C/g%3E%3C/svg%3E)

以下附上“快速开始”、安装”、“安装卸载”、“学习路径”几个章节相关内容。  
更多关于Hermes Agent的内容大家可以直接访问中文站： `https://hermes-doc.aigc.green/getting-started/quickstart`

---

## 快速开始

本指南将引导你完成安装 Hermes Agent、设置提供商并进行首次对话。结束时，你将了解其主要功能以及如何进一步探索。

## 1\. 安装 Hermes Agent

运行一行式安装命令：

```
# Linux / macOS / WSL2
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```

:::tip Windows 用户  
请先安装 WSL2，然后在 WSL2 终端内运行上述命令。  
:::

安装完成后，重新加载你的 shell：

```
source ~/.bashrc   # 或者 source ~/.zshrc
```

## 2\. 设置提供商

安装程序会自动配置你的 LLM 提供商。之后如需更改，可以使用以下任一命令：

```
hermes model       # 选择你的 LLM 提供商和模型
hermes tools       # 配置启用哪些工具
hermes setup       # 或者一次性配置所有内容
```

`hermes model` 会引导你选择推理提供商：

| 提供商 | 说明 | 如何设置 |
| --- | --- | --- |
| **Nous Portal** | 基于订阅，零配置 | 通过 `hermes model` 进行 OAuth 登录 |
| **OpenAI Codex** | ChatGPT OAuth，使用 Codex 模型 | 通过 `hermes model` 进行设备代码认证 |
| **Anthropic** | 直接使用 Claude 模型 (Pro/Max 或 API 密钥) | 通过 `hermes model` 使用 Claude Code 认证，或提供 Anthropic API 密钥 |
| **OpenRouter** | 跨多个模型的多提供商路由 | 输入你的 API 密钥 |
| **Z.AI** | GLM / 智谱托管模型 | 设置 `GLM_API_KEY` / `ZAI_API_KEY` |
| **Kimi / Moonshot** | Moonshot 托管的代码和聊天模型 | 设置 `KIMI_API_KEY` |
| **MiniMax** | 国际版 MiniMax 端点 | 设置 `MINIMAX_API_KEY` |
| **MiniMax China** | 中国区 MiniMax 端点 | 设置 `MINIMAX_CN_API_KEY` |
| **Alibaba Cloud** | 通过 DashScope 使用通义千问模型 | 设置 `DASHSCOPE_API_KEY` |
| **Hugging Face** | 通过统一路由使用 20+ 开源模型 (Qwen, DeepSeek, Kimi 等) | 设置 `HF_TOKEN` |
| **Kilo Code** | KiloCode 托管模型 | 设置 `KILOCODE_API_KEY` |
| **OpenCode Zen** | 按需付费访问精选模型 | 设置 `OPENCODE_ZEN_API_KEY` |
| **OpenCode Go** | 每月 10 美元订阅开源模型 | 设置 `OPENCODE_GO_API_KEY` |
| **Vercel AI Gateway** | Vercel AI Gateway 路由 | 设置 `AI_GATEWAY_API_KEY` |
| **自定义端点** | VLLM, SGLang, Ollama 或任何 OpenAI 兼容的 API | 设置基础 URL + API 密钥 |

> Tip
> 
> 你可以随时使用 `hermes model` 切换提供商 —— 无需更改代码，没有锁定。配置自定义端点时，Hermes 会提示输入上下文窗口大小，并在可能时自动检测。详情请参阅上下文长度检测。

## 3\. 开始聊天

```
hermes
```

就这样！你会看到一个欢迎横幅，显示你的模型、可用工具和技能。输入消息并按回车键。

```
❯ 你能帮我做什么？
```

智能体可以访问用于网络搜索、文件操作、终端命令等工具 —— 所有这些都开箱即用。

## 4\. 尝试关键功能

### 让它使用终端

```
❯ 我的磁盘使用情况如何？显示前 5 个最大的目录。
```

智能体会代表你运行终端命令并显示结果。

### 使用斜杠命令

输入 `/` 查看所有命令的自动补全下拉列表：

| 命令 | 功能 |
| --- | --- |
| `/help` | 显示所有可用命令 |
| `/tools` | 列出可用工具 |
| `/model` | 交互式切换模型 |
| `/personality pirate` | 尝试一个有趣的个性 |
| `/save` | 保存对话 |

### 多行输入

按 `Alt+Enter` 或 `Ctrl+J` 添加新行。非常适合粘贴代码或编写详细的提示。

### 中断智能体

如果智能体耗时过长，只需输入新消息并按回车键 —— 它会中断当前任务并切换到你的新指令。 `Ctrl+C` 也有效。

### 恢复会话

当你退出时，hermes 会打印一个恢复命令：

```
hermes --continue    # 恢复最近的会话
hermes -c            # 简写形式
```

## 5\. 进一步探索

接下来可以尝试以下内容：

### 设置沙盒化终端

为了安全起见，可以在 Docker 容器或远程服务器上运行智能体：

```
hermes config set terminal.backend docker    # Docker 隔离
hermes config set terminal.backend ssh       # 远程服务器
```

### 连接消息平台

通过 Telegram、Discord、Slack、WhatsApp、Signal、Email 或 Home Assistant 从手机或其他界面与 Hermes 聊天：

```
hermes gateway setup    # 交互式平台配置
```

### 添加语音模式

想在 CLI 中使用麦克风输入或在消息平台中听到语音回复吗？

```
pip install "hermes-agent[voice]"

# 可选但推荐用于免费的本地语音转文本
pip install faster-whisper
```

然后在 CLI 中启动 Hermes 并启用它：

```
/voice on
```

按 `Ctrl+B` 录音，或使用 `/voice tts` 让 Hermes 说出它的回复。有关在 CLI、Telegram、Discord 和 Discord 语音频道中的完整设置，请参阅语音模式。

### 安排自动化任务

```
❯ 每天早上 9 点，检查 Hacker News 上的 AI 新闻，并通过 Telegram 发送摘要给我。
```

智能体会通过网关设置一个自动运行的 cron 任务。

### 浏览和安装技能

```
hermes skills search kubernetes
hermes skills search react --source skills-sh
hermes skills search https://mintlify.com/docs --source well-known
hermes skills install openai/skills/k8s
hermes skills install official/security/1password
hermes skills install skills-sh/vercel-labs/json-render/json-render-react --force
```

提示：

- • 使用 `--source skills-sh` 搜索公共的 `skills.sh` 目录。
- • 使用 `--source well-known` 配合文档/站点 URL，从 `/.well-known/skills/index.json` 发现技能。
- • 仅在审查第三方技能后使用 `--force` 。它可以覆盖非危险策略阻止，但不能覆盖 `dangerous` 扫描判定。

或者在聊天中使用 `/skills` 斜杠命令。

### 通过 ACP 在编辑器内使用 Hermes

Hermes 也可以作为 ACP 服务器运行，用于 VS Code、Zed 和 JetBrains 等兼容 ACP 的编辑器：

```
pip install -e '.[acp]'
hermes acp
```

有关设置详情，请参阅 ACP 编辑器集成。

### 尝试 MCP 服务器

通过模型上下文协议连接到外部工具：

```
# 添加到 ~/.hermes/config.yaml
mcp_servers:
  github:
    command: npx
    args: ["-y", "@modelcontextprotocol/server-github"]
    env:
      GITHUB_PERSONAL_ACCESS_TOKEN: "ghp_xxx"
```

---

## 快速参考

| 命令 | 描述 |
| --- | --- |
| `hermes` | 开始聊天 |
| `hermes model` | 选择你的 LLM 提供商和模型 |
| `hermes tools` | 按平台配置启用哪些工具 |
| `hermes setup` | 完整设置向导 (一次性配置所有内容) |
| `hermes doctor` | 诊断问题 |
| `hermes update` | 更新到最新版本 |
| `hermes gateway` | 启动消息网关 |
| `hermes --continue` | 恢复上次会话 |

---

## 安装

使用一行命令安装程序，两分钟内即可启动并运行 Hermes Agent，或者按照手动步骤以获得完全控制。

## 快速安装

### Linux / macOS / WSL2

```
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```

:::warning Windows  
**不支持** 原生 Windows。请安装 WSL2 并在其中运行 Hermes Agent。上述安装命令在 WSL2 内有效。  
:::

### 安装程序的作用

安装程序会自动处理所有事情——所有依赖项（Python、Node.js、ripgrep、ffmpeg）、仓库克隆、虚拟环境、全局 `hermes` 命令设置以及 LLM 提供商配置。完成后，您就可以开始聊天了。

### 安装后

重新加载您的 shell 并开始聊天：

```
source ~/.bashrc   # 或者：source ~/.zshrc
hermes             # 开始聊天！
```

以后要重新配置个别设置，请使用专用命令：

```
hermes model          # 选择您的 LLM 提供商和模型
hermes tools          # 配置启用哪些工具
hermes gateway setup  # 设置消息传递平台
hermes config set     # 设置个别配置值
hermes setup          # 或者运行完整的设置向导一次性配置所有内容
```

---

## 先决条件

唯一的先决条件是 **Git** 。安装程序会自动处理其他所有事情：

- • **uv** （快速的 Python 包管理器）
- • **Python 3.11** （通过 uv 安装，无需 sudo）
- • **Node.js v22** （用于浏览器自动化和 WhatsApp 桥接）
- • **ripgrep** （快速文件搜索）
- • **ffmpeg** （用于 TTS 的音频格式转换）

> Info
> 
> 您 **不需要** 手动安装 Python、Node.js、ripgrep 或 ffmpeg。安装程序会检测缺少的内容并为您安装。只需确保 `git` 可用（ `git --version` ）。

:::tip Nix 用户  
如果您使用 Nix（在 NixOS、macOS 或 Linux 上），有一个专用的设置路径，包含 Nix flake、声明式 NixOS 模块和可选的容器模式。请参阅 **Nix & NixOS 设置** 指南。  
:::

---

## 手动安装

如果您希望完全控制安装过程，请按照以下步骤操作。

### 步骤 1：克隆仓库

使用 `--recurse-submodules` 克隆以拉取所需的子模块：

```
git clone --recurse-submodules https://github.com/NousResearch/hermes-agent.git
cd hermes-agent
```

如果您已经克隆但没有使用 `--recurse-submodules` ：

```
git submodule update --init --recursive
```

### 步骤 2：安装 uv 并创建虚拟环境

```
# 安装 uv（如果尚未安装）
curl -LsSf https://astral.sh/uv/install.sh | sh

# 使用 Python 3.11 创建 venv（如果不存在，uv 会下载它——无需 sudo）
uv venv venv --python 3.11
```

> Tip
> 
> 您 **不需要** 激活 venv 来使用 `hermes` 。入口点有一个硬编码的 shebang 指向 venv 的 Python，因此一旦创建符号链接，它就可以全局工作。

### 步骤 3：安装 Python 依赖项

```
# 告诉 uv 要安装到哪个 venv
export VIRTUAL_ENV="$(pwd)/venv"

# 安装所有额外功能
uv pip install -e ".[all]"
```

如果您只想要核心代理（无 Telegram/Discord/cron 支持）：

```
uv pip install -e "."
```
**可选额外功能细分**

| 额外功能 | 添加的内容 | 安装命令 |
| --- | --- | --- |
| `all` | 以下所有内容 | `uv pip install -e ".[all]"` |
| `messaging` | Telegram 和 Discord 网关 | `uv pip install -e ".[messaging]"` |
| `cron` | 用于计划任务的 Cron 表达式解析 | `uv pip install -e ".[cron]"` |
| `cli` | 设置向导的终端菜单 UI | `uv pip install -e ".[cli]"` |
| `modal` | Modal 云执行后端 | `uv pip install -e ".[modal]"` |
| `tts-premium` | ElevenLabs 高级语音 | `uv pip install -e ".[tts-premium]"` |
| `voice` | CLI 麦克风输入 + 音频播放 | `uv pip install -e ".[voice]"` |
| `pty` | PTY 终端支持 | `uv pip install -e ".[pty]"` |
| `honcho` | AI 原生记忆（Honcho 集成） | `uv pip install -e ".[honcho]"` |
| `mcp` | 模型上下文协议支持 | `uv pip install -e ".[mcp]"` |
| `homeassistant` | Home Assistant 集成 | `uv pip install -e ".[homeassistant]"` |
| `acp` | ACP 编辑器集成支持 | `uv pip install -e ".[acp]"` |
| `slack` | Slack 消息传递 | `uv pip install -e ".[slack]"` |
| `dev` | pytest 和测试工具 | `uv pip install -e ".[dev]"` |

您可以组合额外功能： `uv pip install -e ".[messaging,cron]"`

### 步骤 4：安装可选子模块（如果需要）

```
# RL 训练后端（可选）
uv pip install -e "./tinker-atropos"
```

两者都是可选的——如果您跳过它们，相应的工具集将不可用。

### 步骤 5：安装 Node.js 依赖项（可选）

仅用于 **浏览器自动化** （基于 Browserbase）和 **WhatsApp 桥接** ：

```
npm install
```

### 步骤 6：创建配置目录

```
# 创建目录结构
mkdir -p ~/.hermes/{cron,sessions,logs,memories,skills,pairing,hooks,image_cache,audio_cache,whatsapp/session}

# 复制示例配置文件
cp cli-config.yaml.example ~/.hermes/config.yaml

# 为 API 密钥创建一个空的 .env 文件
touch ~/.hermes/.env
```

### 步骤 7：添加您的 API 密钥

打开 `~/.hermes/.env` 并至少添加一个 LLM 提供商密钥：

```
# 必需 —— 至少一个 LLM 提供商：
OPENROUTER_API_KEY=sk-or-v1-your-key-here

# 可选 —— 启用额外工具：
FIRECRAWL_API_KEY=fc-your-key          # 网络搜索和抓取（或自托管，请参阅文档）
FAL_KEY=your-fal-key                   # 图像生成（FLUX）
```

或者通过 CLI 设置它们：

```
hermes config set OPENROUTER_API_KEY sk-or-v1-your-key-here
```

### 步骤 8：将 hermes 添加到您的 PATH

```
mkdir -p ~/.local/bin
ln -sf "$(pwd)/venv/bin/hermes" ~/.local/bin/hermes
```

如果 `~/.local/bin` 不在您的 PATH 中，请将其添加到您的 shell 配置中：

```
# Bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc && source ~/.bashrc

# Zsh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc

# Fish
fish_add_path $HOME/.local/bin
```

### 步骤 9：配置您的提供商

```
hermes model       # 选择您的 LLM 提供商和模型
```

### 步骤 10：验证安装

```
hermes version    # 检查命令是否可用
hermes doctor     # 运行诊断以验证一切正常
hermes status     # 检查您的配置
hermes chat -q "Hello! What tools do you have available?"
```

---

## 快速参考：手动安装（精简版）

适用于只想看命令的用户：

```
# 安装 uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# 克隆并进入
git clone --recurse-submodules https://github.com/NousResearch/hermes-agent.git
cd hermes-agent

# 使用 Python 3.11 创建 venv
uv venv venv --python 3.11
export VIRTUAL_ENV="$(pwd)/venv"

# 安装所有内容
uv pip install -e ".[all]"
uv pip install -e "./tinker-atropos"
npm install  # 可选，用于浏览器工具和 WhatsApp

# 配置
mkdir -p ~/.hermes/{cron,sessions,logs,memories,skills,pairing,hooks,image_cache,audio_cache,whatsapp/session}
cp cli-config.yaml.example ~/.hermes/config.yaml
touch ~/.hermes/.env
echo 'OPENROUTER_API_KEY=sk-or-v1-your-key' >> ~/.hermes/.env

# 使 hermes 全局可用
mkdir -p ~/.local/bin
ln -sf "$(pwd)/venv/bin/hermes" ~/.local/bin/hermes

# 验证
hermes doctor
hermes
```

---

## 故障排除

| 问题 | 解决方案 |
| --- | --- |
| `hermes: command not found` | 重新加载您的 shell（ `source ~/.bashrc` ）或检查 PATH |
| `API key not set` | 运行 `hermes model` 配置您的提供商，或 `hermes config set OPENROUTER_API_KEY your_key` |
| 更新后缺少配置 | 运行 `hermes config check` 然后 `hermes config migrate` |

如需更多诊断，请运行 `hermes doctor` —— 它会准确告诉您缺少什么以及如何修复。

---

## 更新与卸载

## 更新

使用一条命令即可更新到最新版本：

```
hermes update
```

此命令会拉取最新代码、更新依赖项，并提示你配置自上次更新以来新增的任何选项。

> Tip
> 
> `hermes update` 会自动检测新的配置选项并提示你添加。如果你跳过了该提示，可以手动运行 `hermes config check` 来查看缺失的选项，然后运行 `hermes config migrate` 以交互方式添加它们。

### 通过消息平台更新

你也可以直接从 Telegram、Discord、Slack 或 WhatsApp 发送以下命令来更新：

```
/update
```

此命令会拉取最新代码、更新依赖项，并重启网关。

### 手动更新

如果你是手动安装的（而非通过快速安装程序）：

```
cd /path/to/hermes-agent
export VIRTUAL_ENV="$(pwd)/venv"

# 拉取最新代码和子模块
git pull origin main
git submodule update --init --recursive

# 重新安装（会获取新的依赖项）
uv pip install -e ".[all]"
uv pip install -e "./tinker-atropos"

# 检查新的配置选项
hermes config check
hermes config migrate   # 交互式添加任何缺失的选项
```

---

## 卸载

```
hermes uninstall
```

卸载程序会询问你是否保留配置文件（ `~/.hermes/` ）以便将来重新安装。

### 手动卸载

```
rm -f ~/.local/bin/hermes
rm -rf /path/to/hermes-agent
rm -rf ~/.hermes            # 可选 — 如果你计划重新安装，请保留
```

> Info
> 
> 如果你将网关安装为系统服务，请先停止并禁用它：
> 
> ```
> hermes gateway stop
> # Linux: systemctl --user disable hermes-gateway
> # macOS: launchctl remove ai.hermes.gateway
> ```

---

## 学习路径

Hermes Agent 能做很多事情——CLI 助手、Telegram/Discord 机器人、任务自动化、RL 训练等等。本页面将根据你的经验水平和想要实现的目标，帮助你确定从哪里开始以及阅读哪些内容。

:::tip 从这里开始  
如果你还没有安装 Hermes Agent，请先阅读安装指南，然后运行快速入门。下面的所有内容都假设你已经成功安装。  
:::

## 如何使用本页面

- • **知道自己的水平？** 跳转到按经验水平划分的表格，并按照你所在层级的阅读顺序进行学习。
- • **有特定目标？** 直接跳到按使用场景划分，找到匹配你需求的场景。
- • **只是随便看看？** 查看核心功能概览表格，快速了解 Hermes Agent 的所有功能。

## 按经验水平划分 {#by-experience-level}

| 水平 | 目标 | 推荐阅读顺序 | 预计时间 |
| --- | --- | --- | --- |
| **初学者** | 上手运行，进行基本对话，使用内置工具 | 安装 → 快速入门 → CLI 使用 → 配置 | ~1 小时 |
| **中级** | 设置消息机器人，使用高级功能如记忆、定时任务和技能 | 会话 → 消息 → 工具 → 技能 → 记忆 → 定时任务 | ~2–3 小时 |
| **高级** | 构建自定义工具，创建技能，使用 RL 训练模型，为项目做贡献 | 架构 → 添加工具 → 创建技能 → RL 训练 → 贡献指南 | ~4–6 小时 |

## 按使用场景划分 {#by-use-case}

选择与你目标匹配的场景。每个场景都按推荐阅读顺序链接到相关文档。

### “我想要一个 CLI 编码助手”

将 Hermes Agent 用作交互式终端助手，用于编写、审查和运行代码。

1. 1\. 安装
2. 2\. 快速入门
3. 3\. CLI 使用
4. 4\. 代码执行
5. 5\. 上下文文件
6. 6\. 技巧与窍门

> Tip
> 
> 通过上下文文件直接将文件传入对话。Hermes Agent 可以读取、编辑和运行你项目中的代码。

### “我想要一个 Telegram/Discord 机器人”

在你喜欢的消息平台上部署 Hermes Agent 作为机器人。

1. 1\. 安装
2. 2\. 配置
3. 3\. 消息功能概述
4. 4\. Telegram 设置
5. 5\. Discord 设置
6. 6\. 语音模式
7. 7\. 与 Hermes 一起使用语音模式
8. 8\. 安全

完整项目示例，请参阅：

- • 每日简报机器人
- • 团队 Telegram 助手

### “我想要自动化任务”

安排重复性任务、运行批处理作业或将智能体操作串联起来。

1. 1\. 快速入门
2. 2\. 定时任务调度
3. 3\. 批处理
4. 4\. 委托
5. 5\. 钩子

> Tip
> 
> 定时任务可以让 Hermes Agent 按计划运行任务——每日摘要、定期检查、自动报告——而无需你亲自在场。

### “我想要构建自定义工具/技能”

用你自己的工具和可复用的技能包来扩展 Hermes Agent。

1. 1\. 工具概述
2. 2\. 技能概述
3. 3\. MCP（模型上下文协议）
4. 4\. 架构
5. 5\. 添加工具
6. 6\. 创建技能

> Tip
> 
> 工具是智能体可以调用的独立函数。技能是打包在一起的工具、提示词和配置的集合。从工具开始，逐步进阶到技能。

### “我想要训练模型”

使用强化学习，通过 Hermes Agent 内置的 RL 训练流程来微调模型行为。

1. 1\. 快速入门
2. 2\. 配置
3. 3\. RL 训练
4. 4\. 供应商路由
5. 5\. 架构

> Tip
> 
> 当你已经了解 Hermes Agent 如何处理对话和工具调用的基础知识后，RL 训练效果最佳。如果你是新手，请先完成初学者路径。

### “我想将它用作 Python 库”

以编程方式将 Hermes Agent 集成到你自己的 Python 应用程序中。

1. 1\. 安装
2. 2\. 快速入门
3. 3\. Python 库指南
4. 4\. 架构
5. 5\. 工具
6. 6\. 会话

## 核心功能概览 {#key-features-at-a-glance}

不确定有哪些功能可用？这里是主要功能的快速目录：

| 功能 | 作用 | 链接 |
| --- | --- | --- |
| **工具** | 智能体可以调用的内置工具（文件 I/O、搜索、Shell 等） | 工具 |
| **技能** | 可安装的插件包，用于添加新功能 | 技能 |
| **记忆** | 跨会话的持久化记忆 | 记忆 |
| **上下文文件** | 将文件和目录输入到对话中 | 上下文文件 |
| **MCP** | 通过模型上下文协议连接到外部工具服务器 | MCP |
| **定时任务** | 安排重复的智能体任务 | 定时任务 |
| **委托** | 生成子智能体进行并行工作 | 委托 |
| **代码执行** | 在沙盒环境中运行代码 | 代码执行 |
| **浏览器** | 网页浏览和抓取 | 浏览器 |
| **钩子** | 事件驱动的回调和中间件 | 钩子 |
| **批处理** | 批量处理多个输入 | 批处理 |
| **RL 训练** | 使用强化学习微调模型 | RL 训练 |
| **供应商路由** | 跨多个 LLM 供应商路由请求 | 供应商路由 |

## 接下来读什么

根据你当前的情况：

- • **刚安装完？** → 前往快速入门运行你的第一次对话。
- • **完成了快速入门？** → 阅读CLI 使用和配置来自定义你的设置。
- • **熟悉了基础知识？** → 探索工具、技能和记忆以解锁智能体的全部能力。
- • **为团队设置？** → 阅读安全和会话以了解访问控制和对话管理。
- • **准备开始构建？** → 跳转到开发者指南了解内部原理并开始贡献。
- • **想要实际例子？** → 查看指南部分获取真实项目和小技巧。

更多内容请见Hermes Agent中文站：

- • https://hermes-doc.aigc.green/
- • https://hermes-doc.aigc.green/getting-started/quickstart

继续滑动看下一个

Misskaopu

向上滑动看下一个