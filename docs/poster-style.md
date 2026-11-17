# Poster style guide — A0 portrait

Measured from the reference poster *DAVE: how to use explainable AI to interpret
missense variants…* (ESHG 2025, P15.042.F), preview in
`reference/dave-eshg-poster-preview.png`. Implemented in `css/poster.css`, template in
`templates/poster/poster-a0.html`.

All sizes are in **pt** (1 pt = 0.353 mm) so they match the original PowerPoint/PDF.

## Page

| Item | Value |
|---|---|
| Format | A0 portrait, 841 × 1189 mm (2384 × 3370 pt), no bleed |
| Background | white |
| Side margin | 76 pt (~27 mm) for all body content |
| Column split | full-width intro, then two columns ≈ 39 % / 61 % (871 : 1356 pt), 40 pt gutter |

## Colour

| Token | Hex | Use |
|---|---|---|
| `--c-blue-900` | `#003EC0` | gradient start (left) |
| `--c-blue-300` | `#8AA9FF` | gradient end (right) |
| `--c-blue-600` | `#3B6EE1` | gradient midpoint, solid fallback |
| `--c-ink` | `#212121` | **all** text and outlines; never pure black |
| `--c-surface` | `#F2F2F2` | caption strips |
| `--c-pink` | `#FE0C57` | data emphasis (pathogenic series, +/- marks), zoom wedge at ~22 % |
| `--c-blue-accent` | `#007DFE` | second data series (benign) |
| `--c-red` | `#FF0000` | highlight frame and pointer arrows |
| `--c-green` | `#4EA72E` | check mark ✓ |

Data plots use the pink/blue pair; keep other colours out of charts.

## Type

One family: **Helvetica** (fallback stack Helvetica Neue → Arial → bundled Liberation Sans).
Titles and section headings are **regular weight**; bold is only for inline emphasis
(key terms, the headline number).

| Role | Size | Style |
|---|---|---|
| Poster title | 66 pt | regular, white, centred, 2 lines max |
| Section heading | 66 pt | regular, ink, centred **above** its panel |
| Intro text | 44 pt | justified |
| Body text | 40 pt | justified, line-height 1.2, no blank lines between paragraphs |
| Figure caption | 28–32 pt | italic; `Figure N:` bold italic; on `#F2F2F2` |
| Labels / sub-figure titles / authors | 28 pt | regular |
| Poster ID | 44 pt | white, top-left |
| Contact e-mails, affiliations | 18 pt | white |

## Header (0 – 312 pt)

- Horizontal gradient `#003EC0 → #8AA9FF`.
- White triangle at 29 % opacity in the top-left corner (423 × 290 pt).
- Left: poster ID (top) and corresponding-author e-mails marked `*` / `**` (bottom).
- Right: title centred, author line(s) underneath, left-aligned, superscript affiliation numbers; `*`/`**` mark the corresponding authors.
- Soft drop shadow below the band.

## Footer (last 267 pt)

Same gradient. Left: MOLGENIS logo (white circle mark + wordmark, ~200 pt high).
Centre-left: numbered affiliations, 18 pt white. Right: UMCG logo (white, ~92 pt high).

## Components

- **Panel** – white fill, 3 pt `#212121` outline, 32 pt corner radius, ~30/38 pt padding.
  Every text section is a heading + panel.
- **Intro bullets** – two columns; the second column starts right after the first
  (not at 50 %). Key words bold.
- **Sub-figure tile** – square-cornered 3 pt outline, title row with a 45 pt filled ink
  circle holding a white letter (A, B, C).
- **Highlight frame** – 6 pt pure red outline around the one figure the viewer should look
  at first. Optional pink translucent wedge from that frame to a detail region in a
  larger image, plus a red rectangle on the region and red arrows to zoomed views.
- **Callout label** – white box, 4.5 pt ink outline, 28 pt text, dashed leader line to the
  data point; pink bold `+`/`−` for direction of effect.
- **Free figure** – large renders sit directly on white with no border; overlay labels in
  white 40 pt.
- **QR block** – QR code with a 2–3 line bold 28 pt call to action beneath it.

## Content pattern

Introduction (problem → gap → "Here, we present the **Full Name (ACRONYM)**" → bullet
list of features) · Results (multi-panel figure + caption + short text with the headline
metric in bold) · worked example figure · Discussion (meaning → limitation → contrast →
future work). Figures are numbered in reading order of the text, not position.
