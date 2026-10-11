#!/bin/bash
# Health check for the Element Deck PWA LXC (VMID 6101).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=scripts/deploy-logging.sh
source "${SCRIPT_DIR}/scripts/deploy-logging.sh"
# shellcheck source=lib/load-env.sh
source "${SCRIPT_DIR}/lib/load-env.sh"
# shellcheck source=lib/proxmox-remote.sh
source "${SCRIPT_DIR}/lib/proxmox-remote.sh"

load_element_deck_env "$SCRIPT_DIR"
init_proxmox_mode

VMID="${FIXED_VMID}"
log_info "Diagnosing ${CONTAINER_NAME} (VMID ${VMID}) on ${PROXMOX_HOST}..."

run() {
    proxmox_exec_in_container "$VMID" "$1" 2>&1 || echo "(command failed)"
}

if ! proxmox_container_exists "$CONTAINER_NAME"; then
    log_error "Container '${CONTAINER_NAME}' not found on Proxmox"
    exit 1
fi

log_info "--- container status ---"
if [[ "$USE_REMOTE_PROXMOX" == true ]]; then
    _proxmox_remote "pct status ${VMID}" || true
else
    pct status "$VMID" || true
fi

log_info "--- tailscale ---"
run "tailscale status 2>&1 | head -20"
run "tailscale ip -4 2>&1"
run "systemctl is-active tailscaled 2>&1"
run "tailscale funnel status 2>&1 | head -20"

log_info "--- nginx ---"
run "systemctl is-active nginx 2>&1"
run "curl -sI --max-time 5 http://127.0.0.1:${UI_PORT}/health 2>&1 | head -8"
run "test -f ${WEB_ROOT}/index.html && echo index.html:ok || echo index.html:MISSING"
run "test -f ${WEB_ROOT}/manifest.json && echo manifest.json:ok || echo manifest.json:MISSING"
run "test -c /dev/net/tun && echo /dev/net/tun:ok || echo /dev/net/tun:MISSING"
