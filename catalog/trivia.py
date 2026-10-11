"""Five short stories for each element. The text lives in trivia_parts/."""

from __future__ import annotations

from trivia_parts.z01_30 import STORIES as _PART_1
from trivia_parts.z31_60 import STORIES as _PART_2
from trivia_parts.z61_90 import STORIES as _PART_3
from trivia_parts.z91_118 import STORIES as _PART_4

TRIVIA: dict[int, list[dict[str, str]]] = {}
for _part in (_PART_1, _PART_2, _PART_3, _PART_4):
    overlap = set(TRIVIA) & set(_part)
    if overlap:
        raise SystemExit(f"duplicate trivia for Z {sorted(overlap)}")
    TRIVIA.update(_part)

_missing = [z for z in range(1, 119) if z not in TRIVIA]
if _missing:
    raise SystemExit(f"missing trivia for Z {_missing}")

for _z, _items in TRIVIA.items():
    if len(_items) < 5:
        raise SystemExit(f"Z {_z} has {len(_items)} stories")
    for _item in _items:
        for _key in ("title", "summary", "story"):
            text = str(_item.get(_key, "")).strip()
            if len(text) < 8:
                raise SystemExit(f"Z {_z} has an empty {_key}")
