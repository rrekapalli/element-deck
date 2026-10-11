"""Find a free photo for elements missing from the Symbol,Z set."""
from __future__ import annotations

import json
import os
import time
import urllib.parse
import urllib.request
from pathlib import Path

os.environ["PYTHONIOENCODING"] = "utf-8"
UA = {"User-Agent": "ElementDeckCatalog/1.2 (educational; catalog build)"}
MISSING = {
    43: "Technetium",
    61: "Promethium",
    84: "Polonium",
    85: "Astatine",
    86: "Radon",
    87: "Francium",
    88: "Radium",
    89: "Actinium",
    90: "Thorium",
    91: "Protactinium",
    93: "Neptunium",
    94: "Plutonium",
    95: "Americium",
    96: "Curium",
    97: "Berkelium",
    98: "Californium",
    99: "Einsteinium",
    100: "Fermium",
    101: "Mendelevium",
    102: "Nobelium",
    103: "Lawrencium",
    104: "Rutherfordium",
    105: "Dubnium",
    106: "Seaborgium",
    107: "Bohrium",
    108: "Hassium",
    109: "Meitnerium",
    110: "Darmstadtium",
    111: "Roentgenium",
    112: "Copernicium",
    113: "Nihonium",
    114: "Flerovium",
    115: "Moscovium",
    116: "Livermorium",
    117: "Tennessine",
    118: "Oganesson",
}


def get(params: dict, host: str = "commons.wikimedia.org") -> dict:
    url = f"https://{host}/w/api.php?" + urllib.parse.urlencode(params)
    for attempt in range(4):
        req = urllib.request.Request(url, headers=UA)
        try:
            with urllib.request.urlopen(req, timeout=60) as resp:
                return json.load(resp)
        except Exception as exc:
            print("retry", exc)
            time.sleep(6 * (attempt + 1))
    raise SystemExit("gave up")


def wiki_images(name: str) -> list[str]:
    data = get(
        {
            "action": "query",
            "titles": name,
            "generator": "images",
            "gimlimit": "12",
            "prop": "imageinfo",
            "iiprop": "extmetadata|mime|url|size",
            "format": "json",
        },
        host="en.wikipedia.org",
    )
    pages = (data.get("query") or {}).get("pages") or {}
    rows = []
    for page in pages.values():
        info = (page.get("imageinfo") or [{}])[0]
        meta = info.get("extmetadata") or {}
        lic = (meta.get("LicenseShortName") or {}).get("value", "?")
        mime = info.get("mime") or ""
        title = page.get("title") or ""
        if not mime.startswith("image/"):
            continue
        if mime == "image/svg+xml":
            continue
        rows.append((lic, info.get("size"), title, info.get("url")))
    return rows


def main() -> None:
    # Who made the standard set?
    data = get(
        {
            "action": "query",
            "titles": "File:H,1.jpg",
            "prop": "revisions",
            "rvprop": "content|user",
            "rvslots": "main",
            "format": "json",
        }
    )
    page = next(iter(data["query"]["pages"].values()))
    rev = page["revisions"][0]
    print("uploader-field", rev.get("user"))
    slot = (rev.get("slots") or {}).get("main") or {}
    text = slot.get("content") or slot.get("*") or ""
    print(text[:1500])
    print("---")
    out = {}
    for z, name in MISSING.items():
        try:
            rows = wiki_images(name)
        except Exception as exc:
            print(z, name, "ERR", exc)
            continue
        print(f"\n{z} {name}")
        for lic, size, title, url in rows:
            print(f"  {lic:22} {size} {title}")
        out[z] = [
            {"license": lic, "size": size, "title": title, "url": url}
            for lic, size, title, url in rows
        ]
        time.sleep(0.8)
    Path(__file__).with_name("element_gap_images.json").write_text(
        json.dumps(out, indent=2), encoding="utf-8"
    )


if __name__ == "__main__":
    main()
