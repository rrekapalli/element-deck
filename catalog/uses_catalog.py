"""Three or more uses for every element, with a photo only when we ship one."""

from __future__ import annotations

from use_images import attach
from uses_01_60 import USES as _A
from uses_61_118 import USES as _B

USES: dict[int, list[tuple[str, str, str | None]]] = {}
for part in (_A, _B):
    overlap = set(USES) & set(part)
    if overlap:
        raise SystemExit(f"duplicate uses for Z {sorted(overlap)}")
    USES.update(part)

_missing = [z for z in range(1, 119) if z not in USES or len(USES[z]) < 3]
if _missing:
    raise SystemExit(f"uses missing or short for Z {_missing}")


def apps_for(z: int, name: str | None = None) -> list[dict]:
    notes = []
    for title, body, key in USES[z]:
        image, credit = attach(key)
        note = {"title": title, "body": body}
        if image:
            note["image"] = image
            note["credit"] = credit
        notes.append(note)
    return notes
