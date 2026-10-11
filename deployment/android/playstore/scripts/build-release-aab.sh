#!/usr/bin/env bash
# Build a Play-signed Android App Bundle.
# Usage:
#   ./deployment/android/playstore/scripts/build-release-aab.sh
#   ./deployment/android/playstore/scripts/build-release-aab.sh --upload
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLAYSTORE="$(cd "${SCRIPT_DIR}/.." && pwd)"
ROOT="$(cd "${PLAYSTORE}/../../.." && pwd)"
cd "$ROOT"

UPLOAD=false
for arg in "$@"; do
  case "$arg" in
    --upload) UPLOAD=true ;;
    --help|-h)
      echo "Usage: $0 [--upload]"
      exit 0
      ;;
    *) echo "Unknown option: $arg" >&2; exit 1 ;;
  esac
done

[[ -f android/key.properties ]] || {
  echo "Missing android/key.properties. Run create-upload-keystore.sh first." >&2
  exit 1
}
if [[ ! -f android/app/google-services.json ]]; then
  echo "[WARN] android/app/google-services.json is missing. Firebase sign-in will not work in this build." >&2
fi
command -v flutter >/dev/null 2>&1 || { echo "flutter is not on PATH" >&2; exit 1; }

flutter pub get
mkdir -p build/debug-info
flutter build appbundle --release --obfuscate --split-debug-info=build/debug-info

bash "${SCRIPT_DIR}/prepare-play-artifact.sh"

if [[ "$UPLOAD" == true ]]; then
  bash "${SCRIPT_DIR}/upload-play-release.sh"
fi
