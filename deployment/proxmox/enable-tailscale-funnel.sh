#!/usr/bin/env bash
# Publish LXC 6101 nginx (:80) to the public internet via Tailscale Funnel.
# Phones and tablets do not need Tailscale installed.
#
# Prerequisites (Tailscale admin):
#   - MagicDNS and HTTPS certificates enabled
#   - Funnel allowed for this node
#
# Tailnet-only rollback:
#   ./deployment/proxmox/enable-tailscale-https.sh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=scripts/deploy-logging.sh
source "${SCRIPT_DIR}/scripts/deploy-logging.sh"
# shellcheck source=lib/load-env.sh
source "${SCRIPT_DIR}/lib/load-env.sh"
# shellcheck source=lib/proxmox-remote.sh
source "${SCRIPT_DIR}/lib/proxmox-remote.sh"
# shellcheck source=lib/tailscale-funnel.sh
source "${SCRIPT_DIR}/lib/tailscale-funnel.sh"

load_element_deck_env "$SCRIPT_DIR"
init_proxmox_mode

ELEMENT_DECK_PUBLIC_VIA_FUNNEL=true
export ELEMENT_DECK_FUNNEL_FORCE_REAPPLY=1

VMID="${FIXED_VMID:-6101}"
ensure_element_deck_tailscale_funnel "$VMID" "$SCRIPT_DIR" || exit 1
wait_element_deck_funnel_public "${DOMAIN}" || true

log_info "PWA: https://${DOMAIN}/"
log_info "Health: https://${DOMAIN}/health"
log_info "Rollback to tailnet-only Serve: ./deployment/proxmox/enable-tailscale-https.sh"
