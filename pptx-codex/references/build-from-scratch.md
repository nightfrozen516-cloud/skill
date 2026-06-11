# Build From Scratch

## When to use this path

Use this workflow when the user has content or a source brief but no deck worth reusing.

## Recommended engine

Prefer PptxGenJS for from-scratch deck generation because it supports shapes, charts, images, text, and repeatable visual systems in plain JavaScript.

Official docs:

- [PptxGenJS home](https://gitbrent.github.io/PptxGenJS/)
- [PptxGenJS introduction](https://gitbrent.github.io/PptxGenJS/docs/introduction/)

## Setup

```bash
npm install pptxgenjs
```

## Bare minimum script

```javascript
import PptxGenJS from "pptxgenjs";

const pptx = new PptxGenJS();
pptx.layout = "LAYOUT_16X9";
pptx.author = "Codex";
pptx.subject = "Generated presentation";

const slide = pptx.addSlide();
slide.background = { color: "1E2761" };
slide.addText("Presentation Title", {
  x: 0.7,
  y: 0.8,
  w: 8.6,
  h: 0.8,
  fontFace: "Georgia",
  fontSize: 28,
  bold: true,
  color: "FFFFFF",
  margin: 0,
});

await pptx.writeFile({ fileName: "output.pptx" });
```

## Design process

Before coding, decide:

1. Slide count and rough outline
2. Palette
3. Type pairing
4. Two or three recurring layout patterns
5. Where charts, images, or icon rows belong

## Good default slide mix

- Title slide
- Problem or context slide
- Two or three evidence slides
- One solution or proposal slide
- Timeline or next steps slide
- Closing statement slide

## Implementation tips

- Use a different layout for different content types.
- Put numbers into metric cards rather than paragraphs.
- Use left-aligned body text for readability.
- When aligning text with nearby shapes, use `margin: 0` on the text box.
- Keep colors as six-character hex strings without `#` when working with PptxGenJS.

## QA after generation

Do not trust the first export.

1. Open or render the deck.
2. Check for text wrapping, overlap, and weak contrast.
3. Fix layout issues in code.
4. Re-export and verify again.

