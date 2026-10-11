#!/usr/bin/env python3
"""Resize store screenshots into Play Console image folders.

Reads listing/screenshot-map.json. Missing source files are skipped with a warning
so a text-only listing upload can still run.
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

PLAYSTORE = Path(__file__).resolve().parent.parent
ROOT = PLAYSTORE.parent.parent.parent
MAP_PATH = PLAYSTORE / "listing" / "screenshot-map.json"
META = PLAYSTORE / "listing" / "metadata" / "android"


def cover_resize(im, tw: int, th: int):
    from PIL import Image

    src_w, src_h = im.size
    src_aspect = src_w / src_h
    dst_aspect = tw / th
    if src_aspect > dst_aspect:
        new_w = max(1, int(round(src_h * dst_aspect)))
        left = (src_w - new_w) // 2
        im = im.crop((left, 0, left + new_w, src_h))
    else:
        new_h = max(1, int(round(src_w / dst_aspect)))
        top = (src_h - new_h) // 2
        im = im.crop((0, top, src_w, top + new_h))
    return im.resize((tw, th), Image.Resampling.LANCZOS).convert("RGB")


def save_png(im, dest: Path) -> None:
    dest.parent.mkdir(parents=True, exist_ok=True)
    im.save(dest, format="PNG", optimize=True)


def main() -> int:
    try:
        from PIL import Image
    except ImportError:
        print("Pillow is required: pip install Pillow", file=sys.stderr)
        return 1

    spec = json.loads(MAP_PATH.read_text(encoding="utf-8"))
    src_dir = ROOT / spec["sourceDir"]
    phone = spec["phoneTarget"]
    tablet = spec["tabletTarget"]
    if not src_dir.is_dir():
        print(f"[WARN] No screenshots at {src_dir}")
        print("Drop PNGs there (see listing/screenshot-map.json) and re-run.")
        return 0

    wrote = 0
    for locale, shots in spec["locales"].items():
        images = META / locale / "images"
        groups = (
            ("phone", shots.get("phone") or [], images / "phoneScreenshots", phone),
            ("tablet", shots.get("tablet") or [], images / "sevenInchScreenshots", tablet),
            ("tablet", shots.get("tablet") or [], images / "tenInchScreenshots", tablet),
        )
        for _label, names, dest_dir, size in groups:
            n = 0
            if dest_dir.exists():
                for old in dest_dir.glob("*.png"):
                    old.unlink()
            for name in names:
                src = src_dir / name
                if not src.is_file():
                    print(f"[WARN] missing {src.relative_to(ROOT)}")
                    continue
                n += 1
                with Image.open(src) as im:
                    save_png(cover_resize(im, size["width"], size["height"]), dest_dir / f"{n:02d}.png")
                wrote += 1

        for key, dest_name in (("icon", "icon.png"), ("featureGraphic", "featureGraphic.png")):
            raw = spec.get(key)
            if not raw:
                continue
            src = ROOT / raw
            if not src.is_file():
                print(f"[WARN] missing {key}: {src.relative_to(ROOT)}")
                continue
            with Image.open(src) as im:
                save_png(im.convert("RGB"), images / dest_name)
            wrote += 1

    print(f"[OK] wrote {wrote} listing image(s)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
