# style

Style folder and guides for presentations, applications and documents — so posters,
slides and pages can be reproduced consistently by hand or by an AI assistant.

The first template is an **A0 portrait conference poster**, derived from the DAVE poster
(ESHG 2025).

![Poster template preview](reference/poster-a0-template-preview.png)

## Layout

```
/css
    index.css          shared design tokens (colours, fonts, strokes, radius)
    poster.css         A0 poster layout and components
/fonts
    /liberation-sans   Helvetica-metric fallback font (SIL OFL 1.1, see OFL.txt)
/assets
    /logos             MOLGENIS and UMCG logos (white, transparent PNG)
/templates
    /poster
        poster-a0.html A0 poster template with placeholders
/scripts
    render-poster.sh   HTML -> print-ready PDF (+ PNG preview) via headless Chrome
/docs
    poster-style.md    measured style guide: sizes, colours, type, components
/prompts
    prompts.md         copy-paste prompts for reproducing the style with AI
/reference
    *.png              previews of the source poster and the rendered template
```

## Make a poster

1. Copy `templates/poster/poster-a0.html` (keep it inside `templates/poster/` or fix the
   relative `../../css` and `../../assets` paths).
2. Replace the `[bracketed]` text and swap each `.placeholder` box for an `<img>` or `<svg>`.
3. Render:

   ```bash
   scripts/render-poster.sh templates/poster/my-poster.html my-poster.pdf my-poster.png
   ```

   Requires Google Chrome or Chromium; the PNG preview needs `pdftoppm` (poppler).
4. Check the preview: text must not overflow panels or the page.

Fonts: real Helvetica/Arial is used when installed, otherwise the bundled Liberation Sans
(same metrics), so line breaks stay the same across machines.

## Adding a new style

Use the second prompt in `prompts/prompts.md`: measure the reference, add tokens to
`css/index.css` only when they are new, then add a stylesheet, template, guide and prompt.
