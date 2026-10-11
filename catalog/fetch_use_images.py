"""Download public-domain and CC0 photos used on the Uses tab."""

from __future__ import annotations

import json
import time
import urllib.parse
import urllib.request
from pathlib import Path

from use_images import SOURCES, USE_DIR

ALLOWED = ("public domain", "cc0", "pd")


def license_ok(name: str) -> bool:
    low = name.lower()
    if "by" in low or "sa" in low or "gfdl" in low:
        return False
    return any(token in low for token in ALLOWED)


def fetch(key: str, title: str) -> None:
    query = urllib.parse.urlencode(
        {
            "action": "query",
            "titles": f"File:{title}",
            "prop": "imageinfo",
            "iiprop": "url|mime|extmetadata",
            "iiurlwidth": "720",
            "format": "json",
        }
    )
    req = urllib.request.Request(
        "https://commons.wikimedia.org/w/api.php?" + query,
        headers={"User-Agent": "ElementDeckCatalog/1.2 (educational; catalog build)"},
    )
    with urllib.request.urlopen(req, timeout=60) as resp:
        data = json.load(resp)
    page = next(iter(data["query"]["pages"].values()))
    if page.get("missing") is not None:
        raise SystemExit(f"missing {title}")
    info = page["imageinfo"][0]
    lic = (info.get("extmetadata") or {}).get("LicenseShortName", {}).get("value", "")
    if not license_ok(lic):
        raise SystemExit(f"refusing {title}: {lic}")
    url = info.get("thumburl") or info["url"]
    image_req = urllib.request.Request(
        url,
        headers={"User-Agent": "ElementDeckCatalog/1.2 (educational; catalog build)"},
    )
    with urllib.request.urlopen(image_req, timeout=60) as resp:
        blob = resp.read()
    dest = USE_DIR / f"{key}.jpg"
    dest.write_bytes(blob)
    print(f"{key:12} {len(blob):7}  {lic}  {title}")
    time.sleep(1.5)


def main() -> None:
    USE_DIR.mkdir(parents=True, exist_ok=True)
    for key, (title, _credit) in SOURCES.items():
        dest = USE_DIR / f"{key}.jpg"
        if dest.is_file() and 1000 < dest.stat().st_size < 400_000:
            print(f"{key:12} skip")
            continue
        try:
            fetch(key, title)
        except Exception as exc:
            print(f"{key:12} retry after {exc}")
            time.sleep(12)
            try:
                fetch(key, title)
            except Exception as exc2:
                print(f"{key:12} FAILED {exc2}")


if __name__ == "__main__":
    main()
