#!/usr/bin/env bash
# Render an HTML poster to a print-ready PDF (and optional PNG preview)
# with headless Chrome/Chromium.
#
#   scripts/render-poster.sh templates/poster/poster-a0.html poster.pdf [preview.png]
#
# Needs: google-chrome / chromium on PATH. Preview needs poppler (pdftoppm).
set -euo pipefail

in="${1:?usage: render-poster.sh input.html output.pdf [preview.png]}"
out="${2:?usage: render-poster.sh input.html output.pdf [preview.png]}"
png="${3:-}"

chrome="$(command -v google-chrome || command -v chromium || command -v chromium-browser || true)"
[ -n "$chrome" ] || { echo "Chrome/Chromium not found" >&2; exit 1; }

abs_in="$(cd "$(dirname "$in")" && pwd)/$(basename "$in")"

"$chrome" --headless --disable-gpu --no-sandbox \
  --allow-file-access-from-files \
  --no-pdf-header-footer \
  --print-to-pdf="$out" \
  "file://$abs_in" 2>/dev/null

echo "PDF: $out"

if [ -n "$png" ]; then
  pdftoppm -r 40 -png -singlefile "$out" "${png%.png}"
  echo "PNG: $png"
fi
