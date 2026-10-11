"""Resolve a free-licensed photo of each pure element on Commons."""
from __future__ import annotations

import json
import time
import urllib.parse
import urllib.request
from pathlib import Path

UA = {"User-Agent": "ElementDeckCatalog/1.2 (educational; catalog build)"}
ROOT = Path(__file__).resolve().parents[1]

# z, symbol from the catalog generator's table, duplicated here so this script
# can run before the JSON exists.
ELEMENTS = """
1 H 2 He 3 Li 4 Be 5 B 6 C 7 N 8 O 9 F 10 Ne
11 Na 12 Mg 13 Al 14 Si 15 P 16 S 17 Cl 18 Ar 19 K 20 Ca
21 Sc 22 Ti 23 V 24 Cr 25 Mn 26 Fe 27 Co 28 Ni 29 Cu 30 Zn
31 Ga 32 Ge 33 As 34 Se 35 Br 36 Kr 37 Rb 38 Sr 39 Y 40 Zr
41 Nb 42 Mo 43 Tc 44 Ru 45 Rh 46 Pd 47 Ag 48 Cd 49 In 50 Sn
51 Sb 52 Te 53 I 54 Xe 55 Cs 56 Ba 57 La 58 Ce 59 Pr 60 Nd
61 Pm 62 Sm 63 Eu 64 Gd 65 Tb 66 Dy 67 Ho 68 Er 69 Tm 70 Yb
71 Lu 72 Hf 73 Ta 74 W 75 Re 76 Os 77 Ir 78 Pt 79 Au 80 Hg
81 Tl 82 Pb 83 Bi 84 Po 85 At 86 Rn 87 Fr 88 Ra 89 Ac 90 Th
91 Pa 92 U 93 Np 94 Pu 95 Am 96 Cm 97 Bk 98 Cf 99 Es 100 Fm
101 Md 102 No 103 Lr 104 Rf 105 Db 106 Sg 107 Bh 108 Hs 109 Mt
110 Ds 111 Rg 112 Cn 113 Nh 114 Fl 115 Mc 116 Lv 117 Ts 118 Og
"""


def pairs() -> list[tuple[int, str]]:
    bits = ELEMENTS.split()
    return [(int(bits[i]), bits[i + 1]) for i in range(0, len(bits), 2)]


def get(params: dict) -> dict:
    url = "https://commons.wikimedia.org/w/api.php?" + urllib.parse.urlencode(params)
    for attempt in range(5):
        req = urllib.request.Request(url, headers=UA)
        try:
            with urllib.request.urlopen(req, timeout=60) as resp:
                return json.load(resp)
        except Exception as exc:
            wait = 8 * (attempt + 1)
            print("retry", exc, "in", wait)
            time.sleep(wait)
    raise SystemExit("gave up")


def lookup(titles: list[str]) -> dict[str, dict]:
    data = get(
        {
            "action": "query",
            "titles": "|".join(titles),
            "prop": "imageinfo",
            "iiprop": "url|extmetadata|mime",
            "iiurlwidth": "720",
            "format": "json",
        }
    )
    out = {}
    for page in data.get("query", {}).get("pages", {}).values():
        title = page.get("title") or ""
        if page.get("missing") is not None:
            out[title] = {"missing": True}
            continue
        info = (page.get("imageinfo") or [{}])[0]
        meta = info.get("extmetadata") or {}
        out[title] = {
            "missing": False,
            "license": (meta.get("LicenseShortName") or {}).get("value", ""),
            "artist": (meta.get("Artist") or {}).get("value", ""),
            "thumb": info.get("thumburl") or info.get("url"),
            "mime": info.get("mime"),
        }
    return out


def free(license_name: str) -> bool:
    low = license_name.lower()
    if any(token in low for token in ("public domain", "cc0", "cc-zero")):
        return True
    if low.startswith("pd"):
        return True
    if low.startswith("cc by"):
        return True
    return False


def main() -> None:
    wanted = []
    for z, symbol in pairs():
        wanted.append((z, symbol, f"File:{symbol},{z}.jpg"))
    found = {}
    titles = [title for _, _, title in wanted]
    for i in range(0, len(titles), 15):
        found.update(lookup(titles[i : i + 15]))
        time.sleep(1.5)
    rows = []
    missing = []
    blocked = []
    for z, symbol, title in wanted:
        info = found.get(title) or {"missing": True}
        if info.get("missing"):
            missing.append(z)
            continue
        if not free(info.get("license") or ""):
            blocked.append((z, info.get("license"), title))
            continue
        rows.append({"z": z, "symbol": symbol, "title": title, **info})
    out = Path(__file__).with_name("element_sample_hits.json")
    out.write_text(json.dumps(rows, indent=2), encoding="utf-8")
    print("hits", len(rows), "missing", missing)
    print("blocked", blocked[:20], "count", len(blocked))
    from collections import Counter

    print(Counter(row["license"] for row in rows))


if __name__ == "__main__":
    main()
