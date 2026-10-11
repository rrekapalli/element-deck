"""Public-domain and CC0 photos for the Uses tab.

Only licenses that need no permission are kept: public domain and CC0.
A use with no picture is still listed. The frame is omitted.
"""

from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
USE_DIR = ROOT / "assets" / "uses"

# key -> (Commons file title, short credit)
SOURCES: dict[str, tuple[str, str]] = {
    "sun": (
        "The Sun by the Atmospheric Imaging Assembly of NASA's Solar Dynamics Observatory - 20100819.jpg",
        "NASA / SDO, public domain",
    ),
    "water": ("Water droplet 1.jpg", "CC0"),
    "earth": ("The Earth seen from Apollo 17.jpg", "NASA, public domain"),
    "ammonia": ("Gas cylinder ammonia.jpg", "Public domain"),
    "halite": ("Halite09.jpg", "Public domain"),
    "copper": ("Native copper.jpg", "Public domain"),
    "gold": ("Native gold nuggets.jpg", "Public domain"),
    "diamond": ("Rough diamond.jpg", "Public domain"),
    "graphite": ("GraphiteUSGOV.jpg", "U.S. government, public domain"),
    "sulfur": ("Sulfur-sample.jpg", "Public domain"),
    "sand": ("Sand.jpg", "Public domain"),
    "wafer": ("Silicon wafer.jpg", "Public domain"),
    "toothpaste": ("Toothpaste.jpg", "Public domain"),
    "mercury": ("Mercury-element.jpg", "Public domain"),
    "mri": ("MRI machine.jpg", "CC0"),
    "iron": ("Taconite.jpg", "Public domain"),
    "uranium": ("UraniumUSGOV.jpg", "U.S. government, public domain"),
    "bulb": ("Light bulb Edison 2.jpg", "Public domain"),
    "fireworks": (
        "July 4th fireworks, Washington, D.C. (LOC).jpg",
        "Library of Congress, public domain",
    ),
    "lithium": ("Lithium Mining, Nevada (ASTER).jpg", "NASA / METI / AIST / Japan Space Systems, public domain"),
    "aircraft": ("NASA 737 research aircraft.jpg", "NASA, public domain"),
}


def attach(key: str | None) -> tuple[str | None, str | None]:
    if not key or key not in SOURCES:
        return None, None
    path = USE_DIR / f"{key}.jpg"
    if not path.is_file() or path.stat().st_size < 1000:
        return None, None
    return f"assets/uses/{key}.jpg", SOURCES[key][1]
