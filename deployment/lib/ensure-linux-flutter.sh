# shellcheck shell=bash
# Install a Linux-native Flutter SDK under WSL when Windows interop is unavailable.

if ! declare -f log_info >/dev/null 2>&1; then
    log_info() { echo "[INFO] $*"; }
    log_success() { echo "[SUCCESS] $*"; }
    log_error() { echo "[ERROR] $*"; }
fi

ensure_linux_flutter() {
    local flutter_home="${FLUTTER_HOME:-${HOME}/flutter}"
    local flutter_bin="${flutter_home}/bin/flutter"

    if [[ -x "$flutter_bin" ]] && flutter_has_linux_dart_sdk "$flutter_bin"; then
        return 0
    fi

    command -v git >/dev/null 2>&1 || {
        log_error "git is required to install Linux Flutter in WSL."
        exit 1
    }

    log_info "Installing Linux Flutter SDK to ${flutter_home} (one-time download)..."
    mkdir -p "$(dirname "$flutter_home")"

    if [[ -d "${flutter_home}/.git" ]]; then
        log_info "Updating existing Flutter checkout..."
        git -C "$flutter_home" fetch --depth 1 origin stable
        git -C "$flutter_home" checkout stable
        git -C "$flutter_home" pull --depth 1 origin stable
    else
        rm -rf "$flutter_home"
        git clone https://github.com/flutter/flutter.git -b stable --depth 1 "$flutter_home"
    fi

    fix_flutter_crlf_if_needed "$flutter_bin"
    "$flutter_bin" config --enable-web
    "$flutter_bin" precache --web

    [[ -x "$flutter_bin" ]] && flutter_has_linux_dart_sdk "$flutter_bin" || {
        log_error "Linux Flutter install failed under ${flutter_home}"
        exit 1
    }

    log_success "Linux Flutter ready: ${flutter_bin}"
}
