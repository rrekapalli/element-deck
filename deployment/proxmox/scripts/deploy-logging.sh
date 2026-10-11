# Timestamped logging for deploy scripts.
RED="${RED:-\033[0;31m}"
GREEN="${GREEN:-\033[0;32m}"
YELLOW="${YELLOW:-\033[1;33m}"
BLUE="${BLUE:-\033[0;34m}"
CYAN="${CYAN:-\033[0;36m}"
NC="${NC:-\033[0m}"

_log_ts() { date '+%H:%M:%S'; }
log_info() { echo -e "$(_log_ts) ${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "$(_log_ts) ${GREEN}[SUCCESS]${NC} $1"; }
log_warn() { echo -e "$(_log_ts) ${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "$(_log_ts) ${RED}[ERROR]${NC} $1"; }
log_prompt() { echo -e "$(_log_ts) ${CYAN}[?]${NC} $1"; }

element_deck_final_tailscale() {
    local d="${1:?}" vmid="${2:?}" cname="${3:?}"
    local ts_script="${d}/add-lxc-to-tailscale.sh"
    if [[ ! -x "$ts_script" ]]; then
        log_warn "add-lxc-to-tailscale.sh not found; skip Tailscale join"
        return 0
    fi

    log_info "Tailscale join (idempotent)..."
    if ! "$ts_script" "$vmid" "$cname"; then
        log_warn "Tailscale join script failed for VMID ${vmid} — PWA files are already on the LXC"
        return 1
    fi

    local ts_ip=""
    ts_ip="$(proxmox_exec_in_container "$vmid" "tailscale ip -4 2>/dev/null | head -1" | tr -d '[:space:]')"
    if [[ ! "$ts_ip" =~ ^100\. ]]; then
        log_warn "Tailscale is not connected on ${cname} (VMID ${vmid})."
        log_warn "Auth key in .env may be expired. Approve a login URL or put a fresh tskey-auth- in TS_AUTHKEY."
        log_warn "Retry: ${d}/join-tailscale.sh"
        return 1
    fi

    log_success "Tailscale connected: ${ts_ip}"
    if [[ -n "${TAILNET_DNS:-}" ]]; then
        log_info "Open: https://${cname}.${TAILNET_DNS}/  (HTTPS required for PWA / service worker)"
    else
        log_info "Open: http://${ts_ip}/"
    fi
}

# Refresh /etc/hosts pin for POSTGRES_HOST (and common aliases) via MagicDNS,
# then wait until TCP to host:port succeeds inside the LXC.
# Usage: wait_for_postgres_ready <vmid> [attempts] [sleep_secs]
wait_for_postgres_ready() {
    local vmid="${1:?}"
    local attempts="${2:-30}" sleep_secs="${3:-2}"
    local env_file="${ENV_FILE:-}"
    local pg_host pg_port tailnet i

    if [[ -z "$env_file" || ! -f "$env_file" ]]; then
        log_warn "No ENV_FILE for Postgres preflight; skipping"
        return 0
    fi
    pg_host="$(grep -E '^POSTGRES_HOST=' "$env_file" 2>/dev/null | head -1 | cut -d= -f2- | tr -d '\r"')"
    pg_port="$(grep -E '^POSTGRES_PORT=' "$env_file" 2>/dev/null | head -1 | cut -d= -f2- | tr -d '\r"')"
    pg_port="${pg_port:-5432}"
    tailnet="${TAILNET_DNS:-tailce422e.ts.net}"
    if [[ -z "$pg_host" ]]; then
        log_warn "POSTGRES_HOST unset; skipping Postgres preflight"
        return 0
    fi

    log_info "Refreshing MagicDNS pin and waiting for Postgres ${pg_host}:${pg_port}..."
    proxmox_exec_in_container "$vmid" "
set -euo pipefail
printf 'nameserver 100.100.100.100\\n' > /etc/resolv.conf
pin_host() {
  local h=\"\$1\" ip
  [[ -z \"\$h\" || \"\$h\" != *.ts.net ]] && return 0
  ip=\$(getent ahostsv4 \"\$h\" 2>/dev/null | awk 'NR==1{print \$1}')
  if [[ -n \"\$ip\" ]]; then
    sed -i \"/[[:space:]]\${h}\$/d\" /etc/hosts 2>/dev/null || true
    echo \"\$ip \$h\" >> /etc/hosts
    echo \"pinned \$h -> \$ip\"
  else
    echo \"WARN: could not resolve \$h\"
  fi
}
pin_host '${pg_host}'
pin_host 'postgres.${tailnet}'
pin_host 'pg18.${tailnet}'
tailscale set --accept-dns=false 2>/dev/null || true
printf 'nameserver 8.8.8.8\\nnameserver 8.8.4.4\\nnameserver 1.1.1.1\\nsearch ${tailnet}\\n' > /etc/resolv.conf
" || true

    for ((i = 1; i <= attempts; i++)); do
        if proxmox_exec_in_container "$vmid" "timeout 3 bash -c '</dev/tcp/${pg_host}/${pg_port}'" >/dev/null 2>&1; then
            log_success "Postgres TCP ready (${pg_host}:${pg_port}) after ${i} attempt(s)"
            return 0
        fi
        sleep "$sleep_secs"
    done
    log_error "Postgres not reachable at ${pg_host}:${pg_port} from LXC after $((attempts * sleep_secs))s"
    log_error "Check: tailscale status on pg18; ./scripts/ensure-element-deck-db.sh; journalctl -u element-deck-api -n 40"
    return 1
}

# Wait until an HTTP endpoint inside the LXC responds with 200 or 503.
# Spring Boot typically needs 8–20s after systemctl restart.
# Usage: wait_for_api_health <vmid> <url> [attempts] [sleep_secs]
wait_for_api_health() {
    local vmid="${1:?}" url="${2:?}"
    local attempts="${3:-30}" sleep_secs="${4:-2}"
    local i code

    log_info "Waiting for API health at ${url} (up to $((attempts * sleep_secs))s)..."
    for ((i = 1; i <= attempts; i++)); do
        code="$(proxmox_exec_in_container "$vmid" "curl -s -o /dev/null -w '%{http_code}' --max-time 3 '${url}'" 2>/dev/null | tr -d '[:space:]' || true)"
        if [[ "$code" =~ ^(200|503)$ ]]; then
            log_success "API health OK (HTTP ${code}) after ${i} attempt(s)"
            return 0
        fi
        sleep "$sleep_secs"
    done
    log_warn "API health still not ready at ${url} (last HTTP '${code:-none}')"
    return 1
}

# Same wait, but via SSH to the container (Tailscale direct deploy path).
# Usage: wait_for_api_health_ssh <ssh_fn_name> <url> [attempts] [sleep_secs]
wait_for_api_health_ssh() {
    local ssh_fn="${1:?}" url="${2:?}"
    local attempts="${3:-30}" sleep_secs="${4:-2}"
    local i code

    log_info "Waiting for API health at ${url} (up to $((attempts * sleep_secs))s)..."
    for ((i = 1; i <= attempts; i++)); do
        code="$("$ssh_fn" "curl -s -o /dev/null -w '%{http_code}' --max-time 3 '${url}'" 2>/dev/null | tr -d '[:space:]' || true)"
        if [[ "$code" =~ ^(200|503)$ ]]; then
            log_success "API health OK (HTTP ${code}) after ${i} attempt(s)"
            return 0
        fi
        sleep "$sleep_secs"
    done
    log_warn "API health still not ready at ${url} (last HTTP '${code:-none}')"
    return 1
}
