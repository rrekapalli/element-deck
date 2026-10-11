#!/usr/bin/env bash
set -euo pipefail
PLAYSTORE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ROOT="$(cd "$PLAYSTORE/../../.." && pwd)"
cd "$ROOT"
python3 "$PLAYSTORE/scripts/prepare_play_listing.py"
