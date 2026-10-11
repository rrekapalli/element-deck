#!/usr/bin/env python3
"""Raster Element Deck mark, PWA icons, and iOS Add-to-Home-Screen splashes.

The in-app mark is drawn in lib/theme/app_brand.dart. Keep the glass electron
tile in step with that painter: transparent canvas, frosted plate, capital E,
a 1px dotted orbit, and one electron.
"""

from __future__ import annotations

import json
import math
import random
from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter, ImageFont

ROOT = Path(__file__).resolve().parents[1]
CANVAS = (8, 12, 20)
ACTION = (56, 189, 248, 255)
GOLD = (228, 184, 74, 255)
INK = (11, 27, 51, 255)
MUTED = (148, 163, 184)
TEXT = (248, 250, 252)

SANS = ROOT / "assets" / "fonts" / "PlusJakartaSans.ttf"

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


def _plate(size: int, inset_ratio: float) -> tuple[list[int], int, int]:
    inset = max(0, int(round(size * inset_ratio)))
    box = [inset, inset, size - inset - 1, size - inset - 1]
    cell = box[2] - box[0]
    radius = max(1, int(cell * 0.22))
    return box, cell, radius


def _orbit_dots(
    cx: float,
    cy: float,
    rx: float,
    ry: float,
    tilt: float,
    gap: float,
) -> list[tuple[float, float]]:
    samples = max(240, int((rx + ry) * 8))
    points: list[tuple[float, float]] = []
    traveled = gap
    previous: tuple[float, float] | None = None
    for i in range(samples + 1):
        angle = i * math.tau / samples
        x = rx * math.cos(angle)
        y = ry * math.sin(angle)
        rotated = (
            cx + x * math.cos(tilt) - y * math.sin(tilt),
            cy + x * math.sin(tilt) + y * math.cos(tilt),
        )
        if previous is not None:
            traveled += math.hypot(rotated[0] - previous[0], rotated[1] - previous[1])
            if traveled >= gap:
                points.append(rotated)
                traveled = 0.0
        previous = rotated
    return points


def _electron(cx: float, cy: float, rx: float, ry: float, tilt: float) -> tuple[float, float]:
    # Upper-right of the ellipse, on the orbit, clear of the top highlight.
    angle = -0.55
    x = rx * math.cos(angle)
    y = ry * math.sin(angle)
    return (
        cx + x * math.cos(tilt) - y * math.sin(tilt),
        cy + x * math.sin(tilt) + y * math.cos(tilt),
    )


def mark(size: int, inset_ratio: float = 0.08) -> Image.Image:
    """Transparent frosted-glass tile. The orbit is a 1px dotted line."""
    image = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    box, cell, radius = _plate(size, inset_ratio)
    mask = Image.new("L", (size, size), 0)
    ImageDraw.Draw(mask).rounded_rectangle(box, radius=radius, fill=255)

    column = Image.new("RGBA", (1, size))
    column_px = column.load()
    assert column_px is not None
    for y in range(size):
        t = y / max(1, size - 1)
        column_px[0, y] = (
            int(248 * (1 - t) + 210 * t),
            int(252 * (1 - t) + 228 * t),
            int(255 * (1 - t) + 242 * t),
            int(158 * (1 - t) + 86 * t),
        )
    plate = Image.composite(column.resize((size, size)), image, mask)

    sheen = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    hw = cell * 0.78
    hh = cell * 0.34
    hx = (box[0] + box[2]) / 2 - hw / 2
    hy = box[1] - hh * 0.35
    ImageDraw.Draw(sheen).ellipse([hx, hy, hx + hw, hy + hh], fill=(255, 255, 255, 48))
    sheen = sheen.filter(ImageFilter.GaussianBlur(radius=max(1, size // 64)))
    plate = Image.alpha_composite(
        plate,
        Image.composite(sheen, Image.new("RGBA", (size, size), (0, 0, 0, 0)), mask),
    )

    if cell >= 24:
        rng = random.Random(7)
        grain = Image.new("RGBA", (size, size), (0, 0, 0, 0))
        grain_px = grain.load()
        assert grain_px is not None
        for _ in range(max(1, (cell * cell) // 70)):
            x = rng.randint(box[0], box[2])
            y = rng.randint(box[1], box[3])
            grain_px[x, y] = (255, 255, 255, rng.randint(8, 22))
        plate = Image.alpha_composite(
            plate,
            Image.composite(grain, Image.new("RGBA", (size, size), (0, 0, 0, 0)), mask),
        )

    draw = ImageDraw.Draw(plate)
    draw.rounded_rectangle(box, radius=radius, outline=(255, 255, 255, 210), width=1)

    cx = (box[0] + box[2]) / 2
    cy = (box[1] + box[3]) / 2
    rx = cell * 0.34
    ry = cell * 0.21
    tilt = -0.42
    electron = _electron(cx, cy, rx, ry, tilt)
    electron_r = max(1.6, cell * 0.026)
    gap = 2.0 if cell < 40 else 3.0
    pixels = plate.load()
    assert pixels is not None
    for x, y in _orbit_dots(cx, cy, rx, ry, tilt, gap):
        if math.hypot(x - electron[0], y - electron[1]) < electron_r + 1.5:
            continue
        ix, iy = int(round(x)), int(round(y))
        if 0 <= ix < size and 0 <= iy < size:
            pixels[ix, iy] = ACTION

    symbol = "E"
    symbol_font = font(SANS, int(cell * 0.50))
    bounds = draw.textbbox((0, 0), symbol, font=symbol_font)
    draw.text(
        (
            (box[0] + box[2] - (bounds[2] - bounds[0])) / 2 - bounds[0],
            (box[1] + box[3] - (bounds[3] - bounds[1])) / 2 - bounds[1],
        ),
        symbol,
        font=symbol_font,
        fill=INK,
    )
    draw.ellipse(
        [
            electron[0] - electron_r,
            electron[1] - electron_r,
            electron[0] + electron_r,
            electron[1] + electron_r,
        ],
        fill=GOLD,
    )
    return plate


def splash(width: int, height: int) -> Image.Image:
    image = Image.new("RGB", (width, height), CANVAS)
    side = max(96, int(min(width, height) * 0.22))
    tile = mark(side)
    x = (width - side) // 2
    y = (height - side) // 2 - int(height * 0.04)
    image.paste(tile, (x, y), tile)
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


def _fmt(value: float) -> str:
    return f"{value:.2f}"


def splash_mark_svg(size: float = 104) -> str:
    """Inline mark for the HTML splash. Same layout as mark() and AppMark."""
    inset = size * 0.08
    cell = size - inset * 2
    radius = cell * 0.22
    center = size / 2
    rx = cell * 0.34
    ry = cell * 0.21
    tilt = math.degrees(-0.42)
    # Local ellipse space; the group rotate applies the orbit tilt once.
    ex = rx * math.cos(-0.55)
    ey = ry * math.sin(-0.55)
    electron_r = max(1.6, cell * 0.026)
    hw = cell * 0.78
    hh = cell * 0.34
    return f"""    <svg width="{_fmt(size)}" height="{_fmt(size)}" viewBox="0 0 {_fmt(size)} {_fmt(size)}" aria-hidden="true">
      <defs>
        <clipPath id="deck-glass">
          <rect x="{_fmt(inset)}" y="{_fmt(inset)}" width="{_fmt(cell)}" height="{_fmt(cell)}" rx="{_fmt(radius)}"/>
        </clipPath>
        <linearGradient id="deck-frost" x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stop-color="#F8FCFF" stop-opacity="0.62"/>
          <stop offset="1" stop-color="#D2E4F2" stop-opacity="0.34"/>
        </linearGradient>
      </defs>
      <g clip-path="url(#deck-glass)">
        <rect x="{_fmt(inset)}" y="{_fmt(inset)}" width="{_fmt(cell)}" height="{_fmt(cell)}" fill="url(#deck-frost)"/>
        <ellipse cx="{_fmt(center)}" cy="{_fmt(inset + hh * 0.15)}" rx="{_fmt(hw / 2)}" ry="{_fmt(hh / 2)}" fill="#FFFFFF" fill-opacity="0.19"/>
      </g>
      <rect x="{_fmt(inset)}" y="{_fmt(inset)}" width="{_fmt(cell)}" height="{_fmt(cell)}" rx="{_fmt(radius)}" fill="none" stroke="#FFFFFF" stroke-opacity="0.82" stroke-width="1"/>
      <g transform="translate({_fmt(center)} {_fmt(center)}) rotate({_fmt(tilt)})">
        <ellipse cx="0" cy="0" rx="{_fmt(rx)}" ry="{_fmt(ry)}" fill="none" stroke="#38BDF8" stroke-width="1" stroke-dasharray="1 2"/>
      </g>
      <text x="{_fmt(center)}" y="{_fmt(center)}" text-anchor="middle" dominant-baseline="central" fill="#0B1B33" font-size="{_fmt(cell * 0.5)}" font-weight="400" font-family="-apple-system, BlinkMacSystemFont, Segoe UI, sans-serif">E</text>
      <g transform="translate({_fmt(center)} {_fmt(center)}) rotate({_fmt(tilt)})">
        <circle cx="{_fmt(ex)}" cy="{_fmt(ey)}" r="{_fmt(electron_r)}" fill="#E4B84A"/>
      </g>
    </svg>"""


def _replace_marked(text: str, start: str, end: str, block: str, label: str) -> str:
    if start not in text or end not in text:
        raise SystemExit(f"index.html is missing {label} markers")
    pre, rest = text.split(start, 1)
    _, post = rest.split(end, 1)
    return pre + block + post


def patch_index(links: str) -> None:
    path = ROOT / "web" / "index.html"
    text = path.read_text(encoding="utf-8")
    text = _replace_marked(
        text,
        "<!-- apple-splash -->",
        "<!-- /apple-splash -->",
        f"<!-- apple-splash -->\n{links}\n  <!-- /apple-splash -->",
        "apple-splash",
    )
    text = _replace_marked(
        text,
        "<!-- splash-mark -->",
        "<!-- /splash-mark -->",
        f"<!-- splash-mark -->\n{splash_mark_svg()}\n    <!-- /splash-mark -->",
        "splash-mark",
    )
    path.write_text(text, encoding="utf-8")


def write_ico(path: Path) -> None:
    """PNG-compressed ICO so the glass alpha survives on Windows."""
    sizes = (16, 24, 32, 48, 64, 128, 256)
    frames = [mark(size) for size in sizes]
    path.parent.mkdir(parents=True, exist_ok=True)
    frames[-1].save(
        path,
        format="ICO",
        sizes=[(size, size) for size in sizes],
        append_images=frames[:-1],
    )


def main() -> None:
    web_icons = ROOT / "web" / "icons"
    save(mark(192), web_icons / "Icon-192.png")
    save(mark(512), web_icons / "Icon-512.png")
    # Maskable icons are cropped by the OS, so the plate fills the canvas.
    save(mark(192, 0.04), web_icons / "Icon-maskable-192.png")
    save(mark(512, 0.04), web_icons / "Icon-maskable-512.png")
    save(mark(180), web_icons / "apple-touch-icon.png")
    save(mark(64), ROOT / "web" / "favicon.png")

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
        save(mark(px), ROOT / "android" / "app" / "src" / "main" / "res" / folder / "ic_launcher.png")

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
        save(mark(int(round(logical * scale))), iconset / name)

    macset = ROOT / "macos" / "Runner" / "Assets.xcassets" / "AppIcon.appiconset"
    for name, px in (
        ("app_icon_16.png", 16),
        ("app_icon_32.png", 32),
        ("app_icon_64.png", 64),
        ("app_icon_128.png", 128),
        ("app_icon_256.png", 256),
        ("app_icon_512.png", 512),
        ("app_icon_1024.png", 1024),
    ):
        save(mark(px), macset / name)

    write_ico(ROOT / "windows" / "runner" / "resources" / "app_icon.ico")

    patch_index(startup_links())
    print("wrote brand icons and", len(DEVICES) * 2, "startup images")


if __name__ == "__main__":
    main()
