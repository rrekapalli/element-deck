#!/bin/bash
# Build and deploy the Element Deck Flutter PWA to Proxmox LXC VMID 7018.
#
# Usage:
#   bash ./deploy.sh
#   bash ./deploy.sh --major 1
#   bash ./deploy.sh --skip-build
#   bash ./deploy.sh --recreate

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPLOYMENT_DIR="${ROOT_DIR}/deployment"
PROXMOX_DIR="${DEPLOYMENT_DIR}/proxmox"
ARTIFACTS_DIR="${DEPLOYMENT_DIR}/artifacts"
BUMP_SCRIPT="${ROOT_DIR}/scripts/bump_app_version.sh"

log_info() { echo "[INFO] $1"; }
log_success() { echo "[SUCCESS] $1"; }
log_warn() { echo "[WARN] $1"; }
log_error() { echo "[ERROR] $1"; }

RECREATE=false
SKIP_BUILD=false
SKIP_VERSION_BUMP=false
MAJOR_ARG=""
BUMP_MAJOR=false
APP_VERSION=""

show_help() {
    cat <<'EOF'
Usage: ./deploy.sh [OPTIONS]

Build the Flutter PWA and deploy it to the Element Deck Proxmox LXC (VMID 7018).

Each build (unless --skip-build / --skip-version-bump) bumps pubspec.yaml:
  Default:        keep major, increment minor, reset patch, increment build (+N)
  --major [N]:    set major to N (or omit N to +1 major)

OPTIONS:
  --recreate            Destroy and recreate the LXC before deploy
  --skip-build          Deploy using existing deployment/artifacts/pwa-dist.zip
  --skip-version-bump   Do not change pubspec.yaml version
  --major [N]           Set or bump the major version
  --help, -h            Show this help
EOF
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --recreate) RECREATE=true; shift ;;
        --skip-build) SKIP_BUILD=true; shift ;;
        --skip-version-bump) SKIP_VERSION_BUMP=true; shift ;;
        --major)
            BUMP_MAJOR=true
            if [[ $# -ge 2 && "$2" =~ ^[0-9]+$ ]]; then
                MAJOR_ARG="$2"
                shift 2
            else
                shift
            fi
            ;;
        --help|-h) show_help; exit 0 ;;
        *) log_error "Unknown option: $1"; show_help; exit 1 ;;
    esac
done

log_info "Element Deck PWA deploy | Recreate: $RECREATE | Skip build: $SKIP_BUILD"

if [[ "$SKIP_BUILD" != true ]]; then
    if [[ "$SKIP_VERSION_BUMP" != true ]]; then
        [[ -f "$BUMP_SCRIPT" ]] || { log_error "Missing $BUMP_SCRIPT"; exit 1; }
        chmod +x "$BUMP_SCRIPT" 2>/dev/null || true
        bump_args=()
        if [[ "$BUMP_MAJOR" == true ]]; then
            bump_args+=(--major)
            [[ -n "$MAJOR_ARG" ]] && bump_args+=("$MAJOR_ARG")
        fi
        APP_VERSION="$("$BUMP_SCRIPT" "${bump_args[@]}")"
        log_success "App version for this build: ${APP_VERSION}"
    else
        APP_VERSION="$("$BUMP_SCRIPT" --print 2>/dev/null || true)"
        log_info "Skipping version bump (current: ${APP_VERSION:-unknown})"
    fi
    bash "${DEPLOYMENT_DIR}/prepare-artifacts.sh"
fi

[[ -f "${ARTIFACTS_DIR}/pwa-dist.zip" ]] || {
    log_error "Missing ${ARTIFACTS_DIR}/pwa-dist.zip — run without --skip-build"
    exit 1
}

RECREATE_FLAG=""
[[ "$RECREATE" == true ]] && RECREATE_FLAG="--recreate"

if [[ -f "${ROOT_DIR}/scripts/fix-shell-crlf.sh" ]]; then
    bash "${ROOT_DIR}/scripts/fix-shell-crlf.sh" >/dev/null 2>&1 || true
fi

log_info "Deploying PWA to Proxmox LXC..."
bash "${PROXMOX_DIR}/deploy-ui.sh" $RECREATE_FLAG
log_success "PWA deployed"

if [[ -z "$APP_VERSION" && -f "$BUMP_SCRIPT" ]]; then
    APP_VERSION="$("$BUMP_SCRIPT" --print 2>/dev/null || true)"
fi
[[ -n "$APP_VERSION" ]] && log_info "App version: ${APP_VERSION}"

# shellcheck source=deployment/proxmox/lib/load-env.sh
source "${PROXMOX_DIR}/lib/load-env.sh"
load_element_deck_env "$PROXMOX_DIR"
# shellcheck source=deployment/proxmox/lib/tailscale-funnel.sh
source "${PROXMOX_DIR}/scripts/deploy-logging.sh"
source "${PROXMOX_DIR}/lib/tailscale-funnel.sh"

PWA_BASE="https://${DOMAIN}"
log_info "PWA:    ${PWA_BASE}/"
log_info "Health: ${PWA_BASE}/health"
if element_deck_public_funnel_wanted; then
    if wait_element_deck_funnel_public "${DOMAIN}"; then
        :
    else
        log_warn "Public Funnel DNS not visible yet. Tailnet MagicDNS still works for devices on Tailscale."
    fi
else
    log_info "Funnel is off. Devices need Tailscale, then open ${PWA_BASE}/"
fi
