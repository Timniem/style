#!/usr/bin/env python3
"""Bundle an HTML presentation into ONE self-contained file for sharing.

    python3 scripts/bundle-presentation.py templates/presentation/my-talk.html my-talk.html [--embed-fonts]

- local <link rel="stylesheet"> files are inlined;
- local <img src> files (the logos) become data: URIs;
- @font-face rules: with --embed-fonts the Liberation Sans files are inlined
  (~1.6 MB); without it the rules are dropped and the page falls back to the
  installed Helvetica/Arial (same metrics);
- Three.js keeps loading from the pinned CDN in the import map.

The result has no relative paths left, so it can be mailed, uploaded or
published as a single page.
"""
import base64, mimetypes, re, sys
from pathlib import Path


def data_uri(path: Path) -> str:
    mime = mimetypes.guess_type(path.name)[0] or "application/octet-stream"
    if path.suffix == ".ttf":
        mime = "font/ttf"
    return f"data:{mime};base64," + base64.b64encode(path.read_bytes()).decode()


def inline_css(css_path: Path, embed_fonts: bool) -> str:
    css = css_path.read_text(encoding="utf-8")

    def font_face(m: re.Match) -> str:
        if not embed_fonts:
            return ""
        return re.sub(r'url\("([^"]+)"\)',
                      lambda u: f'url("{data_uri((css_path.parent / u.group(1)).resolve())}")', m.group(0))

    return re.sub(r"@font-face\s*{[^}]*}", font_face, css)


def main() -> None:
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    if len(args) != 2:
        sys.exit(__doc__)
    src, dst = Path(args[0]).resolve(), Path(args[1])
    embed_fonts = "--embed-fonts" in sys.argv
    html = src.read_text(encoding="utf-8")

    def link(m: re.Match) -> str:
        href = m.group(1)
        if re.match(r"^[a-z]+:", href):          # remote stylesheet: keep
            return m.group(0)
        return "<style>\n" + inline_css((src.parent / href).resolve(), embed_fonts) + "\n</style>"

    html = re.sub(r'<link rel="stylesheet" href="([^"]+)">', link, html)

    def img(m: re.Match) -> str:
        url = m.group(2)
        if url.startswith("data:") or re.match(r"^[a-z]+:", url):
            return m.group(0)
        return f'{m.group(1)}"{data_uri((src.parent / url).resolve())}"'

    html = re.sub(r'(<img[^>]*?\ssrc=)"([^"]+)"', img, html)
    left = re.findall(r'(?:src|href)="(\.\./[^"]+)"', html)
    if left:
        print("warning: relative paths left:", *sorted(set(left)), file=sys.stderr)
    dst.write_text(html, encoding="utf-8")
    print(f"{dst}  ({dst.stat().st_size / 1024:.0f} KB)")


if __name__ == "__main__":
    main()
