# Editing Workflow

## When to use this path

Use this workflow when the user provides a branded template, a past presentation that should be updated, or a reference deck whose visual language should be preserved.

## Standard sequence

1. Inspect the source deck with `extract_text.py` and `thumbnail.py`.
2. Map source content to existing slide layouts before editing anything.
3. Unpack the `.pptx` into XML files.
4. Make structural slide changes first.
5. Edit slide content second.
6. Clean the unpacked folder.
7. Repack the deck.
8. Render slides and run QA.

## Commands

```bash
python scripts/extract_text.py template.pptx
python scripts/thumbnail.py template.pptx
python scripts/office/unpack.py template.pptx unpacked/
python scripts/add_slide.py unpacked/ slide2.xml
python scripts/clean.py unpacked/
python scripts/office/pack.py unpacked/ output.pptx
```

## Structural edits first

Do these before you start replacing text:

- Delete slides you do not need
- Duplicate slides whose layout is useful
- Reorder slides
- Decide which layout each content section belongs to

Why: once content editing starts, layout churn becomes much riskier and easier to break.

## Content editing rules

- Replace placeholder content completely, not partially.
- If a template has more cards, icons, or headshots than your source, remove the extra visual group instead of leaving an empty shell.
- Keep multi-item content in separate paragraphs rather than concatenating everything into one long text run.
- Preserve XML namespaces and existing structure whenever possible.

## Slide operations

Slide order is controlled by `ppt/presentation.xml`.

- Reorder slides by moving `<p:sldId>` nodes.
- Delete slides by removing unused slide IDs and then running `clean.py`.
- Duplicate a slide with `add_slide.py` instead of manually copying files.

## Common failure modes

- Text becomes much longer than the template slot can handle.
- Placeholder labels remain in captions, notes, or small side text.
- Unused shapes stay behind after text is cleared.
- A layout built for four items is reused for three without deleting one card.
- The deck looks repetitive because the same safe layout was reused too often.

## Final check

After packing the edited deck:

1. Extract text and scan for stray placeholders.
2. Render slide images.
3. Check alignment, spacing, overflow, and contrast.
4. Fix and re-check.

