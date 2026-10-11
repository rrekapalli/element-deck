"""Download or draw one picture for every element and write sample_manifest.json.

Photographs come from Wikimedia Commons at a modest width. Spectrum cards and
the 'no sample' cards are drawn here from wavelengths already in this pack.
"""

from __future__ import annotations

import html
import json
import re
import time
import urllib.parse
import urllib.request
from pathlib import Path

from element_samples import (
    CREDIT_OVERRIDE,
    SAMPLE_DIR,
    SPECIAL_FILES,
    SPECTRUM,
    UNSEEN,
)
from generate_catalog import NIST_LINES, parse_all

UA = {"User-Agent": "ElementDeckCatalog/1.3 (educational; catalog build)"}
MANIFEST = Path(__file__).resolve().parent / "sample_manifest.json"
ALLOWED = ("public domain", "cc0", "cc by", "fal", "gfdl", "no restrictions")


def api(titles: list[str], width: int = 480) -> dict:
    params = {
        "action": "query",
        "titles": "|".join(titles),
        "prop": "imageinfo",
        "iiprop": "url|mime|size|extmetadata",
        "iiurlwidth": str(width),
        "format": "json",
    }
    url = "https://commons.wikimedia.org/w/api.php?" + urllib.parse.urlencode(params)
    for attempt in range(6):
        req = urllib.request.Request(url, headers=UA)
        try:
            with urllib.request.urlopen(req, timeout=60) as resp:
                return json.load(resp)
        except Exception:
            time.sleep(8 * (attempt + 1))
    raise SystemExit("Commons gave up")


def plain(value: str) -> str:
    text = re.sub(r"<[^>]+>", " ", value or "")
    text = html.unescape(text)
    text = text.replace("\xa0", " ")
    return " ".join(text.split())


def credit_for(z: int, meta: dict) -> str:
    if z in CREDIT_OVERRIDE:
        return CREDIT_OVERRIDE[z]
    license_name = plain((meta.get("LicenseShortName") or {}).get("value", ""))
    artist = plain((meta.get("Artist") or {}).get("value", ""))
    artist = re.sub(r"\s*\(see .*", "", artist).strip(" ,")
    low = license_name.lower()
    if "fair use" in low:
        raise SystemExit(f"Z={z} is fair use and cannot be shipped")
    if not any(token in low for token in ALLOWED):
        raise SystemExit(f"Z={z} license is not reusable: {license_name}")
    if not artist and "by-sa 3.0" in low:
        artist = "RTC"
    if "public domain" in low or low in {"cc0", "no restrictions"}:
        return f"{artist}, public domain" if artist else "Public domain"
    if low == "fal":
        return f"{artist}, Free Art License, via Wikimedia Commons".strip(", ")
    return f"{artist}, {license_name}, via Wikimedia Commons".strip(", ")


def save_bytes(z: int, data: bytes) -> str:
    ext = ".png" if data.startswith(b"\x89PNG") else ".jpg"
    if ext == ".jpg" and not data.startswith(b"\xff\xd8"):
        raise SystemExit(f"Z={z} is not a jpeg or png ({len(data)} bytes)")
    if len(data) < 1000:
        raise SystemExit(f"Z={z} image is too small")
    SAMPLE_DIR.mkdir(parents=True, exist_ok=True)
    for old in SAMPLE_DIR.glob(f"{z}.*"):
        if old.suffix != ext:
            old.unlink()
    dest = SAMPLE_DIR / f"{z}{ext}"
    dest.write_bytes(data)
    return f"assets/samples/{z}{ext}"


def download(z: int, info: dict) -> str:
    dest_jpg = SAMPLE_DIR / f"{z}.jpg"
    dest_png = SAMPLE_DIR / f"{z}.png"
    if dest_jpg.is_file() and dest_jpg.stat().st_size > 1000:
        return f"assets/samples/{z}.jpg"
    if dest_png.is_file() and dest_png.stat().st_size > 1000:
        return f"assets/samples/{z}.png"
    thumb = info.get("thumburl") or ""
    original = info.get("url") or ""
    # Scaled thumbs are the allowed path. An "unscaled" URL is the original and is rate-limited.
    url = thumb if "/thumb/" in thumb else original
    if "/thumb/" not in url and info.get("width", 0) > 200:
        narrower = api_one_thumb(info.get("_title", ""), 240)
        if narrower and "/thumb/" in narrower:
            url = narrower
    data = b""
    for attempt in range(6):
        req = urllib.request.Request(url, headers=UA)
        try:
            with urllib.request.urlopen(req, timeout=90) as resp:
                data = resp.read()
            break
        except Exception as exc:
            print(f"retry Z={z} {type(exc).__name__}", flush=True)
            time.sleep(15 * (attempt + 1))
    if not data:
        raise SystemExit(f"download failed for Z={z} {url}")
    return save_bytes(z, data)


def api_one_thumb(title: str, width: int) -> str:
    if not title:
        return ""
    data = api([title], width)
    for page in (data.get("query") or {}).get("pages", {}).values():
        info = (page.get("imageinfo") or [{}])[0]
        return info.get("thumburl") or ""
    return ""


def wl_to_rgb(nm: float) -> tuple[int, int, int]:
    if nm < 380 or nm > 780:
        return (40, 40, 48)
    if nm < 440:
        r, g, b = -(nm - 440) / 60, 0.0, 1.0
    elif nm < 490:
        r, g, b = 0.0, (nm - 440) / 50, 1.0
    elif nm < 510:
        r, g, b = 0.0, 1.0, -(nm - 510) / 20
    elif nm < 580:
        r, g, b = (nm - 510) / 70, 1.0, 0.0
    elif nm < 645:
        r, g, b = 1.0, -(nm - 645) / 65, 0.0
    else:
        r, g, b = 1.0, 0.0, 0.0
    if nm < 420:
        factor = 0.3 + 0.7 * (nm - 380) / 40
    elif nm > 700:
        factor = 0.3 + 0.7 * (780 - nm) / 80
    else:
        factor = 1.0

    def adj(channel: float) -> int:
        return int(max(0, min(255, (channel * factor) ** 0.8 * 255)))

    return adj(r), adj(g), adj(b)


def _font(size: int):
    from PIL import ImageFont

    for path in (
        r"C:\Windows\Fonts\segoeui.ttf",
        r"C:\Windows\Fonts\arial.ttf",
    ):
        if Path(path).is_file():
            return ImageFont.truetype(path, size)
    return ImageFont.load_default()


def draw_spectrum(z: int, symbol: str) -> str:
    from PIL import Image, ImageDraw

    lines = [float(row["nm"]) for row in NIST_LINES.get(z, []) if 380 <= float(row["nm"]) <= 780]
    if not lines:
        raise SystemExit(f"Z={z} has no visible lines to draw")
    image = Image.new("RGB", (1200, 600), (8, 10, 16))
    draw = ImageDraw.Draw(image)
    left, right, top, bottom = 80, 1120, 150, 430
    draw.rectangle((left, top, right, bottom), fill=(0, 0, 0))
    for nm in range(380, 781, 2):
        x = left + (nm - 380) / 400 * (right - left)
        draw.line((x, bottom + 8, x, bottom + 18), fill=wl_to_rgb(nm))
    for nm in lines:
        x = left + (nm - 380) / 400 * (right - left)
        color = wl_to_rgb(nm)
        for width, alpha in ((18, 40), (8, 90), (3, 255)):
            band = tuple(int(channel * alpha / 255) for channel in color)
            draw.line((x, top + 8, x, bottom - 8), fill=band, width=width)
    title_font = _font(42)
    small = _font(22)
    draw.text((80, 48), f"{symbol}  emission lines", fill=(230, 232, 236), font=title_font)
    label = "   ".join(f"{nm:.0f} nm" for nm in lines[:6])
    draw.text((80, 480), label, fill=(180, 184, 192), font=small)
    draw.text((80, 530), "Measured wavelengths. Not a photograph of a sample.", fill=(140, 144, 152), font=small)
    dest = SAMPLE_DIR / f"{z}.jpg"
    SAMPLE_DIR.mkdir(parents=True, exist_ok=True)
    image.save(dest, quality=90)
    return f"assets/samples/{z}.jpg"


def draw_unseen(z: int, symbol: str, name: str) -> str:
    from PIL import Image, ImageDraw

    image = Image.new("RGB", (1200, 600), (14, 16, 22))
    draw = ImageDraw.Draw(image)
    draw.rounded_rectangle((48, 48, 1152, 552), radius=24, outline=(70, 76, 88), width=2)
    draw.text((80, 150), symbol, fill=(232, 234, 238), font=_font(120))
    draw.text((80, 310), name, fill=(180, 184, 192), font=_font(36))
    draw.text(
        (80, 390),
        "No visible sample has been photographed.",
        fill=(150, 154, 162),
        font=_font(28),
    )
    dest = SAMPLE_DIR / f"{z}.jpg"
    SAMPLE_DIR.mkdir(parents=True, exist_ok=True)
    image.save(dest, quality=90)
    return f"assets/samples/{z}.jpg"


def main() -> None:
    elements = parse_all()
    by_z = {el["z"]: el for el in elements}
    photos = [z for z in range(1, 119) if z not in SPECTRUM and z not in UNSEEN]
    titles = {
        z: SPECIAL_FILES.get(z, f"File:{by_z[z]['symbol']},{z}.jpg") for z in photos
    }
    info_by_title: dict[str, dict] = {}
    ordered = list(titles.values())
    for i in range(0, len(ordered), 8):
        data = api(ordered[i : i + 8])
        for page in (data.get("query") or {}).get("pages", {}).values():
            info_by_title[page.get("title") or ""] = page
        time.sleep(1.2)

    manifest: dict[str, dict] = {}
    for z in photos:
        page = info_by_title.get(titles[z])
        if not page or "missing" in page:
            raise SystemExit(f"missing Commons file for Z={z}: {titles[z]}")
        info = (page.get("imageinfo") or [{}])[0]
        info["_title"] = titles[z]
        meta = info.get("extmetadata") or {}
        credit = credit_for(z, meta)
        image = download(z, info)
        manifest[str(z)] = {"image": image, "credit": credit}
        time.sleep(1.0)

    for z in sorted(SPECTRUM):
        image = draw_spectrum(z, by_z[z]["symbol"])
        manifest[str(z)] = {
            "image": image,
            "credit": "Drawn from NIST wavelengths in this pack",
        }
    for z in sorted(UNSEEN):
        image = draw_unseen(z, by_z[z]["symbol"], by_z[z]["name"])
        manifest[str(z)] = {"image": image, "credit": "Original illustration"}

    if set(manifest) != {str(z) for z in range(1, 119)}:
        raise SystemExit("manifest is not 1..118")
    MANIFEST.write_text(json.dumps(manifest, indent=2), encoding="utf-8")
    print("wrote", len(manifest), "samples")


if __name__ == "__main__":
    main()
