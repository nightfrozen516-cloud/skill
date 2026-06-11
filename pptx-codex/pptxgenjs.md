# PptxGenJS 使用指南

## 何时使用

当没有可复用模板，或者你需要完全掌控整套 deck 的结构、配色和视觉系统时，使用 PptxGenJS 从零生成。

官方文档：

- [PptxGenJS 首页](https://gitbrent.github.io/PptxGenJS/)
- [Introduction](https://gitbrent.github.io/PptxGenJS/docs/introduction/)

## 基础结构

```javascript
const PptxGenJS = require("pptxgenjs");

const pptx = new PptxGenJS();
pptx.layout = "LAYOUT_16x9";
pptx.author = "Codex";

const slide = pptx.addSlide();
slide.addText("Hello", {
  x: 0.5,
  y: 0.5,
  w: 8,
  h: 0.8,
  fontSize: 28,
  bold: true,
  color: "1E2761",
});

pptx.writeFile({ fileName: "output.pptx" });
```

## 常用能力

### 文本

- `slide.addText(...)`
- 使用 `margin: 0` 对齐文本与形状边缘
- 使用 rich text 数组表达不同粗细、颜色或换行

### 列表

- 使用 `bullet: true`
- 不要手工写 Unicode bullet 字符

### 形状

- `slide.addShape(...)`
- 常用：`RECTANGLE`、`LINE`、`OVAL`
- 使用卡片、左侧强调条、对比框、时间线节点，而不是只放文字

### 图片

- `slide.addImage({ path, x, y, w, h })`
- 用于半出血图片、示意图、图标

### 图表

- `slide.addChart(...)`
- 自定义颜色而不是默认配色
- 单系列时通常隐藏 legend

## 设计建议

- 封面和结尾页可使用深色背景
- 正文页保持浅底深字，提高可读性
- 每页至少有一个视觉锚点
- 不要整套 deck 重复同一个布局

## 常见坑

- 颜色不要带 `#`

```javascript
color: "FF0000" // 对
color: "#FF0000" // 错
```

- 不要用 8 位颜色编码透明度
- 不要把所有列表项写进一段长文本
- 不要复用会被库内部修改的同一个配置对象

## 推荐开发流程

1. 先定页结构
2. 再定配色和字体
3. 写共用组件函数，如 title bar、metric card、info card
4. 生成 deck
5. 导出 slide 图片
6. QA 后再修

