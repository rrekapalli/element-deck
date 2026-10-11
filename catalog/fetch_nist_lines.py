#!/usr/bin/env python3
"""Teaching subset of observed lines from the NIST Atomic Spectra Database.

Air wavelengths, neutral atom (I). The first ion (II) is added only when the
neutral spectrum has fewer than three lines inside 380–780 nm. Superheavy
elements that NIST does not list stay empty — wavelengths are not invented.
"""

from __future__ import annotations

import csv
import io
import json
import re
import time
import urllib.parse
import urllib.request
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

ROOT = Path(__file__).resolve().parent
CATALOG = ROOT.parent / "assets" / "catalog" / "core.json"
OUT = ROOT / "nist_lines.json"

UA = "ElementDeckCatalog/1.0 (teaching catalog; local build)"
ROMAN = {1: "I", 2: "II"}


def _clean(cell: str) -> str:
    s = (cell or "").strip()
    if s.startswith('="') and s.endswith('"'):
        s = s[2:-1]
    return s.strip().strip('"').strip()


def _number(cell: str) -> float | None:
    s = _clean(cell).replace(",", "")
    match = re.match(r"[-+]?\d+(?:\.\d+)?(?:[eE][-+]?\d+)?", s)
    if not match:
        return None
    return float(match.group(0))


def _band(nm: float) -> str:
    if nm < 380:
        return "UV"
    if nm < 450:
        return "violet"
    if nm < 495:
        return "blue"
    if nm < 570:
        return "green"
    if nm < 590:
        return "yellow"
    if nm < 620:
        return "orange"
    if nm < 780:
        return "red"
    return "near-IR"


def _fetch(spectra: str) -> str:
    query = urllib.parse.urlencode(
        {
            "spectra": spectra,
            "limits_type": "0",
            "low_w": "180",
            "upp_w": "1100",
            "unit": "1",
            "de": "0",
            "format": "2",
            "line_out": "3",
            "remove_js": "on",
            "en_unit": "1",
            "output": "1",
            "show_obs_wl": "1",
            "order_out": "0",
            "show_av": "2",
            "intens_out": "on",
            "allowed_out": "1",
            "forbid_out": "1",
            "term_out": "on",
            "enrg_out": "on",
            "J_out": "on",
        }
    )
    url = "https://physics.nist.gov/cgi-bin/ASD/lines1.pl?" + query
    req = urllib.request.Request(url, headers={"User-Agent": UA})
    with urllib.request.urlopen(req, timeout=90) as response:
        return response.read().decode("utf-8", "replace")


def _parse(text: str, symbol: str, stage: str) -> list[dict]:
    if "No lines" in text or "obs_wl_air" not in text:
        return []
    rows = csv.reader(io.StringIO(text))
    header = next(rows, None)
    if not header:
        return []
    names = [_clean(h) for h in header]
    index = {name: i for i, name in enumerate(names)}

    def col(row: list[str], name: str) -> str:
        i = index.get(name)
        if i is None or i >= len(row):
            return ""
        return _clean(row[i])

    parsed: list[dict] = []
    for row in rows:
        if not row or not any(cell.strip() for cell in row):
            continue
        nm = _number(col(row, "obs_wl_air(nm)"))
        if nm is None:
            nm = _number(col(row, "obs_wl_vac(nm)"))
        if nm is None or not (180 <= nm <= 1100):
            continue
        intens = _number(col(row, "intens")) or 0.0
        aki = _number(col(row, "Aki(s^-1)")) or 0.0
        ei = _number(col(row, "Ei(eV)"))
        term_i = col(row, "term_i")
        term_k = col(row, "term_k")
        if term_i and term_k:
            transition = f"{symbol} {stage} {term_i} → {term_k}"
        else:
            transition = f"{symbol} {stage}"
        score = intens if intens > 0 else aki / 1e6
        parsed.append(
            {
                "nm": round(nm, 3 if nm < 100 else 2),
                "transition": transition,
                "color": _band(nm),
                "spectrum": "both" if ei is not None and ei < 0.25 else "emission",
                "score": score,
                "visible": 380 <= nm <= 780,
            }
        )
    return parsed


def _pick(lines: list[dict], limit: int = 8) -> list[dict]:
    # Drop near-duplicates, keeping the stronger one.
    kept: list[dict] = []
    for line in sorted(lines, key=lambda item: item["score"], reverse=True):
        if any(abs(line["nm"] - other["nm"]) < 0.08 for other in kept):
            continue
        kept.append(line)
    visible = [line for line in kept if line["visible"]]
    other = [line for line in kept if not line["visible"]]
    chosen = visible[:6]
    if len(chosen) < 4:
        for line in other:
            if len(chosen) >= 4:
                break
            chosen.append(line)
    chosen = chosen[:limit]
    chosen.sort(key=lambda item: item["nm"])
    for line in chosen:
        line.pop("score", None)
        line.pop("visible", None)
    return chosen


def _one(z: int, symbol: str) -> tuple[int, list[dict], str]:
    notes = []
    try:
        neutral = _parse(_fetch(f"{symbol} I"), symbol, "I")
    except Exception as exc:  # noqa: BLE001 — keep going through the table
        neutral = []
        notes.append(f"I failed: {exc}")
    time.sleep(0.25)
    visible = sum(1 for line in neutral if line["visible"])
    ionic: list[dict] = []
    if visible < 3:
        try:
            ionic = _parse(_fetch(f"{symbol} II"), symbol, "II")
        except Exception as exc:  # noqa: BLE001
            notes.append(f"II failed: {exc}")
        time.sleep(0.25)
    picked = _pick(neutral + ionic)
    return z, picked, "; ".join(notes)


def main() -> None:
    pack = json.loads(CATALOG.read_text(encoding="utf-8"))
    elements = [(el["z"], el["symbol"]) for el in pack["elements"]]
    found: dict[str, list[dict]] = {}
    empty: list[str] = []
    with ThreadPoolExecutor(max_workers=3) as pool:
        futures = {pool.submit(_one, z, symbol): (z, symbol) for z, symbol in elements}
        for future in as_completed(futures):
            z, symbol = futures[future]
            _, lines, note = future.result()
            found[str(z)] = lines
            flag = note or ("empty" if not lines else f"{len(lines)} lines")
            print(f"{z:3} {symbol:3} {flag}", flush=True)
            if not lines:
                empty.append(f"{symbol} ({z})")
    payload = {
        "source": "NIST Atomic Spectra Database",
        "retrieved": "2026-10-11",
        "note": "Observed air wavelengths. Teaching subset of the strongest lines, not a full spectrum.",
        "elements": {z: found[z] for z in sorted(found, key=int)},
    }
    OUT.write_text(json.dumps(payload, indent=2), encoding="utf-8")
    print("wrote", OUT)
    print("empty:", ", ".join(empty) if empty else "none")


if __name__ == "__main__":
    main()
