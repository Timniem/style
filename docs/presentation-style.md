# Presentation style guide — 16:9 slides with 3D (Three.js)

Derived from the internal talk *RNA in diagnostics and research* (NGS_RNA, TAP and
MOLGENIS VIP), built on the poster style in `docs/poster-style.md`. Implemented in
`css/presentation.css`; template in `templates/presentation/presentation-16x9.html`;
preview in `reference/presentation-template-preview.png`.

Colours, fonts and the overall look are the poster's (`css/index.css`). This guide covers
what is different for slides: the canvas, the bands, 3D figures and, above all,
**motion**.

All sizes are **px on a fixed 1600 × 900 canvas** that the template scales to the window.

---

## 1 · Canvas and bands

| Item | Value |
|---|---|
| Canvas | 1600 × 900 px (16:9), white, scaled to fit; dark surround `#1b1e24` |
| Header band | 118 px, gradient `#003EC0 → #8AA9FF`, white triangle at 29 % (210 × 118) top-left, soft shadow |
| Slide number | top-left in the triangle, 22 px, two digits (`02`) |
| Slide title | 50 px, regular, white, **centred** in the band |
| Footer band | 74 px, same gradient; MOLGENIS logo left, ‹ page / total › centre, UMCG logo right |
| Body | between the bands; 64 px side margin for text columns, 30–40 px for 3D stages |

Rules:

- **No section labels** (no "Introduction / Output / Outlook" kicker under the number).
  The title says what the slide is about.
- **No interaction hints** on slides ("drag to rotate"). Dragging still works.
- Every slide except the title has the same header and footer.

## 2 · Title slide

| Item | Value |
|---|---|
| Header | 300 px tall, triangle 420 × 290 |
| Title | 64 px regular, **centred across the full width** (not beside the triangle) |
| Subtitle | 40 px under the title; a one-line takeaway (21 px) below it |
| Links | repository URLs, 14 px, bottom-left of the band |
| Body | Introduction panel left (≈ 640 px), 3D key visual right |

- **Internal talks: no presenter name, no affiliation.** External talks: author line
  with superscript numbers under the title, numbered affiliations in the footer centre.
- No "MOLGENIS" text in the corner: the footer logo is enough.

## 3 · Text

Same rules as the poster, at slide scale:

| Role | Size |
|---|---|
| Section heading above a panel | 30–34 px, regular, centred |
| Panel text | 18–23 px, justified, line-height 1.3 |
| Caption | 16.5–17 px italic on `#F2F2F2`, `Figure N:` bold italic |
| 3D labels | canvas text, ≈ 0.3 world units per line |

- Panels: 3 px ink outline, 28 px radius, heading centred **above** the panel.
- Bold for key terms only; **pink** for the finding or the new thing; `.k` chips for
  file names, columns and parameters (`SJ.out.tab`, `group`).
- One message per slide; cut words before shrinking type.

## 4 · Colour in figures

| Colour | Meaning in 3D figures and diagrams |
|---|---|
| `#003EC0 → #8AA9FF` | pipeline steps (dark = early/core, light = reports/outputs) |
| `#212121` ink | inputs (FASTQ, BAM, samplesheet) and expert/manual end points |
| `#FE0C57` pink | the finding, the new path, research hand-offs |
| `#007DFE` blue | second data series (e.g. reference allele, "down") |
| `#C9CFDA` grey | neutral data (not significant, unresolved); never a series |
| `#FF0000` red | highlight frame around the one thing to look at |
| white box, **dashed** outline | optional, new or proposed step |

Pink and blue stay the only data colours, as on the poster.

## 5 · 3D figures (Three.js)

- One WebGL renderer, moved into the active slide's `.stage`; each scene is built on first
  visit and cached. Three.js is **pinned** (`three@0.160.0`) and loaded from jsDelivr.
- Text **on a box face** is a flat plane (`label(…, { plane: true })`); camera-facing
  sprites clip into the box when the view is rotated. Free labels and callouts are sprites.
- Callouts: white box, 6 px ink border; pink border when they point at the new thing.
- Orbit controls: drag to rotate only (no zoom, no pan), azimuth limited (≈ ±60°) so the
  figure can't be turned into an unreadable angle.
- Frame each scene so nothing is clipped at the stage edges; check with the render
  script, not by eye in one browser.
- **Biology must be right**: the DNA/RNA helix is **right-handed**; genes, exons and
  junctions in the order they occur.
- Illustrations are labelled as such in the caption ("(illustration)", "(schematic)",
  "(simplified)"); placeholder genes and values are named `GENE_A…` and flagged.
- Only show an example that is **visible**: a near-zero bar ("loss of expression") is
  invisible in a 3D bar chart — pick a high outlier or drop the example.

## 6 · Motion — the main rule set

Motion has to carry meaning. If it doesn't explain something, it goes.

1. **Runs once per visit.** Every animation plays when the slide opens and ends in its
   final state. Returning to the slide replays it. Nothing loops.
2. **No ambient motion**: no particles or data points flowing along lines, no floating or
   bobbing objects, no drifting background dots, no continuous auto-rotation.
3. **Entry motion is short**: the title helix turns ~50° in 1.5 s, then stands still.
   Bars grow from zero in ~1.2 s, staggered a little.
4. **Flows are shown with one wave.** A single pulse travels along the connections from
   inputs to outputs, briefly thickening each line, then everything is at rest.
   - Subtle: swell ≤ 0.05 world units, opacity ≤ 0.55, speed 1.5 edges/s.
   - Continuous, not edge-by-edge: the pulse moves smoothly along each line.
   - In **dependency order** (longest-path depth): a step only starts when **all** of its
     inputs have arrived. Example: VIP *classify* waits for the RNA evidence before the
     wave continues to *inheritance* and the report.
   - Pink lines pulse pink, ink lines pulse ink.
5. **Before/after stories run after the wave**: a result that changes because of new
   input (e.g. a variant ranking re-ordered by RNA evidence) starts when the wave reaches
   it — first the old state, then the new evidence fades in, then rows move to their new
   place (≈ 2 s), then a ▲/▼ badge per row and a red frame on the new top item. It then
   **holds**.

The template implements 1–4 (`addWave`, `depthsOf`, `updateWaves`, `ease`); the
ranking pattern (5) is described here and in the reference deck.

## 7 · Diagrams of pipelines

- Build them **from the source**: the workflow file (`workflow_*.csv`, `main.nf`), not
  the README. Name the source and the version/PR in the caption
  ("…following PR #86 (simplified)").
- Left → right in dependency order; branches fan out vertically; lanes labelled in
  grey (`QC`, `identity`).
- Where a path ends in human work, end it in an ink box ("Variant review") with a grey
  **"… path ends here"** tag.
- Show hand-offs between pipelines explicitly (pink box, e.g. `TAPfiles/ → TAP`), and
  what crosses (gene counts, `SJ.out.tab`, MAE, TIN).
- Connections that don't exist yet are marked **concept** in the caption.
- A connection between two lanes stays thin (≈ 0.03 units); don't add links that the
  real data flow doesn't have.

## 8 · Delivery

- One self-contained HTML file: `scripts/bundle-presentation.py` inlines the CSS and the
  logos (data URIs); `--embed-fonts` adds Liberation Sans (+ ~1.6 MB). Three.js stays on
  the CDN, so 3D needs a network connection; text and navigation work offline.
- Navigation: → / space / Page Down next, ← back, Home/End, **F** fullscreen, swipe on
  touch; `#slide-N` in the URL opens a slide directly.
- Before sharing: `scripts/render-slides.sh deck.html out/` and look at every PNG —
  clipped labels, overlapping text, scenes out of frame.
