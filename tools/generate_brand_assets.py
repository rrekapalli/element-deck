#!/usr/bin/env python3
"""Raster the Element Deck mark for home-screen icons.

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
ACTION = (56, 189, 248, 255)
GOLD = (228, 184, 74, 255)
INK = (11, 27, 51, 255)

SANS = ROOT / "assets" / "fonts" / "PlusJakartaSans.ttf"


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


def touch_icon(size: int = 180) -> Image.Image:
    """Opaque home-screen icon.

    iOS rejects an apple-touch-icon that still has an alpha channel and keeps
    showing the last opaque icon it accepted for that URL.
    """
    tile = mark(size, inset_ratio=0)
    # Solid light plate. Corners are masked by the system squircle.
    background = Image.new("RGBA", (size, size), (244, 248, 252, 255))
    return Image.alpha_composite(background, tile).convert("RGB")


def save(image: Image.Image, path: Path) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    image.save(path, "PNG", optimize=True)


def _replace_marked(text: str, start: str, end: str, block: str, label: str) -> str:
    if start not in text or end not in text:
        raise SystemExit(f"index.html is missing {label} markers")
    pre, rest = text.split(start, 1)
    _, post = rest.split(end, 1)
    return pre + block + post


def patch_index() -> None:
    """Leave the web shell on the canvas color.

    AppSplash is the only branded splash. Do not link startup images or draw
    a second mark into index.html.
    """
    path = ROOT / "web" / "index.html"
    text = path.read_text(encoding="utf-8")
    if "<!-- apple-splash -->" in text and "<!-- /apple-splash -->" in text:
        text = _replace_marked(
            text,
            "<!-- apple-splash -->",
            "<!-- /apple-splash -->",
            "<!-- apple-splash -->\n  <!-- /apple-splash -->",
            "apple-splash",
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
    # New filename on purpose: Safari pins the previous apple-touch-icon bytes
    # to the old URL and will not replace them in Add to Home Screen.
    home = touch_icon(180)
    save(home, web_icons / "apple-touch-icon-180.png")
    save(home, web_icons / "apple-touch-icon.png")
    save(home, ROOT / "web" / "apple-touch-icon.png")
    save(home, ROOT / "web" / "apple-touch-icon-precomposed.png")
    save(home, ROOT / "web" / "apple-touch-icon-180x180.png")
    save(touch_icon(192), web_icons / "mark-192.png")
    save(touch_icon(512), web_icons / "mark-512.png")
    save(mark(64), ROOT / "web" / "favicon.png")

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

    patch_index()
    print("wrote brand icons")


if __name__ == "__main__":
    main()
