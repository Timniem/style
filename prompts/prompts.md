# Prompts

Copy-paste prompts for reproducing this style with an AI assistant. Attach or point to this
repository (at least `css/`, `assets/`, `templates/` and `docs/poster-style.md`).

---

## Poster (A0 portrait)

```
Make a conference poster in our house style using the `style` repository.

Start from templates/poster/poster-a0.html and keep css/index.css and css/poster.css
unchanged; follow docs/poster-style.md. Only edit the HTML content.

Rules:
- A0 portrait (841 x 1189 mm). Blue gradient header and footer (#003EC0 -> #8AA9FF),
  translucent white triangle top-left, white body.
- Helvetica only. Title and section headings in regular weight; bold only for key terms
  and the headline number. Text colour #212121.
- Header: poster ID and corresponding-author e-mails on the left; title (max 2 lines)
  and authors with superscript affiliation numbers on the right.
- Body: full-width Introduction panel, then a left column (~39 %) and right column.
  Section headings centred above rounded 3 pt outlined panels. Body text justified.
- Figures: captions on a #F2F2F2 strip, italic, "Figure N:" bold italic. Multi-panel
  figures use outlined tiles with a dark circular A/B/C badge. One key figure gets a
  6 pt red frame. Data colours: pink #FE0C57 and blue #007DFE only.
- Footer: MOLGENIS logo left, numbered affiliations (18 pt white) centre, UMCG logo right.
- Render with scripts/render-poster.sh and check the PNG preview: nothing may overflow
  the page or the panels.

Content:
<title>, <poster ID>, <authors + affiliations>, <corresponding e-mails>,
<introduction>, <results text>, <discussion>, <figures with captions>, <QR link>
```

---

## Extracting the style from a new reference

```
Here is a reference document [attach PDF]. Add its style to the `style` repository:
measure page size, margins, colours (sample pixels), fonts and sizes (from the PDF text
layer), and recurring components. Put tokens in css/index.css only if they differ from the
existing ones, add a component stylesheet under css/, a template under templates/, a guide
under docs/, and a prompt in this file. Render the template and compare it side by side
with the reference before finishing.
```
