#!/usr/bin/env python3
"""Compile core.json to catalog.sqlite for Firebase Storage."""
from __future__ import annotations

import json
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SRC = ROOT / "assets" / "catalog" / "core.json"
OUT = ROOT / "catalog" / "output" / "catalog.sqlite"


def main() -> None:
    pack = json.loads(SRC.read_text(encoding="utf-8"))
    OUT.parent.mkdir(parents=True, exist_ok=True)
    if OUT.exists():
        OUT.unlink()
    db = sqlite3.connect(OUT)
    db.executescript(
        """
        CREATE TABLE pack_meta (
          id TEXT PRIMARY KEY,
          version TEXT NOT NULL,
          science_pins TEXT NOT NULL
        );
        CREATE TABLE elements (
          z INTEGER PRIMARY KEY,
          json TEXT NOT NULL
        );
        CREATE TABLE trend_notes (
          z_a INTEGER NOT NULL,
          z_b INTEGER NOT NULL,
          json TEXT NOT NULL
        );
        """
    )
    db.execute(
        "INSERT INTO pack_meta VALUES (?,?,?)",
        (pack["id"], pack["version"], json.dumps(pack["sciencePins"])),
    )
    for el in pack["elements"]:
        db.execute("INSERT INTO elements VALUES (?,?)", (el["z"], json.dumps(el)))
    for note in pack.get("trendNotes", []):
        db.execute(
            "INSERT INTO trend_notes VALUES (?,?,?)",
            (note["zA"], note["zB"], json.dumps(note)),
        )
    db.commit()
    db.close()
    print("wrote", OUT, "bytes", OUT.stat().st_size)


if __name__ == "__main__":
    main()
