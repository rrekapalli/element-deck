# shellcheck shell=bash
# Ensure Tailscale Funnel publishes nginx :80 on the Element Deck LXC (public HTTPS).
# Sourced by deploy-api.sh / deploy-ui.sh / enable-tailscale-funnel.sh.
#
# Env:
#   ELEMENT_DECK_PUBLIC_VIA_FUNNEL=true|false  (default: true)
# Requires: log_*, DOMAIN, and either proxmox_exec_in_container or _ts_sudo_bash.

element_deck_public_funnel_wanted() {
    local v
    v="$(printf '%s' "${ELEMENT_DECK_PUBLIC_VIA_FUNNEL:-true}" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"
    case "$v" in
        0|false|no|off) return 1 ;;
        *) return 0 ;;
    esac
}

# Install ensure script + systemd unit/timer and apply Funnel inside LXC via pct.
# Usage: ensure_element_deck_tailscale_funnel <vmid> <proxmox_scripts_dir>
ensure_element_deck_tailscale_funnel() {
    local vmid="${1:?}"
    local proxmox_dir="${2:?}"
    local script_src="${proxmox_dir}/scripts/element-deck-ensure-funnel.sh"
    local script_dst="/usr/local/sbin/element-deck-ensure-funnel.sh"
    local unit_src="${proxmox_dir}/systemd/element-deck-tailscale-funnel.service"
    local unit_dst="/etc/systemd/system/element-deck-tailscale-funnel.service"
    local timer_src="${proxmox_dir}/systemd/element-deck-tailscale-funnel.timer"
    local timer_dst="/etc/systemd/system/element-deck-tailscale-funnel.timer"

    if ! element_deck_public_funnel_wanted; then
        log_info "ELEMENT_DECK_PUBLIC_VIA_FUNNEL is off — skipping Funnel (tailnet-only Serve OK)."
        return 0
    fi

    if [[ ! -f "$script_src" || ! -f "$unit_src" || ! -f "$timer_src" ]]; then
        log_warn "Missing Funnel templates (script/unit/timer) under ${proxmox_dir}"
        return 1
    fi

    log_info "Ensuring Tailscale Funnel (public HTTPS) → nginx :80 on VMID ${vmid}..."
    proxmox_push_file "$vmid" "$script_src" "$script_dst" || {
        log_warn "Could not push Funnel ensure script"
        return 1
    }
    proxmox_push_file "$vmid" "$unit_src" "$unit_dst" || {
        log_warn "Could not push Funnel systemd unit"
        return 1
    }
    proxmox_push_file "$vmid" "$timer_src" "$timer_dst" || {
        log_warn "Could not push Funnel systemd timer"
        return 1
    }

    if ! proxmox_exec_in_container "$vmid" \
        "command -v tailscale >/dev/null 2>&1 || { echo 'ERROR: tailscale not installed' >&2; exit 1; }; \
         chmod 755 /usr/local/sbin/element-deck-ensure-funnel.sh; \
         systemctl daemon-reload; \
         systemctl enable element-deck-tailscale-funnel.service element-deck-tailscale-funnel.timer; \
         systemctl start element-deck-tailscale-funnel.timer; \
         ELEMENT_DECK_FUNNEL_FORCE_REAPPLY=${ELEMENT_DECK_FUNNEL_FORCE_REAPPLY:-0} /usr/local/sbin/element-deck-ensure-funnel.sh; \
         echo '--- funnel status ---'; \
         tailscale funnel status; \
         echo '--- timer ---'; \
         systemctl is-enabled element-deck-tailscale-funnel.timer; \
         systemctl list-timers element-deck-tailscale-funnel.timer --no-pager"; then
        log_warn "Funnel enable failed — run: ./deployment/proxmox/enable-tailscale-funnel.sh"
        log_warn "Check ACL nodeAttrs (funnel) + MagicDNS HTTPS in Tailscale admin."
        return 1
    fi

    log_success "Public HTTPS (Funnel): https://${DOMAIN}/"
    log_info "Watchdog: timer re-enables Funnel only if it dropped to Serve (does not reset on NXDOMAIN)."
    return 0
}

# Same for Tailscale-SSH deploy path (no pct).
# Usage: ensure_element_deck_tailscale_funnel_ssh <proxmox_scripts_dir>
ensure_element_deck_tailscale_funnel_ssh() {
    local proxmox_dir="${1:?}"
    local unit_src="${proxmox_dir}/systemd/element-deck-tailscale-funnel.service"
    local user_home="/home/${CONTAINER_USER:-raja}"

    if ! element_deck_public_funnel_wanted; then
        log_info "ELEMENT_DECK_PUBLIC_VIA_FUNNEL is off — skipping Funnel."
        return 0
    fi

    if ! declare -F _ts_sudo_bash >/dev/null 2>&1 || ! declare -F _ts_scp >/dev/null 2>&1; then
        log_warn "Tailscale SSH helpers not loaded — cannot ensure Funnel via SSH"
        return 1
    fi

    [[ -f "$unit_src" ]] || { log_warn "Missing ${unit_src}"; return 1; }

    local script_src="${proxmox_dir}/scripts/element-deck-ensure-funnel.sh"
    local timer_src="${proxmox_dir}/systemd/element-deck-tailscale-funnel.timer"

    log_info "Ensuring Tailscale Funnel via SSH → nginx :80..."
    [[ -f "$script_src" && -f "$timer_src" ]] || { log_warn "Missing Funnel script/timer"; return 1; }
    _ts_scp "$script_src" "~/element-deck-ensure-funnel.sh" || return 1
    _ts_scp "$unit_src" "~/element-deck-tailscale-funnel.service" || return 1
    _ts_scp "$timer_src" "~/element-deck-tailscale-funnel.timer" || return 1
    if ! _ts_sudo_bash <<EOF
set -euo pipefail
command -v tailscale >/dev/null 2>&1 || { echo 'ERROR: tailscale not installed' >&2; exit 1; }
install -m 755 '${user_home}/element-deck-ensure-funnel.sh' /usr/local/sbin/element-deck-ensure-funnel.sh
cp -f '${user_home}/element-deck-tailscale-funnel.service' /etc/systemd/system/element-deck-tailscale-funnel.service
cp -f '${user_home}/element-deck-tailscale-funnel.timer' /etc/systemd/system/element-deck-tailscale-funnel.timer
rm -f /etc/systemd/system/element-deck-tailscale-funnel.time
chmod 644 /etc/systemd/system/element-deck-tailscale-funnel.service /etc/systemd/system/element-deck-tailscale-funnel.timer
systemctl daemon-reload
systemctl enable element-deck-tailscale-funnel.service element-deck-tailscale-funnel.timer
systemctl start element-deck-tailscale-funnel.timer
ELEMENT_DECK_FUNNEL_FORCE_REAPPLY=${ELEMENT_DECK_FUNNEL_FORCE_REAPPLY:-0} /usr/local/sbin/element-deck-ensure-funnel.sh
tailscale funnel status
rm -f '${user_home}/element-deck-ensure-funnel.sh' '${user_home}/element-deck-tailscale-funnel.service' '${user_home}/element-deck-tailscale-funnel.timer'
EOF
    then
        log_warn "Funnel enable via SSH failed"
        return 1
    fi

    log_success "Public HTTPS (Funnel): https://${DOMAIN}/"
    return 0
}

# DoH + HTTPS via Funnel edge IP (not MagicDNS). 0 = phones can reach the API.
wait_element_deck_funnel_public() {
    local host="${1:-${DOMAIN:-}}"
    local timeout="${2:-0}"
    local script
    script="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/scripts/wait-funnel-public.sh"
    [[ -n "$host" ]] || return 1
    if ! element_deck_public_funnel_wanted; then
        return 0
    fi
    if [[ ! -f "$script" ]]; then
        log_warn "Missing ${script} — skip public Funnel wait"
        return 1
    fi
    log_info "Verifying public Funnel DNS/HTTPS for ${host} (phones; not MagicDNS)..."
    if bash "$script" "$host" "$timeout"; then
        log_success "Public Funnel reachable: https://${host}/health"
        return 0
    fi
    log_warn "Public Funnel not visible yet — phones may show Can't reach Element Deck until DNS lands."
    log_warn "If phones still fail: DNS admin → HTTPS Certificates Enable; wait up to 10 min. Do not funnel-reset in a loop."
    return 1
}

# Disable Funnel unit + switch to Serve (tailnet-only). Used by enable-tailscale-https.sh.
disable_element_deck_tailscale_funnel() {
    local vmid="${1:?}"
    proxmox_exec_in_container "$vmid" \
        "systemctl disable --now element-deck-tailscale-funnel.timer 2>/dev/null || true; \
         systemctl disable --now element-deck-tailscale-funnel.service 2>/dev/null || true; \
         tailscale funnel reset 2>/dev/null || true; \
         true" || true
}
