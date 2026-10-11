# shellcheck shell=bash
# Load deployment.conf and workspace .env.
# Sets ROOT_DIR, DEPLOYMENT_DIR, CONFIG_FILE, ENV_FILE, ARTIFACTS_DIR.

strip_cr() {
    printf '%s' "$1" | tr -d '\r'
}

load_element_deck_env() {
    local script_dir="${1:?}"
    DEPLOYMENT_DIR="$(cd "${script_dir}/.." && pwd)"
    ROOT_DIR="$(cd "${DEPLOYMENT_DIR}/.." && pwd)"
    CONFIG_FILE="${DEPLOYMENT_DIR}/proxmox/deployment.conf"
    ENV_FILE="${ROOT_DIR}/.env"
    ARTIFACTS_DIR="${DEPLOYMENT_DIR}/artifacts"
    APP_DIR="${ROOT_DIR}"

    if [[ -f "$CONFIG_FILE" ]]; then
        set -a
        # shellcheck disable=SC1090
        source <(grep -v '^#' "$CONFIG_FILE" | grep -v '^$' | grep '=' | tr -d '\r') 2>/dev/null || true
        set +a
    fi

    if [[ -f "$ENV_FILE" ]]; then
        set -a
        while IFS= read -r line || [[ -n "$line" ]]; do
            line="${line%$'\r'}"
            [[ "$line" =~ ^[[:space:]]*# ]] && continue
            [[ -z "${line// }" ]] && continue
            [[ ! "$line" =~ = ]] && continue
            eval "export $line" 2>/dev/null || true
        done < "$ENV_FILE"
        set +a
    fi

    CONTAINER_NAME="$(strip_cr "${ELEMENT_DECK_CONTAINER_NAME:-elementdeck}")"
    CONTAINER_ALIASES="$(strip_cr "${ELEMENT_DECK_CONTAINER_ALIASES:-element-deck}")"
    FIXED_VMID="$(strip_cr "${ELEMENT_DECK_VMID:-6101}")"
    DOMAIN="$(strip_cr "${ELEMENT_DECK_HOST:-elementdeck.tailce422e.ts.net}")"
    UI_PORT="$(strip_cr "${UI_PORT:-80}")"
    CLONE_TEMPLATE="$(strip_cr "${ELEMENT_DECK_CLONE_TEMPLATE:-moneytree-lxc-frontend-base}")"
    CORES="$(strip_cr "${ELEMENT_DECK_CORES:-1}")"
    MEMORY_MB="$(strip_cr "${ELEMENT_DECK_MEMORY_MB:-512}")"
    ROOTFS_GB="$(strip_cr "${ELEMENT_DECK_ROOTFS_GB:-8}")"
    CONTAINER_USER="$(strip_cr "${CONTAINER_USER:-raja}")"
    CONTAINER_PASSWORD="$(strip_cr "${CONTAINER_PASSWORD:-}")"
    WEB_ROOT="$(strip_cr "${ELEMENT_DECK_WEB_ROOT:-/var/www/element-deck}")"
    DEPLOY_ROOT="$(strip_cr "${ELEMENT_DECK_DEPLOY_ROOT:-/opt/element-deck}")"
    PROXMOX_HOST="$(strip_cr "${PROXMOX_HOST:-192.168.29.231}")"
    PROXMOX_USER="$(strip_cr "${PROXMOX_USER:-root}")"
    PROXMOX_PASSWORD="$(strip_cr "${PROXMOX_PASSWORD:-}")"
    LXC_ROOTFS_STORAGE="$(strip_cr "${LXC_ROOTFS_STORAGE:-local-storage}")"
    CLONE_TEMPLATE_VMID="$(strip_cr "${CLONE_TEMPLATE_VMID:-9002}")"
    TAILNET_DNS="$(strip_cr "${TAILNET_DNS:-tailce422e.ts.net}")"
}
