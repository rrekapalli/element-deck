# shellcheck shell=bash
# Shared Tailscale SSH helpers for deploy-*-tailscale.sh (expects load_element_deck_env already run).

init_tailscale_ssh() {
    : "${CONTAINER_PASSWORD:?Set CONTAINER_PASSWORD in repo .env}"
    : "${CONTAINER_USER:?CONTAINER_USER unset}"
    : "${DOMAIN:?DOMAIN unset}"
    command -v sshpass >/dev/null 2>&1 || {
        log_error "sshpass is required for Tailscale deploy"
        return 1
    }
    TS_SSH_OPTS="-o StrictHostKeyChecking=no -o ConnectTimeout=10 -o ServerAliveInterval=30"
    local tailnet="${TAILNET_DNS:-tailce422e.ts.net}"
    local candidates=("$DOMAIN")
    local short="${DOMAIN%%.*}"
    local alias aliases="${CONTAINER_ALIASES:-element-deck}"
    local IFS=','
    for alias in $aliases; do
        alias="${alias//[[:space:]]/}"
        [[ -z "$alias" || "$alias" == "$short" ]] && continue
        candidates+=("${alias}.${tailnet}")
    done
    unset IFS
    if [[ "$short" == "elementdeck" ]]; then
        candidates+=("element-deck.${tailnet}")
    fi

    local host resolved=""
    for host in "${candidates[@]}"; do
        log_info "Trying Tailscale SSH host ${CONTAINER_USER}@${host}..."
        if sshpass -p "$CONTAINER_PASSWORD" ssh $TS_SSH_OPTS "${CONTAINER_USER}@${host}" "echo ok" >/dev/null 2>&1; then
            resolved="$host"
            break
        fi
    done
    if [[ -n "$resolved" && "$resolved" != "$DOMAIN" ]]; then
        log_info "Using reachable Tailscale host ${resolved} (canonical DOMAIN is ${DOMAIN})"
        DOMAIN="$resolved"
    elif [[ -z "$resolved" ]]; then
        log_warn "Could not SSH to any of: ${candidates[*]}"
    fi
    TS_SSH_TARGET="${CONTAINER_USER}@${DOMAIN}"
    TS_SSH_OPTS="-o StrictHostKeyChecking=no -o ConnectTimeout=30 -o ServerAliveInterval=30"
}

_ts_ssh() {
    sshpass -p "$CONTAINER_PASSWORD" ssh $TS_SSH_OPTS "$TS_SSH_TARGET" "$@"
}

_ts_scp() {
    sshpass -p "$CONTAINER_PASSWORD" scp $TS_SSH_OPTS "$1" "${TS_SSH_TARGET}:$2"
}

# Run a remote script as root via sudo (NOPASSWD preferred; falls back to sudo -S).
# Reads script body from stdin.
_ts_sudo_bash() {
    local remote_script delim local_wrap
    remote_script="$(cat)"
    delim="ELEMENT_DECK_REMOTE_$(date +%s)_$$"
    local_wrap="$(mktemp)"
    {
        echo 'set -euo pipefail'
        echo "SCRIPT=\$(mktemp)"
        echo "cat > \"\$SCRIPT\" <<'${delim}'"
        printf '%s\n' "$remote_script"
        echo "${delim}"
        echo "if sudo -n true 2>/dev/null; then"
        echo "  sudo -n bash \"\$SCRIPT\""
        echo "else"
        echo "  printf '%s\\n' $(printf '%q' "$CONTAINER_PASSWORD") | sudo -S -p '' bash \"\$SCRIPT\""
        echo "fi"
        echo "ec=\$?"
        echo "rm -f \"\$SCRIPT\""
        echo "exit \$ec"
    } >"$local_wrap"
    sshpass -p "$CONTAINER_PASSWORD" ssh $TS_SSH_OPTS "$TS_SSH_TARGET" bash <"$local_wrap"
    local ec=$?
    rm -f "$local_wrap"
    return $ec
}
