#!/bin/bash
# Join the Element Deck LXC (VMID 7018) to Tailscale.
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "${SCRIPT_DIR}/add-lxc-to-tailscale.sh" 7018 elementdeck
