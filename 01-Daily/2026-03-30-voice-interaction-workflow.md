# 语音交互系统工作流

**创建时间**: 2026-03-30
**状态**: ✅ 已完成并验证

## 系统架构

```
用户语音 (Telegram .ogg)
    ↓
[FFmpeg] 转换为 WAV (16kHz, mono)
    ↓
[Whisper.cpp] 本地转录 (Metal GPU 加速)
    ↓
[Tars] 理解指令并执行
    ↓
[Edge-TTS] 生成语音回复 (晓晓声音)
    ↓
发送语音文件给用户
```

## 组件配置

### 1. STT (耳朵) - Whisper.cpp
- **安装**: `brew install whisper-cpp` (预编译 ARM64)
- **模型**: ggml-small.bin (465MB, 中文优化)
- **性能**: ~1秒转录3-4秒音频
- **加速**: Metal GPU (Apple M1)

### 2. TTS (嘴巴) - Edge-TTS
- **安装**: `pip3 install edge-tts`
- **声音**: zh-CN-XiaoxiaoNeural (晓晓)
- **速度**: 实时生成，无需等待

### 3. 转换工具
- **FFmpeg**: 系统自带，用于 .ogg → .wav

## 关键文件

```
~/.openclaw/workspace/skills/
├── whisper-cpp-stt/
│   ├── transcribe.py          # 转录脚本
│   └── SKILL.md               # 使用文档
├── edge-tts/
│   └── tts_output.py          # TTS脚本
└── voice-assistant/
    └── voice_loop.py          # 完整闭环
```

## 使用方法

### 手动转录
```bash
ffmpeg -i input.ogg -ar 16000 -ac 1 -c:a pcm_s16le output.wav
whisper-cli -m ~/.openclaw/whisper-cpp/models/ggml-small.bin -f output.wav -l zh
```

### 生成语音
```bash
python3 ~/.openclaw/workspace/skills/edge-tts/tts_output.py "要转换的文字" -o output.mp3
```

## 性能数据

| 环节 | 耗时 | 说明 |
|------|------|------|
| FFmpeg 转换 | ~0.1秒 | 几乎瞬时 |
| Whisper 转录 | ~1秒/3秒音频 | Metal GPU 加速 |
| Edge-TTS 生成 | ~0.5秒 | 实时生成 |
| **总延迟** | **~1.5秒** | 用户体验流畅 |

## 注意事项

1. **模型大小**: small (465MB) 适合 MacBook Air 16GB
2. **温度控制**: 长时间使用注意散热（无风扇设计）
3. **网络依赖**: Edge-TTS 需要联网（微软服务）
4. **中文优化**: small 模型对中文识别效果良好

## 后续优化

- [ ] 支持更多语音指令
- [ ] 集成到 Telegram Bot 自动处理
- [ ] 添加语音唤醒词
- [ ] 支持多轮语音对话
