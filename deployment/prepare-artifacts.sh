#!/bin/bash
# Build the Element Deck Flutter PWA zip for deployment.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
ARTIFACTS_DIR="${SCRIPT_DIR}/artifacts"

# shellcheck source=lib/resolve-flutter.sh
source "${SCRIPT_DIR}/lib/resolve-flutter.sh"

if ! declare -f log_info >/dev/null 2>&1; then
    log_info() { echo "[INFO] $*"; }
    log_success() { echo "[SUCCESS] $*"; }
    log_warn() { echo "[WARN] $*"; }
    log_error() { echo "[ERROR] $*"; }
fi

main() {
    echo "[INFO] Building Element Deck PWA (Flutter web)..."
    mkdir -p "$ARTIFACTS_DIR"
    build_pwa_artifact_native "$ROOT_DIR"
    echo "[INFO] Artifacts ready in ${ARTIFACTS_DIR}"
    ls -lh "$ARTIFACTS_DIR"
}

case "${1:-}" in
    --help|-h)
        echo "Usage: $0"
        echo "Builds Flutter web into deployment/artifacts/pwa-dist.zip"
        exit 0
        ;;
    "" ) main ;;
    *) echo "[ERROR] Unknown option: $1" >&2; exit 1 ;;
esac
