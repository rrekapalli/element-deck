"""Print extmetadata keys for one element photo, and search gaps."""
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


def main() -> None:
    data = get(
        {
            "action": "query",
            "titles": "File:Au,79.jpg|File:H,1.jpg|File:Pu,94.jpg",
            "prop": "imageinfo",
            "iiprop": "extmetadata|size|url",
            "format": "json",
        }
    )
    for page in data["query"]["pages"].values():
        info = page["imageinfo"][0]
        meta = info["extmetadata"]
        print("==", page["title"], "bytes", info.get("size"))
        for key, val in meta.items():
            text = str(val.get("value", "") if isinstance(val, dict) else val)
            text = " ".join(text.split())[:240]
            print(f"  {key}: {text}")
    time.sleep(2)
    for query in [
        "technetium metal",
        "promethium sample",
        "polonium",
        "radium",
        "thorium metal",
        "protactinium",
        "neptunium",
        "americium",
        "curium",
        "berkelium",
        "californium",
        "plutonium button",
        "radon",
        "astatine",
        "francium",
        "einsteinium",
    ]:
        data = get(
            {
                "action": "query",
                "generator": "search",
                "gsrsearch": f"{query} filetype:bitmap",
                "gsrnamespace": "6",
                "gsrlimit": "5",
                "prop": "imageinfo",
                "iiprop": "extmetadata",
                "format": "json",
            }
        )
        print("\n==", query)
        pages = (data.get("query") or {}).get("pages") or {}
        for page in pages.values():
            info = (page.get("imageinfo") or [{}])[0]
            lic = ((info.get("extmetadata") or {}).get("LicenseShortName") or {}).get("value", "?")
            print(f"  {lic:20} {page.get('title')}")
        time.sleep(1.4)


if __name__ == "__main__":
    main()
