#!/bin/bash
# Strip CR from shell scripts so WSL bash can run them.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
while IFS= read -r -d '' f; do
  sed -i 's/\r$//' "$f"
done < <(find "$ROOT/deployment" "$ROOT/scripts" "$ROOT/deploy.sh" \
  \( -name '*.sh' -o -name '*.template' -o -name 'deploy.sh' \) -type f -print0 2>/dev/null)
