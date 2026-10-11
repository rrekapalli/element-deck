#!/bin/bash
set -euo pipefail
BASE="${1:-https://elementdeck.tailce422e.ts.net}"

check() {
    local label="$1"
    local url="$2"
    echo "=== ${label} ==="
    echo "URL: ${url}"
    curl -sI --max-time 15 "${url}" | head -8
    echo
}

check "health" "${BASE}/health"
check "index" "${BASE}/"
check "manifest.json" "${BASE}/manifest.json"
check "flutter_bootstrap.js" "${BASE}/flutter_bootstrap.js"
