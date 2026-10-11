#!/usr/bin/env python3
"""Raster Element Deck mark, PWA icons, and iOS Add-to-Home-Screen splashes.

The in-app mark is drawn in lib/theme/app_brand.dart. Keep the tile inset and
the hydrogen cell in step with that painter.
"""

from __future__ import annotations

import json
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[1]
CANVAS = (8, 12, 20)
TILE = (15, 23, 42)
ACTION = (56, 189, 248)
MUTED = (148, 163, 184)
TEXT = (248, 250, 252)

SANS = ROOT / "assets" / "fonts" / "PlusJakartaSans.ttf"
MONO = ROOT / "assets" / "fonts" / "JetBrainsMono.ttf"

# (pixel width, pixel height, media query without orientation)
DEVICES = [
    (750, 1334, "(device-width: 375px) and (device-height: 667px) and (-webkit-device-pixel-ratio: 2)"),
    (1242, 2208, "(device-width: 414px) and (device-height: 736px) and (-webkit-device-pixel-ratio: 3)"),
    (1125, 2436, "(device-width: 375px) and (device-height: 812px) and (-webkit-device-pixel-ratio: 3)"),
    (828, 1792, "(device-width: 414px) and (device-height: 896px) and (-webkit-device-pixel-ratio: 2)"),
    (1242, 2688, "(device-width: 414px) and (device-height: 896px) and (-webkit-device-pixel-ratio: 3)"),
    (1170, 2532, "(device-width: 390px) and (device-height: 844px) and (-webkit-device-pixel-ratio: 3)"),
    (1284, 2778, "(device-width: 428px) and (device-height: 926px) and (-webkit-device-pixel-ratio: 3)"),
    (1179, 2556, "(device-width: 393px) and (device-height: 852px) and (-webkit-device-pixel-ratio: 3)"),
    (1290, 2796, "(device-width: 430px) and (device-height: 932px) and (-webkit-device-pixel-ratio: 3)"),
    (1206, 2622, "(device-width: 402px) and (device-height: 874px) and (-webkit-device-pixel-ratio: 3)"),
    (1320, 2868, "(device-width: 440px) and (device-height: 956px) and (-webkit-device-pixel-ratio: 3)"),
    (1488, 2266, "(device-width: 744px) and (device-height: 1133px) and (-webkit-device-pixel-ratio: 2)"),
    (1620, 2160, "(device-width: 810px) and (device-height: 1080px) and (-webkit-device-pixel-ratio: 2)"),
    (1640, 2360, "(device-width: 820px) and (device-height: 1180px) and (-webkit-device-pixel-ratio: 2)"),
    (1668, 2388, "(device-width: 834px) and (device-height: 1194px) and (-webkit-device-pixel-ratio: 2)"),
    (1668, 2420, "(device-width: 834px) and (device-height: 1210px) and (-webkit-device-pixel-ratio: 2)"),
    (2048, 2732, "(device-width: 1024px) and (device-height: 1366px) and (-webkit-device-pixel-ratio: 2)"),
]


def font(path: Path, size: int) -> ImageFont.FreeTypeFont | ImageFont.ImageFont:
    size = max(8, size)
    if path.exists():
        return ImageFont.truetype(str(path), size)
    return ImageFont.load_default()


def mark(size: int, inset_ratio: float = 0.16) -> Image.Image:
    image = Image.new("RGB", (size, size), CANVAS)
    draw = ImageDraw.Draw(image)
    inset = int(size * inset_ratio)
    box = [inset, inset, size - inset - 1, size - inset - 1]
    cell = box[2] - box[0]
    radius = max(4, int(cell * 0.18))
    width = max(2, size // 40)
    draw.rounded_rectangle(box, radius=radius, fill=TILE, outline=ACTION, width=width)

    z_font = font(MONO, int(cell * 0.16))
    z_box = draw.textbbox((0, 0), "1", font=z_font)
    draw.text(
        (box[0] + int(cell * 0.1), box[1] + int(cell * 0.08)),
        "1",
        font=z_font,
        fill=MUTED,
    )

    h_font = font(SANS, int(cell * 0.52))
    h_box = draw.textbbox((0, 0), "H", font=h_font)
    h_w = h_box[2] - h_box[0]
    h_h = h_box[3] - h_box[1]
    draw.text(
        (
            (box[0] + box[2] - h_w) / 2 - h_box[0],
            (box[1] + box[3] - h_h) / 2 - h_box[1] + cell * 0.04,
        ),
        "H",
        font=h_font,
        fill=ACTION,
    )
    del z_box
    return image


def splash(width: int, height: int) -> Image.Image:
    image = Image.new("RGB", (width, height), CANVAS)
    side = max(96, int(min(width, height) * 0.22))
    tile = mark(side)
    x = (width - side) // 2
    y = (height - side) // 2 - int(height * 0.04)
    image.paste(tile, (x, y))
    draw = ImageDraw.Draw(image)
    name_font = font(SANS, max(18, int(min(width, height) * 0.028)))
    eye_font = font(SANS, max(12, int(min(width, height) * 0.014)))
    name = "Element Deck"
    eye = "PERIODIC EXPLORER"
    name_box = draw.textbbox((0, 0), name, font=name_font)
    eye_box = draw.textbbox((0, 0), eye, font=eye_font)
    name_w = name_box[2] - name_box[0]
    eye_w = eye_box[2] - eye_box[0]
    text_y = y + side + int(side * 0.18)
    draw.text(((width - name_w) / 2, text_y), name, font=name_font, fill=TEXT)
    draw.text(
        ((width - eye_w) / 2, text_y + (name_box[3] - name_box[1]) + int(side * 0.08)),
        eye,
        font=eye_font,
        fill=MUTED,
    )
    return image


def save(image: Image.Image, path: Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    image.save(path, "PNG", optimize=True)


def startup_links() -> str:
    lines = []
    for width, height, media in DEVICES:
        for orientation, w, h in (("portrait", width, height), ("landscape", height, width)):
            href = f"splash/apple-splash-{w}x{h}.png"
            lines.append(
                f'  <link rel="apple-touch-startup-image" href="{href}" '
                f'media="{media} and (orientation: {orientation})">'
            )
    return "\n".join(lines)


def patch_index(links: str) -> None:
    path = ROOT / "web" / "index.html"
    text = path.read_text(encoding="utf-8")
    start = "<!-- apple-splash -->"
    end = "<!-- /apple-splash -->"
    block = f"{start}\n{links}\n  {end}"
    if start not in text or end not in text:
        raise SystemExit("index.html is missing apple-splash markers")
    pre, rest = text.split(start, 1)
    _, post = rest.split(end, 1)
    path.write_text(pre + block + post, encoding="utf-8")


def main() -> None:
    web_icons = ROOT / "web" / "icons"
    save(mark(192), web_icons / "Icon-192.png")
    save(mark(512), web_icons / "Icon-512.png")
    save(mark(192, 0.22), web_icons / "Icon-maskable-192.png")
    save(mark(512, 0.22), web_icons / "Icon-maskable-512.png")
    save(mark(180, 0.14), web_icons / "apple-touch-icon.png")
    save(mark(64, 0.1), ROOT / "web" / "favicon.png")

    splash_dir = ROOT / "web" / "splash"
    for width, height, _media in DEVICES:
        save(splash(width, height), splash_dir / f"apple-splash-{width}x{height}.png")
        save(splash(height, width), splash_dir / f"apple-splash-{height}x{width}.png")

    for folder, px in (
        ("mipmap-mdpi", 48),
        ("mipmap-hdpi", 72),
        ("mipmap-xhdpi", 96),
        ("mipmap-xxhdpi", 144),
        ("mipmap-xxxhdpi", 192),
    ):
        save(mark(px, 0.12), ROOT / "android" / "app" / "src" / "main" / "res" / folder / "ic_launcher.png")

    iconset = ROOT / "ios" / "Runner" / "Assets.xcassets" / "AppIcon.appiconset"
    spec = json.loads((iconset / "Contents.json").read_text(encoding="utf-8"))
    seen: set[str] = set()
    for item in spec["images"]:
        name = item.get("filename")
        if not name or name in seen:
            continue
        seen.add(name)
        logical = float(item["size"].split("x")[0])
        scale = int(item["scale"].replace("x", ""))
        save(mark(int(round(logical * scale)), 0.12), iconset / name)

    patch_index(startup_links())
    print("wrote brand icons and", len(DEVICES) * 2, "startup images")


if __name__ == "__main__":
    main()
