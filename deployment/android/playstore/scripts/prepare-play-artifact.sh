#!/usr/bin/env bash
# Copy a built AAB into deployment/android/playstore/artifacts/.
# Usage:
#   ./deployment/android/playstore/scripts/prepare-play-artifact.sh
#   ./deployment/android/playstore/scripts/prepare-play-artifact.sh path/to/app-release.aab

set -euo pipefail
PLAYSTORE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ROOT="$(cd "$PLAYSTORE/../../.." && pwd)"
ARTIFACTS="$PLAYSTORE/artifacts"
mkdir -p "$ARTIFACTS"

AAB="${1:-$ROOT/build/app/outputs/bundle/release/app-release.aab}"
[[ -f "$AAB" ]] || { echo "AAB not found: $AAB" >&2; exit 1; }

VER="release"
if [[ -f "$ROOT/pubspec.yaml" ]]; then
  VER="$(sed -n 's/^version:[[:space:]]*//p' "$ROOT/pubspec.yaml" | head -1 | tr -d '\r' | tr '+' '-')"
  [[ -n "$VER" ]] || VER="release"
fi

DEST="$ARTIFACTS/element-deck-${VER}-release.aab"
cp -f "$AAB" "$DEST"
echo "[OK] Copied artifact: $DEST"
ls -la "$DEST"
