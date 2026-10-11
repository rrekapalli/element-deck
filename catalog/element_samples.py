"""One picture of each element, with an honest caption.

Photographs are public domain, CC0, CC BY, CC BY-SA, or the Free Art License.
The credit is shown on the card. Fair-use files are never included.

A few elements have no free photograph of a visible sample. Those cards use
measured emission lines, or a plain note that no sample has been photographed.
"""

from __future__ import annotations

import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SAMPLE_DIR = ROOT / "assets" / "samples"
MANIFEST = Path(__file__).resolve().parent / "sample_manifest.json"

# Commons file when it is not the usual File:{Symbol},{Z}.jpg sample.
SPECIAL_FILES: dict[int, str] = {
    43: "File:Technetium (Element - 43).jpg",
    61: "File:Promethium-147 solution.jpg",
    84: "File:Polonium on brass sheet.jpg",
    85: "File:Glow from a sample of astatine (cropped).jpg",
    88: "File:Radium226.jpg",
    89: "File:Actinium sample (31481701837).png",
    90: "File:Thorium sample 0.1g.jpg",
    91: "File:Protactinium (Element - 91) 2.jpg",
    93: "File:Np sphere.jpg",
    94: "File:Pu,94.jpg",
    95: "File:Americium.jpg",
    97: "File:Berkelium.jpg",
    99: "File:Einsteinium.jpg",
    100: "File:Fermium-Ytterbium Alloy.jpg",
}

# Measured lines in this pack, and no free photograph of a sample.
SPECTRUM = {86, 87, 96}

# Made a few atoms at a time. No photograph, and no curated line list to draw.
UNSEEN = set(range(101, 119))

# LicenseShortName on this file is the misleading word "Attribution".
# The Commons permission text and the PD-LosAlamos category make it public domain.
CREDIT_OVERRIDE = {
    94: "United States Department of Energy, public domain",
}


def _n(name: str) -> str:
    return name[:1].lower() + name[1:] if name else name


def caption(z: int, name: str, state: str) -> tuple[str, str]:
    """Card title and body. The body says what the picture actually is."""
    n = _n(name)
    special = {
        43: (
            "A tiny sample",
            "Technetium has no stable form, so a visible piece is rare. "
            "The vial holds a very small sample of the element, next to a radiation marker. "
            "It is the element itself, not a mineral.",
        ),
        61: (
            "A sample in solution",
            "Promethium metal is almost never isolated. This tube holds a solution of "
            "promethium-147, the form in which a real sample is usually kept. "
            "The pink color belongs to that solution, not to a lump of metal.",
        ),
        84: (
            "A thin deposit",
            "Polonium is so radioactive that a lump of the pure metal is rarely kept. "
            "This sealed piece is polonium deposited on a small brass sheet, "
            "which is how a visible sample of the element is handled.",
        ),
        85: (
            "Light from a tiny sample",
            "Astatine has never been gathered into a piece large enough to see as a solid or a liquid. "
            "The blue glow is light from a microscopic sample of the element. "
            "The empty vial beside it is only there for scale.",
        ),
        88: (
            "A tiny radium source",
            "Pure radium metal is rarely photographed. This sliver, about 1.5 by 3 millimetres, "
            "is a radium-226 source of the kind once fitted to a Geiger counter. "
            "It is a real sample of the element, not a drawing.",
        ),
        89: (
            "A sample that glows",
            "Actinium is intensely radioactive, and a visible sample glows from its own radiation. "
            "This vial holds a small amount of the element in solution. "
            "The blue light is the sample, not a lamp behind the glass.",
        ),
        90: (
            "The pure element",
            "A tenth of a gram of thorium metal, sealed in glass. Thorium is a soft, dense metal. "
            "This square is the element itself, not the oxide used in old gas mantles.",
        ),
        91: (
            "A very small sample",
            "Protactinium is scarce, and a photograph usually shows a speck rather than an ingot. "
            "The dark fragment in the tube is a sample of the element.",
        ),
        93: (
            "The pure element",
            "A sphere of neptunium metal, the element by itself. Neptunium is made in reactors. "
            "The bowls around the sphere belong to the laboratory setup, not to more of the metal.",
        ),
        94: (
            "The pure element",
            "A button of plutonium metal. The surface looks dull because the metal reacts with air. "
            "This is the element itself, photographed in a laboratory.",
        ),
        95: (
            "The pure element",
            "A small piece of americium metal in a sealed vial. Americium is a silvery metal made in reactors. "
            "The photograph shows the element, not the oxide used in smoke detectors.",
        ),
        97: (
            "A sample in solution",
            "Berkelium has been prepared as a metal, but the clearest free photograph is of a solution. "
            "The green drop in the capillary is a real berkelium sample, small enough to sit in a glass tip.",
        ),
        98: (
            "The pure element",
            "A disk of californium metal. Only a tiny amount has ever been isolated, "
            "and this photograph shows that piece rather than a compound.",
        ),
        99: (
            "A sample that glows",
            "Einsteinium is so radioactive that a visible sample glows by itself. "
            "The blue-white light in the tube is the sample. It is not a lamp, and it is not a large ingot.",
        ),
        100: (
            "An alloy, not a pure lump",
            "Pure fermium metal has not been isolated as a piece you can photograph. "
            "The visible sample that has been made is an alloy of fermium with ytterbium. This disk is that alloy.",
        ),
        86: (
            "Light from the element",
            "Radon is a colorless gas, and there is no free photograph of a sealed sample. "
            "The colored lines are light radon atoms give off, taken from measured wavelengths. "
            "They are not a picture of a bottle of the gas.",
        ),
        87: (
            "Light from the element",
            "Francium has never been collected into a piece large enough to photograph. "
            "The colored lines are light francium atoms give off, taken from measured wavelengths. "
            "They are not a drawing of a metal.",
        ),
        96: (
            "Light from the element",
            "Photographs of curium metal are not free to reuse. "
            "The violet lines are light curium atoms give off, from a short public list of measured wavelengths. "
            "They sit close together, so they look like one band.",
        ),
    }
    if z in special:
        return special[z]
    if z in UNSEEN:
        return (
            "No sample to photograph",
            f"{name} is made a few atoms at a time, and those atoms disappear before anyone can collect a visible piece. "
            "There is no photograph of the pure element, and this pack does not draw a pretend lump of metal.",
        )
    if state == "gas":
        return (
            "The pure element",
            f"Pure {n}, sealed in glass. The gas has no color of its own, so the sample looks like a clear tube. "
            "This is the element by itself, not a compound.",
        )
    if state == "liquid":
        return (
            "The pure element",
            f"Pure {n}, the liquid form of the element, sealed for the photograph. "
            "This is the element by itself, not a compound or an ore.",
        )
    return (
        "The pure element",
        f"Pure {n}, the element by itself rather than an ore or a compound. "
        "The piece in the photograph is a laboratory sample.",
    )


def load_manifest() -> dict[int, dict]:
    if not MANIFEST.is_file():
        raise SystemExit("missing catalog/sample_manifest.json; run catalog/fetch_element_samples.py")
    raw = json.loads(MANIFEST.read_text(encoding="utf-8"))
    return {int(z): row for z, row in raw.items()}


def sample_for(z: int, name: str, state: str) -> dict:
    row = load_manifest()[z]
    image = row["image"]
    path = ROOT / image
    if not path.is_file() or path.stat().st_size < 1000:
        raise SystemExit(f"sample image missing for Z={z}: {image}")
    title, body = caption(z, name, state)
    return {
        "title": title,
        "body": body,
        "image": image,
        "credit": row["credit"],
    }
