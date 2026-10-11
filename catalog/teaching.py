"""Grade-leveled Details copy.

The first paragraph of each depth is the lede: exactly two sentences, shown
above the electron picture. Everything after the blank line is the rest.
"""

from __future__ import annotations

import re

from teaching_facts import FACTS


def _sentences(text: str) -> list[str]:
    return [part for part in re.split(r"(?<=[.!?])\s+", text.strip()) if part]


def _family_sentence(el: dict) -> str:
    if "halogen" in el.get("tags", []) or el.get("categoryLabel") == "Halogen":
        return "It is a halogen, a reactive nonmetal in the column next to the noble gases."
    return {
        "alkali-metal": "It is an alkali metal: soft, and quick to react with water.",
        "alkaline-earth": "It is an alkaline-earth metal. These metals react, but less wildly than the alkali metals beside them.",
        "transition-metal": "It is a transition metal, from the wide middle block of the table.",
        "post-transition": "It is a metal from the block just to the right of the transition metals.",
        "metalloid": "It is a metalloid, between the metals and the nonmetals in the way it behaves.",
        "reactive-nonmetal": "It is a nonmetal. It does not look or act like iron or copper.",
        "noble-gas": "It is a noble gas. Left alone, it almost never joins other elements to make compounds.",
        "lanthanide": "It is a lanthanide, one of the rare-earth metals in the row under the main table.",
        "actinide": "It is an actinide, from the heavy row under the main table, and it is radioactive.",
    }[el["categoryId"]]


def _inline(name: str) -> str:
    return name[:1].lower() + name[1:]


def _state_sentence(el: dict) -> str:
    name = _inline(el["name"])
    return {
        "gas": f"At room temperature {name} is a gas, so a sample fills its container.",
        "liquid": f"At room temperature {name} is a liquid, which is unusual for an element.",
        "solid": f"At room temperature {name} is a solid.",
    }[el["standardState"]]


def _place_sentence(el: dict) -> str:
    period = el["period"]
    group = el.get("group")
    if group is None:
        return (
            f"On the periodic table it is in row {period}, in the strip under the main table. "
            f"That row is period {period}."
        )
    return (
        f"On the periodic table it is in row {period}, column {group}. "
        f"In class those are called period {period} and group {group}."
    )


def _course_open(el: dict) -> str:
    name = el["name"]
    state = el["standardState"]
    period = el["period"]
    group = el.get("group")
    if group is None:
        where = f"period {period}, in the row under the main table"
    else:
        where = f"period {period} and group {group}"
    if el["categoryId"] == "noble-gas":
        kind = "noble gas"
    elif el.get("categoryLabel") == "Halogen":
        kind = "halogen"
    elif el["categoryId"] == "alkaline-earth":
        kind = "alkaline-earth metal"
    elif el["categoryId"] == "reactive-nonmetal":
        kind = "nonmetal"
    else:
        kind = el["categoryLabel"].lower()
    if kind == "noble gas":
        return f"{name} is a noble gas in {where}."
    if state == "gas":
        return f"{name} is a {kind} gas in {where}."
    return f"{name} is a {state} {kind} in {where}."


def _fmt_ox(value: int) -> str:
    if value > 0:
        return f"+{value}"
    if value < 0:
        return f"-{value}"
    return "0"


def _ox_sentence(el: dict) -> str:
    ox = el.get("oxidationStates") or []
    if not ox:
        return "Oxidation states are not listed for this entry."
    bits = ", ".join(_fmt_ox(n) for n in ox)
    primary = el.get("primaryOxidation")
    if len(ox) == 1:
        return f"In compounds the oxidation state to learn is {bits}."
    if primary is not None:
        return (
            f"Oxidation states in this dossier are {bits}. "
            f"The one courses meet most often is {_fmt_ox(primary)}."
        )
    return f"Oxidation states in this dossier are {bits}."


def _shell_sentence(counts: list[int]) -> str:
    if len(counts) == 1:
        n = counts[0]
        word = "electron" if n == 1 else "electrons"
        return f"Every electron is in the first shell: {n} {word}."
    shown = ", ".join(str(n) for n in counts)
    return f"As shell counts, from the nucleus outward, that is {shown}."


def _neighbor(z: int) -> str:
    if z >= 104:
        return (
            "Only a few atoms are made at a time, so the chemistry is inferred from the "
            "column above it and from calculations that include relativity. There is no piece you can hold."
        )
    if z >= 84:
        return "Every isotope is radioactive, so this is a real element you will not find as a jar on a shelf."
    if 57 <= z <= 71:
        return (
            "The lanthanides are hard to separate because the outer electrons are almost the same. "
            "The 4f electrons sit inside and change the chemistry only a little from one element to the next."
        )
    if z >= 72:
        return (
            "Neighbors differ because of shell filling, the lanthanide contraction, "
            "and relativistic effects on the inner electrons."
        )
    return (
        "Neighbors differ because each added proton changes how tightly the electrons "
        "are held as the shells fill."
    )


def _picture(el: dict) -> str:
    z = el["z"]
    name = _inline(el["name"])
    word = "electron" if z == 1 else "electrons"
    return (
        "The picture shows the electrons around the nucleus. Each ring is a shell, a layer of electrons. "
        f"A neutral {name} atom has {z} {word}, the same number as its protons."
    )


def _beginner(el: dict, fact: dict) -> str:
    symbol = el["symbol"]
    identity = (
        f"Its symbol is {symbol}. {_state_sentence(el)} {_family_sentence(el)} {_place_sentence(el)}"
    )
    return "\n\n".join([fact["lede"], identity, fact["more"], _picture(el)])


def _intermediate(el: dict, fact: dict) -> str:
    lede = f"{_course_open(el)} {fact['focus']}"
    body = (
        f"The electron configuration is {el['electronConfig']}. "
        f"{_shell_sentence(el['shellCounts'])} {_ox_sentence(el)}"
    )
    rings = (
        "The rings in the picture are subshells, the smaller groups of electrons inside a shell. "
        "A line joins the two electrons that share one orbital."
    )
    parts = [lede, body]
    detail = fact.get("detail", "").strip()
    if detail:
        parts.append(detail)
    parts.append(rings)
    return "\n\n".join(parts)


def _advanced(el: dict, fact: dict) -> str:
    deep = _sentences(fact["deep"])
    lede = (
        f"{el['name']} (Z = {el['z']}) has the ground-state configuration {el['electronConfig']}. "
        f"{deep[0]}"
    )
    parts = [lede]
    rest = " ".join(deep[1:]).strip()
    if rest:
        parts.append(rest)
    parts.append(f"{_ox_sentence(el)} {_neighbor(el['z'])}")
    parts.append(
        "The picture estimates how tightly each subshell is held, using Slater's rules. "
        "Ring radius follows 1/sqrt(E), so a tightly held inner shell sits closer to the nucleus. "
        "These are compiled teaching values, not a measurement this device just made."
    )
    return "\n\n".join(parts)


_BANNED_BEGINNER = re.compile(
    r"oxidation|configuration|subshell|electronegativ|slater|Z_eff|\d[spdf]",
    re.IGNORECASE,
)


def summaries(el: dict) -> dict:
    fact = FACTS[el["z"]]
    text = {
        "beginner": _beginner(el, fact),
        "intermediate": _intermediate(el, fact),
        "advanced": _advanced(el, fact),
    }
    for depth, paragraph in text.items():
        lede = paragraph.split("\n\n", 1)[0]
        count = len(_sentences(lede))
        if count != 2:
            raise SystemExit(f"Z={el['z']} {depth} lede has {count} sentences: {lede}")
    if _BANNED_BEGINNER.search(text["beginner"]):
        match = _BANNED_BEGINNER.search(text["beginner"])
        raise SystemExit(f"Z={el['z']} beginner contains {match.group(0)!r}")
    return text
