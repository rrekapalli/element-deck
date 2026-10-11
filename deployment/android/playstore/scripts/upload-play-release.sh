#!/usr/bin/env bash
# Upload AAB + listing to Google Play (Android Publisher API).
# Usage:
#   ./upload-play-release.sh
#   ./upload-play-release.sh --listing-only
#   ./upload-play-release.sh --aab path/to.aab --track internal
set -euo pipefail
PLAYSTORE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ROOT="$(cd "$PLAYSTORE/../../.." && pwd)"
cd "$ROOT"
exec python3 "$PLAYSTORE/scripts/upload_play_release.py" "$@"
