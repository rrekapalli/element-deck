"""Look up likely free photos for elements without a Symbol,Z file."""
from __future__ import annotations

import json
import time
import urllib.parse
import urllib.request
from pathlib import Path

UA = {"User-Agent": "ElementDeckCatalog/1.2 (educational; catalog build)"}
TITLES = [
    "File:Technetium (Element - 43).jpg",
    "File:Promethium(III) nitrate hydrate.jpg",
    "File:Promethium-147 solution.jpg",
    "File:Polonium on brass sheet.jpg",
    "File:Glow from a sample of astatine (cropped).jpg",
    "File:Astatine-211 in bismuth target.jpg",
    "File:Pu,94.jpg",
    "File:Thorium sample.jpg",
    "File:Thorium.jpg",
    "File:Th,90.jpg",
    "File:Neptunium.jpg",
    "File:Np,93.jpg",
    "File:Americium.jpg",
    "File:Am,95.jpg",
    "File:Curium.jpg",
    "File:Cm,96.jpg",
    "File:Berkelium.jpg",
    "File:Bk,97.jpg",
    "File:Californium.jpg",
    "File:Cf,98.jpg",
    "File:Einsteinium.jpg",
    "File:Radium bromide.jpg",
    "File:Radium.jpg",
    "File:Ra,88.jpg",
    "File:Actinium.jpg",
    "File:Ac,89.jpg",
    "File:Protactinium.jpg",
    "File:Pa,91.jpg",
    "File:Radon spectrum.jpg",
    "File:Fermium.jpg",
    "File:Mendelevium.jpg",
    "File:43 (Tc I) NIST ASD emission spectrum.png",
    "File:61 (Pm I) NIST ASD emission spectrum.png",
    "File:84 (Po I) NIST ASD emission spectrum.png",
    "File:86 (Rn I) NIST ASD emission spectrum.png",
    "File:88 (Ra I) NIST ASD emission spectrum.png",
    "File:90 (Th I) NIST ASD emission spectrum.png",
    "File:92 (U I) NIST ASD emission spectrum.png",
    "File:94 (Pu I) NIST ASD emission spectrum.png",
]


def get(params: dict) -> dict:
    url = "https://commons.wikimedia.org/w/api.php?" + urllib.parse.urlencode(params)
    for attempt in range(4):
        req = urllib.request.Request(url, headers=UA)
        try:
            with urllib.request.urlopen(req, timeout=60) as resp:
                return json.load(resp)
        except Exception as exc:
            print("retry", type(exc).__name__)
            time.sleep(8 * (attempt + 1))
    raise SystemExit("gave up")


def main() -> None:
    rows = []
    for i in range(0, len(TITLES), 8):
        data = get(
            {
                "action": "query",
                "titles": "|".join(TITLES[i : i + 8]),
                "prop": "imageinfo",
                "iiprop": "extmetadata|size|url",
                "iiurlwidth": "720",
                "format": "json",
            }
        )
        for page in data.get("query", {}).get("pages", {}).values():
            title = page.get("title")
            if page.get("missing") is not None:
                print("MISSING", title)
                continue
            info = page["imageinfo"][0]
            meta = info.get("extmetadata") or {}
            lic = (meta.get("LicenseShortName") or {}).get("value", "?")
            artist = str((meta.get("Artist") or {}).get("value", ""))
            artist = " ".join(artist.split())[:120]
            print(f"{lic:22} {info.get('size'):8} {title} | {artist}")
            rows.append({"title": title, "license": lic, "artist": artist, "url": info.get("thumburl") or info.get("url")})
        time.sleep(1.5)
    Path(__file__).with_name("gap_titles.json").write_text(json.dumps(rows, indent=2), encoding="utf-8")


if __name__ == "__main__":
    main()
