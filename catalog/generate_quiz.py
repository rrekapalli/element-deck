#!/usr/bin/env python3
"""Write 50 catalog-grounded quiz questions per element per learning depth."""
from __future__ import annotations

import hashlib
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent
CORE = ROOT.parent / "assets" / "catalog" / "core.json"
OUT = ROOT.parent / "assets" / "catalog" / "quiz"
CURATED = ROOT / "quiz_curated"

DEPTHS = ("beginner", "intermediate", "advanced")
POOL = 50
NUM_RE = re.compile(r"-?\d+(?:\.\d+)?")

CAT_IDENTITY = "identity"
CAT_ELECTRON = "electron_orbitals"
CAT_NUCLEI = "protons_nuclei"
CAT_PHYSICAL = "physical_properties"
CAT_USES = "engineering_uses"
CAT_HISTORY = "discovery_history"
CAT_LIGHT = "light_reactions"
CAT_NEIGHBOR = "neighbor_compare"

LABEL = {
    "reactive-nonmetal": "reactive nonmetal",
    "noble-gas": "noble gas",
    "alkali-metal": "alkali metal",
    "alkaline-earth": "alkaline earth metal",
    "transition-metal": "transition metal",
    "post-transition": "post-transition metal",
    "metalloid": "metalloid",
    "lanthanide": "lanthanide",
    "actinide": "actinide",
}


def h_int(*parts: object) -> int:
    raw = "|".join(str(p) for p in parts).encode()
    return int(hashlib.sha256(raw).hexdigest()[:12], 16)


def pick(seq: list, *seed: object, n: int = 3) -> list:
    if not seq:
        return []
    indexed = list(seq)
    indexed.sort(key=lambda item: h_int(*seed, getattr(item, "get", lambda k, d=None: item)("z") if isinstance(item, dict) else item))
    out = []
    for item in indexed:
        if item in out:
            continue
        out.append(item)
        if len(out) >= n:
            break
    return out


def others(elements: list[dict], z: int, n: int = 8) -> list[dict]:
    pool = [e for e in elements if e["z"] != z]
    pool.sort(key=lambda e: h_int(z, e["z"]))
    return pool[:n]


def same_group(elements: list[dict], el: dict) -> list[dict]:
    g = el.get("group")
    if g is None:
        return []
    return [e for e in elements if e.get("group") == g and e["z"] != el["z"]]


def same_period(elements: list[dict], el: dict) -> list[dict]:
    return [e for e in elements if e["period"] == el["period"] and e["z"] != el["z"]]


def add_num(nums: set, value) -> None:
    if value is None:
        return
    if isinstance(value, bool):
        return
    if isinstance(value, int):
        nums.add(value)
        nums.add(float(value))
        return
    if isinstance(value, float):
        nums.add(value)
        if value.is_integer():
            nums.add(int(value))
        rounded = round(value, 3)
        nums.add(rounded)
        if rounded.is_integer():
            nums.add(int(rounded))
        return
    if isinstance(value, str):
        for token in NUM_RE.findall(value):
            add_num(nums, float(token) if "." in token else int(token))


def allowed_numbers(el: dict) -> set:
    nums: set = set()
    add_num(nums, el["z"])
    add_num(nums, el["atomicWeight"])
    add_num(nums, el["period"])
    add_num(nums, el.get("group"))
    add_num(nums, el.get("primaryOxidation"))
    for n in el.get("shellCounts") or []:
        add_num(nums, n)
    for n in el.get("oxidationStates") or []:
        add_num(nums, n)
    props = el.get("properties") or {}
    for key in props:
        add_num(nums, props[key])
    disc = el.get("discovery") or {}
    add_num(nums, disc.get("year"))
    for iso in el.get("isotopes") or []:
        add_num(nums, iso.get("a"))
        add_num(nums, iso.get("mass"))
        add_num(nums, iso.get("abundance"))
        if iso.get("a") is not None:
            add_num(nums, iso["a"] - el["z"])
    for line in el.get("spectralLines") or []:
        add_num(nums, line.get("nm"))
        add_num(nums, line.get("eV"))
        if line.get("nm") is not None:
            add_num(nums, round(line["nm"]))
            add_num(nums, round(line["nm"], 2))
    add_num(nums, el.get("electronConfig"))
    add_num(nums, el.get("electronConfigFull"))
    add_num(nums, el.get("lattice"))
    glow = el.get("glow") or {}
    add_num(nums, glow.get("kv"))
    reaction = el.get("reaction") or {}
    add_num(nums, reaction.get("reactants"))
    add_num(nums, reaction.get("products"))
    return nums


def numbers_ok(text: str, allowed: set) -> bool:
    for token in NUM_RE.findall(text):
        value = float(token) if "." in token else int(token)
        if isinstance(value, int):
            if value in allowed or float(value) in allowed:
                continue
            return False
        if any(isinstance(a, (int, float)) and abs(float(a) - value) < 1e-6 for a in allowed):
            continue
        return False
    return True


def make_item(
    qid: str,
    category: str,
    stem: str,
    correct: str,
    distractors: list[str],
    explanation: str,
    allowed: set,
    equation: str | None = None,
) -> dict | None:
    opts = [correct] + [d for d in distractors if d != correct]
    unique: list[str] = []
    for o in opts:
        o = o.strip()
        if not o or o in unique:
            continue
        unique.append(o)
    if len(unique) < 4 or unique[0] != correct.strip():
        return None
    unique = unique[:4]
    if not numbers_ok(unique[0], allowed):
        return None
    if not explanation.strip():
        return None
    rot = h_int(qid) % 4
    rotated = unique[rot:] + unique[:rot]
    return {
        "id": qid,
        "category": category,
        "stem": stem,
        "options": rotated,
        "correctIndex": rotated.index(unique[0]),
        "explanation": explanation.strip(),
        **({"equation": equation} if equation else {}),
    }


def ox_text(states: list[int], primary: int | None, depth: str) -> str:
    if not states:
        return ""
    bits = [f"{n:+d}" if n != 0 else "0" for n in states]
    joined = ", ".join(bits)
    if depth == "beginner":
        if primary is not None:
            word = f"{primary:+d}" if primary != 0 else "0"
            return f"often forms a {word} ion"
        return f"oxidation numbers {joined}"
    if depth == "advanced" and primary is not None:
        mark = f"{primary:+d}" if primary != 0 else "0"
        return f"{joined} (common {mark})"
    return joined


def shells_text(counts: list[int]) -> str:
    return ", ".join(str(n) for n in counts)


def config_for(el: dict, depth: str) -> str:
    if depth == "beginner":
        return shells_text(el.get("shellCounts") or [])
    if depth == "advanced":
        return el.get("electronConfigFull") or el.get("electronConfig") or ""
    return el.get("electronConfig") or ""


def first_sentence(text: str) -> str:
    text = (text or "").replace("\n", " ").strip()
    if not text:
        return ""
    cut = text.find(". ")
    if cut == -1:
        return text[:160]
    return text[: cut + 1]


def stem_for(depth: str, beginner: str, course: str, advanced: str) -> str:
    if depth == "beginner":
        return beginner
    if depth == "advanced":
        return advanced
    return course


def build_questions(el: dict, elements: list[dict], depth: str) -> list[dict]:
    z = el["z"]
    name = el["name"]
    symbol = el["symbol"]
    allowed = allowed_numbers(el)
    by_z = {e["z"]: e for e in elements}
    alt = others(elements, z, 12)
    names = [e["name"] for e in alt]
    symbols = [e["symbol"] for e in alt]
    zs = [str(e["z"]) for e in alt]
    items: list[dict] = []

    def add(item: dict | None) -> None:
        if item:
            items.append(item)

    add(
        make_item(
            f"{z}-{depth}-z",
            CAT_IDENTITY,
            stem_for(
                depth,
                f"How many protons does a {name} atom have? (That number is also its place on the table.)",
                f"What is the atomic number of {name}?",
                f"Z for {name} ({symbol}) is:",
            ),
            str(z),
            zs,
            f"{name} is element {z}. A neutral atom has {z} protons and {z} electrons.",
            allowed,
        )
    )
    add(
        make_item(
            f"{z}-{depth}-symbol",
            CAT_IDENTITY,
            stem_for(
                depth,
                f"What is the chemical symbol for {name}?",
                f"Which symbol stands for {name}?",
                f"The catalog symbol for Z = {z} is:",
            ),
            symbol,
            symbols,
            f"The catalog writes {name} as {symbol}.",
            allowed,
        )
    )
    add(
        make_item(
            f"{z}-{depth}-name",
            CAT_IDENTITY,
            stem_for(
                depth,
                f"Which element has the symbol {symbol}?",
                f"Element {symbol} is named:",
                f"Z = {z} is the dossier for:",
            ),
            name,
            names,
            f"{symbol} is {name}, atomic number {z}.",
            allowed,
        )
    )
    add(
        make_item(
            f"{z}-{depth}-period",
            CAT_IDENTITY,
            stem_for(
                depth,
                f"Which row of the table holds {name}? (Rows are called periods.)",
                f"What is the period of {name}?",
                f"{symbol} sits in period:",
            ),
            str(el["period"]),
            [str(e["period"]) for e in alt if e["period"] != el["period"]]
            + ["1", "2", "3", "5", "6", "7"],
            f"{name} is in period {el['period']} (row {el['period']} of the table).",
            allowed,
        )
    )
    if el.get("group") is not None:
        add(
            make_item(
                f"{z}-{depth}-group",
                CAT_IDENTITY,
                stem_for(
                    depth,
                    f"Which column of the table holds {name}? (Columns are called groups.)",
                    f"What is the IUPAC group of {name}?",
                    f"{symbol} is assigned group:",
                ),
                str(el["group"]),
                [str(e["group"]) for e in alt if e.get("group") not in (None, el["group"])]
                + ["1", "2", "14", "17", "18"],
                f"{name} is in group {el['group']}.",
                allowed,
            )
        )
    else:
        add(
            make_item(
                f"{z}-{depth}-group-none",
                CAT_IDENTITY,
                f"How does this catalog place {name} on an IUPAC group number?",
                "No IUPAC group in this catalog",
                ["1", "3", "18"],
                f"{name} is an f-block element in this catalog without an IUPAC group number.",
                allowed,
            )
        )
    add(
        make_item(
            f"{z}-{depth}-block",
            CAT_IDENTITY,
            stem_for(
                depth,
                f"Which block of the table contains {name}? (Blocks are s, p, d, or f.)",
                f"What is the block of {name}?",
                f"{symbol} is a {el['block']}-block element. Which block?",
            ),
            el["block"],
            [b for b in ("s", "p", "d", "f") if b != el["block"]],
            f"{name} is in the {el['block']} block.",
            allowed,
        )
    )
    cat_label = el.get("categoryLabel") or LABEL.get(el["categoryId"], el["categoryId"])
    add(
        make_item(
            f"{z}-{depth}-family",
            CAT_IDENTITY,
            stem_for(
                depth,
                f"What kind of element is {name} on this table?",
                f"Which family label does the catalog give {name}?",
                f"{symbol} is classified as:",
            ),
            cat_label,
            list(
                dict.fromkeys(
                    e.get("categoryLabel") or LABEL.get(e["categoryId"], e["categoryId"])
                    for e in alt
                    if e["categoryId"] != el["categoryId"]
                )
            ),
            f"{name} is listed as a {cat_label.lower()}.",
            allowed,
        )
    )
    add(
        make_item(
            f"{z}-{depth}-state",
            CAT_IDENTITY,
            stem_for(
                depth,
                f"At room temperature, {name} is a:",
                f"What is the standard state of {name}?",
                f"The catalog standard state of {symbol} is:",
            ),
            el["standardState"],
            [s for s in ("solid", "liquid", "gas") if s != el["standardState"]]
            + ["plasma"],
            f"{name} is a {el['standardState']} at the catalog's standard temperature.",
            allowed,
        )
    )
    add(
        make_item(
            f"{z}-{depth}-mass",
            CAT_IDENTITY,
            stem_for(
                depth,
                f"About how heavy is a {name} atom, in the catalog's atomic-weight number?",
                f"What standard atomic weight does the catalog list for {name}?",
                f"Atomic weight of {symbol} in this pack:",
            ),
            str(el["atomicWeight"]),
            [str(e["atomicWeight"]) for e in alt],
            f"The catalog atomic weight of {name} is {el['atomicWeight']}.",
            allowed,
        )
    )
    if el.get("lattice"):
        add(
            make_item(
                f"{z}-{depth}-lattice",
                CAT_PHYSICAL,
                stem_for(
                    depth,
                    f"How are the atoms packed in solid {name}, according to this catalog?",
                    f"What crystal lattice does the catalog list for {name}?",
                    f"Lattice recorded for {symbol}:",
                ),
                el["lattice"],
                [e["lattice"] for e in alt if e.get("lattice") and e["lattice"] != el["lattice"]],
                f"{name} is listed with a {el['lattice']} lattice.",
                allowed,
            )
        )
    if "halogen" in (el.get("tags") or []):
        add(
            make_item(
                f"{z}-{depth}-halogen",
                CAT_IDENTITY,
                f"Which tag does this catalog apply to {name}?",
                "halogen",
                ["noble gas", "alkali metal", "lanthanide"],
                f"{name} carries the halogen tag.",
                allowed,
            )
        )

    shells = el.get("shellCounts") or []
    if shells:
        add(
            make_item(
                f"{z}-{depth}-shells",
                CAT_ELECTRON,
                stem_for(
                    depth,
                    f"How many electrons sit in each shell of {name}, from the inside out?",
                    f"What shell counts does the catalog list for {name}?",
                    f"Principal-shell occupancy of {symbol}:",
                ),
                shells_text(shells),
                [shells_text(e.get("shellCounts") or []) for e in alt if e.get("shellCounts")],
                f"{name} has shell counts {shells_text(shells)}. Neutral {name} has {z} electrons in all.",
                allowed,
            )
        )
        add(
            make_item(
                f"{z}-{depth}-nshells",
                CAT_ELECTRON,
                f"How many electron shells does the catalog draw for {name}?",
                str(len(shells)),
                [str(n) for n in range(1, 8) if n != len(shells)],
                f"{name} is drawn with {len(shells)} shell{'s' if len(shells) != 1 else ''}.",
                allowed,
            )
        )
        add(
            make_item(
                f"{z}-{depth}-valence",
                CAT_ELECTRON,
                stem_for(
                    depth,
                    f"How many electrons sit in the outer shell of {name}?",
                    f"What is the outermost shell count for {name}?",
                    f"Valence-shell occupancy of {symbol} in this dossier:",
                ),
                str(shells[-1]),
                [str(e["shellCounts"][-1]) for e in alt if e.get("shellCounts")]
                + [str(n) for n in (1, 2, 4, 8) if n != shells[-1]],
                f"The last shell of {name} holds {shells[-1]} electron{'s' if shells[-1] != 1 else ''}.",
                allowed,
            )
        )
        for i, count in enumerate(shells):
            add(
                make_item(
                    f"{z}-{depth}-shell-{i + 1}",
                    CAT_ELECTRON,
                    f"How many electrons are in shell {i + 1} of {name} (counting from the nucleus)?",
                    str(count),
                    [str(n) for n in (1, 2, 8, 18, 32) if n != count]
                    + [str((e.get("shellCounts") or [0])[min(i, len(e.get("shellCounts") or [1]) - 1)] ) for e in alt],
                    f"Shell {i + 1} of {name} holds {count} electrons.",
                    allowed,
                )
            )

    cfg = config_for(el, depth)
    if cfg:
        add(
            make_item(
                f"{z}-{depth}-config",
                CAT_ELECTRON,
                stem_for(
                    depth,
                    f"Which electron picture matches {name} at this learning mode?",
                    f"Which configuration does the catalog give {name}?",
                    f"Ground-state configuration of {symbol}:",
                ),
                cfg,
                [
                    config_for(e, depth)
                    for e in alt
                    if config_for(e, depth) and config_for(e, depth) != cfg
                ],
                f"At this depth the catalog writes {name} as {cfg}.",
                allowed,
            )
        )
    ox = el.get("oxidationStates") or []
    if ox:
        text = ox_text(ox, el.get("primaryOxidation"), depth)
        add(
            make_item(
                f"{z}-{depth}-ox",
                CAT_ELECTRON,
                stem_for(
                    depth,
                    f"How does {name} usually change when it forms ions, in this catalog?",
                    f"Which oxidation states does the catalog list for {name}?",
                    f"Oxidation states recorded for {symbol}:",
                ),
                text,
                [
                    ox_text(e.get("oxidationStates") or [], e.get("primaryOxidation"), depth)
                    for e in alt
                    if e.get("oxidationStates")
                ],
                f"{name}: {text}.",
                allowed,
            )
        )
        if el.get("primaryOxidation") is not None:
            p = el["primaryOxidation"]
            add(
                make_item(
                    f"{z}-{depth}-ox-primary",
                    CAT_ELECTRON,
                    stem_for(
                        depth,
                        f"Which charge does {name} take most often in compounds, according to this dossier?",
                        f"What is the primary oxidation state of {name}?",
                        f"The common oxidation state marked for {symbol} is:",
                    ),
                    f"{p:+d}" if p != 0 else "0",
                    [f"{e['primaryOxidation']:+d}" if e.get("primaryOxidation") else "+1" for e in alt]
                    + ["+1", "+2", "-1", "+7"],
                    f"The catalog marks {p:+d} as the usual oxidation state of {name}."
                    if p != 0
                    else f"The catalog marks 0 as the usual oxidation state of {name}.",
                    allowed,
                )
            )

    isotopes = el.get("isotopes") or []
    if isotopes:
        main = isotopes[0]
        add(
            make_item(
                f"{z}-{depth}-iso-a",
                CAT_NUCLEI,
                stem_for(
                    depth,
                    f"One isotope of {name} in this catalog has mass number:",
                    f"What mass number A does the first listed isotope of {name} have?",
                    f"The first nuclide listed for {symbol} has A =",
                ),
                str(main["a"]),
                [str(e["isotopes"][0]["a"]) for e in alt if e.get("isotopes")]
                + [str(main["a"] + d) for d in (1, 2, -1, 4) if main["a"] + d > 0],
                f"The catalog lists {name}-{main['a']} first (A = {main['a']}).",
                allowed,
            )
        )
        neutrons = main["a"] - z
        add(
            make_item(
                f"{z}-{depth}-neutrons",
                CAT_NUCLEI,
                stem_for(
                    depth,
                    f"How many neutrons are in {name}-{main['a']}? (Neutrons = mass number minus protons.)",
                    f"Neutron count in the first listed isotope of {name}:",
                    f"N = A − Z for {symbol}-{main['a']} is:",
                ),
                str(neutrons),
                [str(abs((e["isotopes"][0]["a"] - e["z"]))) for e in alt if e.get("isotopes")]
                + [str(max(0, neutrons + d)) for d in (1, 2, -2, 4)],
                f"{name}-{main['a']} has {main['a']} − {z} = {neutrons} neutrons.",
                allowed,
            )
        )
        add(
            make_item(
                f"{z}-{depth}-iso-stable",
                CAT_NUCLEI,
                f"How does the catalog classify {name}-{main['a']}?",
                main.get("stability") or "unknown",
                [
                    s
                    for s in ("stable", "trace radioisotope", "synthetic", "unknown")
                    if s != main.get("stability")
                ],
                f"{name}-{main['a']} is listed as {main.get('stability')}.",
                allowed,
            )
        )
        if main.get("spin"):
            add(
                make_item(
                    f"{z}-{depth}-iso-spin",
                    CAT_NUCLEI,
                    f"What nuclear spin does the catalog list for {name}-{main['a']}?",
                    str(main["spin"]),
                    [
                        str(e["isotopes"][0].get("spin"))
                        for e in alt
                        if e.get("isotopes") and e["isotopes"][0].get("spin")
                    ]
                    + ["0", "1/2", "1", "3/2"],
                    f"{name}-{main['a']} is listed with spin {main['spin']}.",
                    allowed,
                )
            )
        add(
            make_item(
                f"{z}-{depth}-n-iso",
                CAT_NUCLEI,
                f"How many isotopes does this catalog list for {name}?",
                str(len(isotopes)),
                [str(n) for n in range(1, 12) if n != len(isotopes)],
                f"The pack lists {len(isotopes)} isotope{'s' if len(isotopes) != 1 else ''} of {name}.",
                allowed,
            )
        )
        for i, iso in enumerate(isotopes[1:6], start=2):
            add(
                make_item(
                    f"{z}-{depth}-iso-{i}-a",
                    CAT_NUCLEI,
                    f"Another listed isotope of {name} has mass number:",
                    str(iso["a"]),
                    [str(x["a"]) for x in isotopes if x["a"] != iso["a"]]
                    + [str(e["isotopes"][0]["a"]) for e in alt if e.get("isotopes")],
                    f"The catalog also lists {name}-{iso['a']}.",
                    allowed,
                )
            )
            add(
                make_item(
                    f"{z}-{depth}-iso-{i}-n",
                    CAT_NUCLEI,
                    f"How many neutrons are in {name}-{iso['a']}?",
                    str(iso["a"] - z),
                    [str(abs(x["a"] - z)) for x in isotopes if x["a"] != iso["a"]]
                    + [str(iso["a"] - z + d) for d in (1, 2, -1) if iso["a"] - z + d >= 0],
                    f"{name}-{iso['a']} has {iso['a'] - z} neutrons.",
                    allowed,
                )
            )

    origin = first_sentence(el.get("cosmicOrigin") or "")
    if origin:
        add(
            make_item(
                f"{z}-{depth}-origin",
                CAT_NUCLEI,
                stem_for(
                    depth,
                    f"Where does the catalog say {name} was made before Earth existed?",
                    f"Which cosmic-origin note belongs to {name}?",
                    f"Nucleosynthesis note for {symbol}:",
                ),
                origin,
                [
                    first_sentence(e.get("cosmicOrigin") or "")
                    for e in alt
                    if first_sentence(e.get("cosmicOrigin") or "")
                    and first_sentence(e.get("cosmicOrigin") or "") != origin
                ],
                origin,
                allowed,
            )
        )

    props = el.get("properties") or {}
    prop_meta = [
        ("covalentRadiusPm", CAT_PHYSICAL, "covalent radius", "pm", "radius"),
        ("paulingEn", CAT_PHYSICAL, "Pauling electronegativity", "", "en"),
        ("ionizationEv", CAT_PHYSICAL, "first ionization energy", "eV", "ie"),
        ("meltingK", CAT_PHYSICAL, "melting point", "K", "mp"),
        ("boilingK", CAT_PHYSICAL, "boiling point", "K", "bp"),
        ("density", CAT_PHYSICAL, "density", "g/cm³", "density"),
    ]
    for key, cat, label, unit, slug in prop_meta:
        value = props.get(key)
        if value is None:
            continue
        shown = str(value)
        unit_bit = f" {unit}" if unit else ""
        add(
            make_item(
                f"{z}-{depth}-{slug}",
                cat,
                stem_for(
                    depth,
                    f"What {label} does this catalog list for {name}?",
                    f"Catalog {label} of {name}:",
                    f"{label.capitalize()} of {symbol}:",
                ),
                f"{shown}{unit_bit}".strip(),
                [
                    f"{e.get('properties', {}).get(key)}{unit_bit}".strip()
                    for e in alt
                    if e.get("properties", {}).get(key) is not None
                    and e.get("properties", {}).get(key) != value
                ],
                f"{name} has {label} {shown}{unit_bit} in this pack.".strip(),
                allowed,
            )
        )
        # Neighbor comparisons
        neighbors = [e for e in alt if e.get("properties", {}).get(key) is not None]
        if neighbors:
            other = neighbors[0]
            ov = other["properties"][key]
            if ov != value:
                if value > ov:
                    correct = f"{name} is larger"
                    why = f"{name} ({shown}) is larger than {other['name']} ({ov})."
                else:
                    correct = f"{other['name']} is larger"
                    why = f"{other['name']} ({ov}) is larger than {name} ({shown})."
                add(
                    make_item(
                        f"{z}-{depth}-{slug}-cmp",
                        CAT_NEIGHBOR,
                        f"Compare catalog {label}: {name} vs {other['name']}. Which is larger?",
                        correct,
                        [
                            f"{name} is larger" if correct != f"{name} is larger" else f"{other['name']} is larger",
                            "They are listed as equal",
                            "Neither value is reported",
                        ],
                        why,
                        allowed,
                    )
                )

    apps = el.get("applications") or []
    if apps:
        for i, app in enumerate(apps[:4]):
            title = app.get("title") or ""
            if not title:
                continue
            add(
                make_item(
                    f"{z}-{depth}-use-{i}",
                    CAT_USES,
                    stem_for(
                        depth,
                        f"Which of these is a listed use of {name}?",
                        f"Which application title belongs to {name}?",
                        f"A catalogued use of {symbol}:",
                    ),
                    title,
                    [
                        (e.get("applications") or [{}])[0].get("title") or ""
                        for e in alt
                        if e.get("applications")
                    ]
                    + ["Fuel for fusion reactors", "Room-temperature superconductor wire"],
                    (app.get("body") or title).strip(),
                    allowed,
                )
            )
        if apps[0].get("body"):
            add(
                make_item(
                    f"{z}-{depth}-use-body",
                    CAT_USES,
                    f"Which sentence is the catalog's note on {name} and {apps[0]['title']}?",
                    first_sentence(apps[0]["body"]),
                    [
                        first_sentence((e.get("applications") or [{}])[0].get("body") or "")
                        for e in alt
                        if e.get("applications")
                    ],
                    apps[0]["body"],
                    allowed,
                )
            )
    else:
        add(
            make_item(
                f"{z}-{depth}-use-none",
                CAT_USES,
                f"What does this catalog list as industrial uses of {name}?",
                "No curated industrial uses in this pack",
                [
                    "Aircraft skins",
                    "Table salt",
                    "Neon signs",
                ],
                f"This pack does not invent uses for {name}.",
                allowed,
            )
        )

    disc = el.get("discovery") or {}
    if disc.get("year"):
        add(
            make_item(
                f"{z}-{depth}-year",
                CAT_HISTORY,
                stem_for(
                    depth,
                    f"In which year does this catalog place the discovery of {name}?",
                    f"What discovery year is listed for {name}?",
                    f"Discovery year recorded for {symbol}:",
                ),
                str(disc["year"]),
                [
                    str(e.get("discovery", {}).get("year"))
                    for e in alt
                    if e.get("discovery", {}).get("year")
                    and e["discovery"]["year"] != disc["year"]
                ],
                f"{name} is listed as discovered in {disc['year']}.",
                allowed,
            )
        )
    if disc.get("people"):
        add(
            make_item(
                f"{z}-{depth}-people",
                CAT_HISTORY,
                stem_for(
                    depth,
                    f"Who does this catalog credit for finding {name}?",
                    f"Which people are listed on the discovery of {name}?",
                    f"Discovery credit for {symbol}:",
                ),
                disc["people"],
                [
                    e.get("discovery", {}).get("people") or ""
                    for e in alt
                    if e.get("discovery", {}).get("people")
                    and e["discovery"]["people"] != disc["people"]
                ],
                f"The catalog credits {disc['people']} for {name}.",
                allowed,
            )
        )
    hist = first_sentence(el.get("history") or "")
    if hist:
        add(
            make_item(
                f"{z}-{depth}-history",
                CAT_HISTORY,
                f"Which history line belongs to {name}?",
                hist,
                [first_sentence(e.get("history") or "") for e in alt],
                hist,
                allowed,
            )
        )
    found = first_sentence(el.get("howDiscovered") or "")
    if found:
        add(
            make_item(
                f"{z}-{depth}-found",
                CAT_HISTORY,
                f"How does the catalog describe the discovery of {name}?",
                found,
                [first_sentence(e.get("howDiscovered") or "") for e in alt],
                found,
                allowed,
            )
        )
    for i, story in enumerate((el.get("trivia") or [])[:5]):
        title = story.get("title") or ""
        if not title:
            continue
        add(
            make_item(
                f"{z}-{depth}-trivia-{i}",
                CAT_HISTORY,
                f"Which story title belongs to {name} in this catalog?",
                title,
                [
                    (e.get("trivia") or [{}])[0].get("title") or ""
                    for e in alt
                    if e.get("trivia")
                ],
                (story.get("summary") or title).strip(),
                allowed,
            )
        )

    glow = el.get("glow") or {}
    if glow.get("color"):
        add(
            make_item(
                f"{z}-{depth}-glow",
                CAT_LIGHT,
                stem_for(
                    depth,
                    f"What color does the catalog give the {name} discharge?",
                    f"Catalog glow color of {name}:",
                    f"Discharge color listed for {symbol}:",
                ),
                glow["color"],
                [
                    e.get("glow", {}).get("color") or ""
                    for e in alt
                    if e.get("glow", {}).get("color")
                ]
                + ["green", "violet", "white"],
                glow.get("text") or f"{name} is listed with a {glow['color']} glow.",
                allowed,
            )
        )
    lines = el.get("spectralLines") or []
    if lines:
        line = lines[0]
        nm = line["nm"]
        add(
            make_item(
                f"{z}-{depth}-line-nm",
                CAT_LIGHT,
                stem_for(
                    depth,
                    f"One listed emission line of {name} is near which wavelength?",
                    f"What wavelength (nm) is the first listed line of {name}?",
                    f"First packed line of {symbol} is at:",
                ),
                f"{nm} nm",
                [
                    f"{e['spectralLines'][0]['nm']} nm"
                    for e in alt
                    if e.get("spectralLines")
                ],
                f"The catalog lists a {name} line at {nm} nm"
                + (f" ({line.get('color')})." if line.get("color") else "."),
                allowed,
            )
        )
        if line.get("color"):
            add(
                make_item(
                    f"{z}-{depth}-line-color",
                    CAT_LIGHT,
                    f"What color name does the catalog give the {nm} nm line of {name}?",
                    line["color"],
                    ["red", "green", "blue", "violet", "yellow", "orange"],
                    f"That {name} line is labelled {line['color']}.",
                    allowed,
                )
            )
        add(
            make_item(
                f"{z}-{depth}-n-lines",
                CAT_LIGHT,
                f"How many spectral lines does this pack store for {name}?",
                str(len(lines)),
                [str(n) for n in (0, 1, 3, 8, 12, 20) if n != len(lines)]
                + [str(len(e.get("spectralLines") or [])) for e in alt],
                f"{name} has {len(lines)} stored line{'s' if len(lines) != 1 else ''}.",
                allowed,
            )
        )
    reaction = el.get("reaction")
    if reaction:
        add(
            make_item(
                f"{z}-{depth}-rxn-r",
                CAT_LIGHT,
                f"What reactants does the catalog show in the {name} reaction illustration?",
                reaction.get("reactants") or "",
                [
                    e.get("reaction", {}).get("reactants") or ""
                    for e in alt
                    if e.get("reaction")
                ]
                + ["H2 + O2", "Na + H2O", "C + O2"],
                reaction.get("conditions")
                or f"The illustration starts from {reaction.get('reactants')}.",
                allowed,
                equation=f"{reaction.get('reactants')} → {reaction.get('products')}",
            )
        )
        add(
            make_item(
                f"{z}-{depth}-rxn-p",
                CAT_LIGHT,
                f"What products does the catalog show in the {name} reaction illustration?",
                reaction.get("products") or "",
                [
                    e.get("reaction", {}).get("products") or ""
                    for e in alt
                    if e.get("reaction")
                ]
                + ["H2O", "NaOH + H2", "CO2"],
                f"The illustration ends at {reaction.get('products')}.",
                allowed,
                equation=f"{reaction.get('reactants')} → {reaction.get('products')}",
            )
        )

    group_mates = same_group(elements, el)
    if group_mates:
        mate = group_mates[0]
        add(
            make_item(
                f"{z}-{depth}-congener",
                CAT_NEIGHBOR,
                stem_for(
                    depth,
                    f"Which of these sits in the same column as {name}?",
                    f"Which listed element is a group neighbor of {name}?",
                    f"A congener of {symbol} in this catalog:",
                ),
                mate["name"],
                [
                    e["name"]
                    for e in alt
                    if e.get("group") != el.get("group")
                ],
                f"{mate['name']} shares group {el.get('group')} with {name}.",
                allowed,
            )
        )
    period_mates = same_period(elements, el)
    if period_mates:
        mate = period_mates[0]
        add(
            make_item(
                f"{z}-{depth}-period-n",
                CAT_NEIGHBOR,
                f"Which of these is in the same period as {name}?",
                mate["name"],
                [e["name"] for e in alt if e["period"] != el["period"]],
                f"{mate['name']} is also in period {el['period']}.",
                allowed,
            )
        )

    summary = (el.get("summary") or {}).get(depth) or ""
    if summary:
        sentence = first_sentence(summary)
        others_s = [
            first_sentence((e.get("summary") or {}).get(depth) or "")
            for e in alt
        ]
        add(
            make_item(
                f"{z}-{depth}-summary",
                CAT_IDENTITY,
                f"Which teaching sentence belongs to {name} at this learning mode?",
                sentence,
                others_s,
                sentence,
                allowed,
            )
        )
    curriculum = (el.get("curriculum") or {}).get(depth) or ""
    if curriculum:
        sentence = first_sentence(curriculum)
        add(
            make_item(
                f"{z}-{depth}-curriculum",
                CAT_IDENTITY if depth == "beginner" else CAT_ELECTRON,
                f"Which curriculum note is written for {name} at this depth?",
                sentence,
                [
                    first_sentence((e.get("curriculum") or {}).get(depth) or "")
                    for e in alt
                ],
                sentence,
                allowed,
            )
        )

    # Stable fillers from other elements' Z/name so every element reaches 50.
    for i, other in enumerate(alt[:12]):
        add(
            make_item(
                f"{z}-{depth}-vs-z-{other['z']}",
                CAT_NEIGHBOR,
                f"Which atomic number is {name}'s, not {other['name']}'s?",
                str(z),
                [str(other["z"]), str(other["period"]), str(other.get("group") or 18)],
                f"{name} is Z = {z}; {other['name']} is Z = {other['z']}.",
                allowed,
            )
        )
        add(
            make_item(
                f"{z}-{depth}-vs-name-{other['z']}",
                CAT_IDENTITY,
                f"Which name is this element ({symbol})?",
                name,
                [other["name"], by_z.get(max(1, z - 1), other)["name"], by_z.get(min(118, z + 1), other)["name"]],
                f"{symbol} is {name}.",
                allowed,
            )
        )
        if other.get("period") != el["period"]:
            add(
                make_item(
                    f"{z}-{depth}-vs-period-{other['z']}",
                    CAT_NEIGHBOR,
                    f"Which period contains {name} rather than {other['name']}?",
                    str(el["period"]),
                    [str(other["period"]), str(7 if el["period"] != 7 else 1), str(2 if el["period"] != 2 else 6)],
                    f"{name} is period {el['period']}; {other['name']} is period {other['period']}.",
                    allowed,
                )
            )

    # Deduplicate by id, then take 50.
    seen: set[str] = set()
    unique_items: list[dict] = []
    for item in items:
        if item["id"] in seen:
            continue
        seen.add(item["id"])
        unique_items.append(item)
    if len(unique_items) < POOL:
        raise SystemExit(f"Z={z} {depth}: only {len(unique_items)} questions")
    return unique_items[:POOL]


def apply_curated(levels: dict, z: int) -> dict:
    path = CURATED / f"{z}.json"
    if not path.exists():
        return levels
    extra = json.loads(path.read_text(encoding="utf-8"))
    for depth in DEPTHS:
        incoming = extra.get(depth) or extra.get("replace") or []
        if not incoming:
            continue
        by_id = {q["id"]: q for q in levels[depth]}
        inserted = []
        for q in incoming:
            by_id[q["id"]] = q
            inserted.append(q["id"])
        rest = [q for q in levels[depth] if q["id"] not in inserted]
        merged = [by_id[i] for i in inserted if i in by_id] + rest
        levels[depth] = merged[:POOL]
    return levels


def check_element(el: dict, levels: dict) -> None:
    allowed = allowed_numbers(el)
    for depth, questions in levels.items():
        if len(questions) < POOL:
            raise SystemExit(f"Z={el['z']} {depth}: {len(questions)} < {POOL}")
        ids = [q["id"] for q in questions]
        if len(ids) != len(set(ids)):
            raise SystemExit(f"Z={el['z']} {depth}: duplicate ids")
        for q in questions:
            opts = q["options"]
            if len(opts) != 4 or len(set(opts)) != 4:
                raise SystemExit(f"{q['id']}: need 4 distinct options")
            if not 0 <= q["correctIndex"] < 4:
                raise SystemExit(f"{q['id']}: bad correctIndex")
            if not (q.get("explanation") or "").strip():
                raise SystemExit(f"{q['id']}: empty explanation")
            if not numbers_ok(opts[q["correctIndex"]], allowed):
                raise SystemExit(
                    f"{q['id']}: number in correct option not in catalog: {opts[q['correctIndex']]}"
                )


def main() -> None:
    pack = json.loads(CORE.read_text(encoding="utf-8"))
    elements = pack["elements"]
    OUT.mkdir(parents=True, exist_ok=True)
    for el in elements:
        levels = {d: build_questions(el, elements, d) for d in DEPTHS}
        levels = apply_curated(levels, el["z"])
        check_element(el, levels)
        path = OUT / f"{el['z']}.json"
        path.write_text(
            json.dumps({"z": el["z"], "levels": levels}, ensure_ascii=False, separators=(",", ":")),
            encoding="utf-8",
        )
        print(f"wrote {path.name}")
    print(f"ok {len(elements)} elements")


if __name__ == "__main__":
    try:
        main()
    except SystemExit as e:
        print(e, file=sys.stderr)
        raise
