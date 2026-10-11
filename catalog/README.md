# Catalog source

`enrich.py` holds properties, discovery, uses, and the three teaching depths for all 118 elements.

`generate_catalog.py` writes `assets/catalog/core.json` (118 elements) and `assets/catalog/preview.json` (five-element fixture).

`json_to_sqlite.py` compiles SQLite to:

- `assets/catalog/catalog.sqlite` — bundled on-device catalog the app loads first
- `catalog/output/catalog.sqlite` — same file for Firebase Storage at `packs/core/{version}/catalog.sqlite`
