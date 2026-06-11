---
name: pptx-codex
description: 创建、编辑、读取和处理 PowerPoint 演示文稿。只要任务涉及 slides、deck、presentation、答辩 PPT、汇报 PPT、模板、speaker notes，或任何 .pptx 文件作为输入或输出，就应触发此技能。适用于三类主要工作流：读取和抽取现有 .pptx 文本，解包并编辑模板演示文稿，以及使用 PptxGenJS 从零创建 deck；同时包含设计指导、图片渲染与强制 QA 流程。该技能是面向 Codex 的版本，保留与参考 pptx skill 接近的能力边界，但在多代理审查部分遵循 Codex 的使用约束。
---

# PPTX 技能（Codex版）

## 快速参考

| 任务 | 指南 |
| --- | --- |
| 阅读/分析内容 | `python scripts/extract_text.py presentation.pptx` |
| 编辑或基于模板创建 | 阅读 [editing.md](editing.md) |
| 从零创建 | 阅读 [pptxgenjs.md](pptxgenjs.md) |

---

## 读取内容

```bash
# 文本提取
python scripts/extract_text.py presentation.pptx

# 可视化缩略总览
python scripts/thumbnail.py presentation.pptx

# 原始 XML
python scripts/office/unpack.py presentation.pptx unpacked/
```

如果本地已安装 `markitdown[pptx]`，也可以使用：

```bash
python -m markitdown presentation.pptx
```

---

## 编辑工作流

完整说明见 [editing.md](editing.md)。

1. 先用 `thumbnail.py` 分析模板布局。
2. 解包 PPTX。
3. 先完成 slide 结构操作，再编辑内容。
4. 清理无用关系和孤儿文件。
5. 重新打包并执行 QA。

---

## 从零创建

完整说明见 [pptxgenjs.md](pptxgenjs.md)。

当没有合适模板或参考 deck 时，使用 PptxGenJS 从零创建。

---

## 设计思路

不要做无聊的 PPT。白底加普通 bullet 的页面不适合答辩、汇报或路演。每一页都应至少有一个明确的视觉锚点：图片、图表、图标、数字卡片、时间线、流程图、对比结构，或显著的版式层次。

### 开始前

- 选择一个与内容相关的主色，而不是默认蓝色。
- 让一个颜色占主导地位，辅助色只做支撑。
- 明确决定是“深色封面 + 浅色正文”的夹心结构，还是整套深色方案。
- 为整套 deck 选定一个持续重复的视觉母题，例如：左侧强调条、圆形图标底、信息卡片、半出血图片区等。

### 配色方案

| 主题 | 主色 | 辅色 | 强调色 |
| --- | --- | --- | --- |
| 午夜行政风 | `1E2761` | `CADCFC` | `FFFFFF` |
| 森林与苔藓 | `2C5F2D` | `97BC62` | `F5F5F5` |
| 珊瑚能量 | `F96167` | `F9E795` | `2F3C7E` |
| 暖陶土 | `B85042` | `E7E8D1` | `A7BEAE` |
| 海洋渐层 | `065A82` | `1C7293` | `21295C` |
| 木炭极简 | `36454F` | `F2F2F2` | `212121` |
| 青柠信任感 | `028090` | `00A896` | `02C39A` |
| 莓果奶油 | `6D2E46` | `A26769` | `ECE2D0` |
| 鼠尾草宁静 | `84B59F` | `69A297` | `50808E` |
| 樱桃强对比 | `990011` | `FCF6F5` | `2F3C7E` |

### 每页建议

- 双栏结构：左文右图，或左图右文
- 图标 + 文本行
- 2x2 / 2x3 卡片网格
- 半出血图片 + 文字覆盖
- 大数字指标页
- 对比页
- 时间线 / 流程页

### 字体

不要默认 Arial。选一个有性格的标题字体，再配一个稳定的正文字体。

| 标题字体 | 正文字体 |
| --- | --- |
| Georgia | Calibri |
| Arial Black | Arial |
| Calibri | Calibri Light |
| Cambria | Calibri |
| Trebuchet MS | Calibri |
| Impact | Arial |
| Palatino | Garamond |
| Consolas | Calibri |

| 元素 | 建议字号 |
| --- | --- |
| 幻灯片标题 | 36-44pt 粗体 |
| 分区标题 | 20-24pt 粗体 |
| 正文 | 14-16pt |
| 注释/来源 | 10-12pt |

### 间距

- 边距不小于 `0.5"`
- 内容块之间间距 `0.3-0.5"`
- 不要把页面每一寸都塞满

### 常见错误

- 不要整套重复同一种布局
- 不要把大段正文居中
- 不要让标题和正文尺寸太接近
- 不要默认蓝白配色
- 不要在所有标题下都加装饰线
- 不要做纯文字页
- 不要忽略文本框内边距
- 不要让低对比文本或图标出现在背景上

---

## QA（必须）

默认假设第一页导出一定有问题。QA 不是确认流程，而是查错流程。

### 内容 QA

```bash
python scripts/extract_text.py output.pptx
python scripts/check_placeholders.py output.pptx
```

如果本地已安装 `markitdown[pptx]`，也可额外执行：

```bash
python -m markitdown output.pptx
```

重点检查：

- 内容是否缺失
- 顺序是否错误
- 是否有 typo
- 是否残留 placeholder 文本

### 视觉 QA

先把幻灯片导出成单页图片，再逐页检查：

- 是否有元素重叠
- 是否有文本溢出或裁切
- 是否有卡片间距过小
- 是否有左右不对齐
- 是否有页边距不足
- 是否有低对比文字/图标
- 是否有明显空白失衡

在 Codex 中：

- 如果用户明确允许多代理/子代理，可以让独立代理做第二轮视觉审查。
- 如果没有明确授权，则至少执行两轮人工审查：第一次发现问题，修复后再渲染复查。

### 验证循环

1. 生成 slides
2. 导出图片
3. 列出问题
4. 修复问题
5. 重新检查受影响页面
6. 直到一轮完整检查不再发现新问题

---

## 转换为图片

可以使用以下命令链：

```bash
python scripts/office/soffice.py --headless --convert-to pdf output.pptx
python scripts/office/render.py output.pptx rendered/
```

或者直接：

```bash
python scripts/thumbnail.py output.pptx
```

---

## 依赖

- `pip install "markitdown[pptx]"`：可选，文本抽取
- `pip install Pillow`：缩略图拼板
- `pip install PyMuPDF`：PDF 栅格化
- `npm install pptxgenjs`：从零创建 deck
- LibreOffice `soffice`：PDF 转换
- Microsoft PowerPoint（Windows，可选）：高保真导出和 PDF 输出

