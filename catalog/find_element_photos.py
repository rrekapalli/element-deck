"""Find Commons photos of elemental samples and print license + title."""
from __future__ import annotations

import json
import time
import urllib.parse
import urllib.request

UA = {"User-Agent": "ElementDeckCatalog/1.2 (educational; catalog build)"}


def get(params: dict) -> dict:
    url = "https://commons.wikimedia.org/w/api.php?" + urllib.parse.urlencode(params)
    req = urllib.request.Request(url, headers=UA)
    with urllib.request.urlopen(req, timeout=60) as resp:
        return json.load(resp)


def category_all(title: str) -> list[tuple[int, str]]:
    out = []
    cont = None
    while True:
        params = {
            "action": "query",
            "list": "categorymembers",
            "cmtitle": title,
            "cmtype": "file|subcat",
            "cmlimit": "500",
            "format": "json",
        }
        if cont:
            params["cmcontinue"] = cont
        data = get(params)
        for member in data.get("query", {}).get("categorymembers", []):
            out.append((member["ns"], member["title"]))
        cont = data.get("continue", {}).get("cmcontinue")
        if not cont:
            break
        time.sleep(0.4)
    return out


def licenses(titles: list[str]) -> list[dict]:
    found = []
    for i in range(0, len(titles), 20):
        chunk = titles[i : i + 20]
        data = get(
            {
                "action": "query",
                "titles": "|".join(chunk),
                "prop": "imageinfo",
                "iiprop": "extmetadata|url|size",
                "iiurlwidth": "480",
                "format": "json",
            }
        )
        for page in data.get("query", {}).get("pages", {}).values():
            info = (page.get("imageinfo") or [{}])[0]
            meta = info.get("extmetadata") or {}
            lic = (meta.get("LicenseShortName") or {}).get("value", "?")
            artist = (meta.get("Artist") or {}).get("value", "")
            found.append(
                {
                    "title": page.get("title"),
                    "license": lic,
                    "artist": artist[:180],
                    "thumb": info.get("thumburl"),
                    "width": info.get("thumbwidth"),
                    "height": info.get("thumbheight"),
                }
            )
        time.sleep(1.1)
    return found


def main() -> None:
    rows = category_all("Category:Element samples")
    extra_cats = [title for ns, title in rows if ns == 14]
    files = [title for ns, title in rows if ns == 6]
    for cat in extra_cats:
        time.sleep(0.5)
        files.extend(title for ns, title in category_all(cat) if ns == 6)
    images = []
    seen = set()
    for title in files:
        if not title.lower().endswith((".jpg", ".jpeg", ".png", ".JPG")):
            continue
        if title in seen:
            continue
        seen.add(title)
        images.append(title)
    print("checking", len(images))
    rows_out = licenses(images)
    Path = __import__("pathlib").Path
    out = Path(__file__).with_name("element_photo_scan.json")
    out.write_text(json.dumps(rows_out, indent=2), encoding="utf-8")
    from collections import Counter

    print(Counter(row["license"] for row in rows_out))
    print("PD/CC0:")
    for row in rows_out:
        low = row["license"].lower()
        if "public domain" in low or low.startswith("cc0") or low.startswith("pd"):
            print(" ", row["license"], row["title"])


if __name__ == "__main__":
    main()
