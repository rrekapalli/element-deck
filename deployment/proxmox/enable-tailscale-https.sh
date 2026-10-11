#!/usr/bin/env bash
# Tailnet-only HTTPS (Serve) so service workers have a secure context.
# Plain http://*.ts.net is not a secure context.
#
# Public access without Tailscale on the device:
#   ./deployment/proxmox/enable-tailscale-funnel.sh
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

VMID="${FIXED_VMID:-7018}"

log_info "Enabling Tailscale HTTPS serve on ${CONTAINER_NAME} (VMID ${VMID})"
log_info "Disabling Funnel (Serve and Funnel cannot share the same port)..."
disable_element_deck_tailscale_funnel "$VMID"

proxmox_exec_in_container "$VMID" \
  "tailscale funnel reset 2>/dev/null || true; \
   tailscale serve --bg 80; \
   tailscale serve status"

log_success "PWA available at https://${DOMAIN}/ (tailnet only)"
log_info "Open the HTTPS URL to install the PWA on a phone or tablet."
