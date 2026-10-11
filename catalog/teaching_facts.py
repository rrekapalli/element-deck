"""Merged teaching sentences for all 118 elements."""

from facts_01_40 import FACTS as _A
from facts_41_80 import FACTS as _B
from facts_81_118 import FACTS as _C

FACTS: dict[int, dict[str, str]] = {}
for _part in (_A, _B, _C):
    overlap = set(FACTS) & set(_part)
    if overlap:
        raise SystemExit(f"duplicate teaching facts for Z {sorted(overlap)}")
    FACTS.update(_part)

_missing = [z for z in range(1, 119) if z not in FACTS]
if _missing:
    raise SystemExit(f"missing teaching facts for Z {_missing}")

for _z, _fact in FACTS.items():
    for _key in ("lede", "more", "focus", "detail", "deep"):
        if not str(_fact.get(_key, "")).strip():
            raise SystemExit(f"Z {_z} missing {_key}")
