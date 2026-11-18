#!/usr/bin/env bash
# Render every slide of an HTML presentation to PNG (1600 x 900) for review,
# with headless Chrome/Chromium. 3D scenes are rendered in software (SwiftShader).
#
#   scripts/render-slides.sh templates/presentation/presentation-16x9.html out-dir [wait-ms]
#
# Each slide is opened as file.html#slide-N and captured after wait-ms
# (default 6000, enough for the one-off entry animations to finish).
# Needs: google-chrome / chromium on PATH.
set -euo pipefail

in="${1:?usage: render-slides.sh input.html out-dir [wait-ms]}"
out="${2:?usage: render-slides.sh input.html out-dir [wait-ms]}"
wait_ms="${3:-6000}"

chrome="$(command -v google-chrome || command -v chromium || command -v chromium-browser || true)"
[ -n "$chrome" ] || { echo "Chrome/Chromium not found" >&2; exit 1; }

abs_in="$(cd "$(dirname "$in")" && pwd)/$(basename "$in")"
mkdir -p "$out"
n="$(grep -o '<section class="slide' "$abs_in" | wc -l | tr -d ' ')"
[ "$n" -gt 0 ] || { echo "no <section class=\"slide\"> found in $in" >&2; exit 1; }

for i in $(seq 1 "$n"); do
  png="$out/slide-$(printf '%02d' "$i").png"
  "$chrome" --headless --no-sandbox --hide-scrollbars \
    --use-gl=angle --use-angle=swiftshader --enable-unsafe-swiftshader --ignore-gpu-blocklist \
    --allow-file-access-from-files \
    --window-size=1600,900 --virtual-time-budget="$wait_ms" \
    --screenshot="$png" "file://$abs_in#slide-$i" 2>/dev/null
  echo "PNG: $png"
done
