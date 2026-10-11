# shellcheck shell=bash
# Proxmox LXC helpers (local pct or remote via SSH).

init_proxmox_mode() {
    USE_REMOTE_PROXMOX=false
    if ! command -v pct >/dev/null 2>&1; then
        log_info "pct not found locally; using remote Proxmox (${PROXMOX_HOST})."
        USE_REMOTE_PROXMOX=true
    fi
    PROXMOX_SSH_OPTS="-o StrictHostKeyChecking=no -o ConnectTimeout=60 -o ServerAliveInterval=30"
}

_proxmox_remote() {
    if [[ -n "${PROXMOX_PASSWORD:-}" ]] && command -v sshpass >/dev/null 2>&1; then
        sshpass -p "$PROXMOX_PASSWORD" ssh $PROXMOX_SSH_OPTS "${PROXMOX_USER}@${PROXMOX_HOST}" "$@"
    else
        ssh $PROXMOX_SSH_OPTS "${PROXMOX_USER}@${PROXMOX_HOST}" "$@"
    fi
}

proxmox_find_container_by_name() {
    local name="$1"
    if [[ "$USE_REMOTE_PROXMOX" == true ]]; then
        _proxmox_remote "pct list 2>/dev/null | awk -v name=\"$name\" '\$NF == name {print \$1}' | head -n1"
    else
        pct list 2>/dev/null | awk -v name="$name" '$NF == name {print $1}' | head -n1
    fi
}

proxmox_container_exists() {
    [[ -n "$(proxmox_find_container_by_name "$1" | tr -d '[:space:]')" ]]
}

proxmox_start_container() {
    local vmid="$1"
    vmid=$(echo "$vmid" | tr -d '[:space:]')
    if [[ "$USE_REMOTE_PROXMOX" == true ]]; then
        _proxmox_remote "pct status $vmid 2>/dev/null | awk '{print \$2}'" | grep -q running && return 0
        _proxmox_remote "pct start $vmid" && sleep 2
    else
        pct status "$vmid" 2>/dev/null | awk '{print $2}' | grep -q running && return 0
        pct start "$vmid" && sleep 2
    fi
}

proxmox_exec_in_container() {
    local vmid="$1" cmd="$2" q
    q=$(printf '%q' "$cmd")
    if [[ "$USE_REMOTE_PROXMOX" == true ]]; then
        _proxmox_remote "pct exec $vmid -- bash -lc $q"
    else
        pct exec "$vmid" -- bash -lc "$cmd"
    fi
}

proxmox_push_file() {
    local vmid="$1" src="$2" dst="$3"
    [[ -f "$src" ]] || { log_error "Missing file: $src"; return 1; }
    local tmp="/tmp/$(basename "$src")-$$"
    if [[ "$USE_REMOTE_PROXMOX" == true ]]; then
        if [[ -n "${PROXMOX_PASSWORD:-}" ]] && command -v sshpass >/dev/null 2>&1; then
            sshpass -p "$PROXMOX_PASSWORD" scp $PROXMOX_SSH_OPTS "$src" "${PROXMOX_USER}@${PROXMOX_HOST}:${tmp}" || return 1
        else
            scp $PROXMOX_SSH_OPTS "$src" "${PROXMOX_USER}@${PROXMOX_HOST}:${tmp}" || return 1
        fi
        _proxmox_remote "pct push $vmid $tmp $dst && rm -f $tmp"
    else
        pct push "$vmid" "$src" "$dst"
    fi
}

proxmox_clone_container() {
    local template_name="$1" new_name="$2" new_vmid="$3" cores="$4" memory="$5"
    local template_vmid="${CLONE_TEMPLATE_VMID:-}"
    if [[ -z "$template_vmid" ]] || [[ ! "$template_vmid" =~ ^[0-9]+$ ]]; then
        if [[ "$USE_REMOTE_PROXMOX" == true ]]; then
            template_vmid=$(_proxmox_remote "pct list 2>/dev/null | tail -n +2 | awk -v name=\"$template_name\" '\$NF == name {print \$1}' | head -n1" | tr -d '[:space:]')
        else
            template_vmid=$(pct list 2>/dev/null | tail -n +2 | awk -v name="$template_name" '$NF == name {print $1}' | head -n1 | tr -d '[:space:]')
        fi
    fi
    [[ -n "$template_vmid" ]] || { log_error "Clone template '$template_name' not found (VMID ${CLONE_TEMPLATE_VMID:-unset})"; return 1; }

    log_info "Cloning template VMID $template_vmid -> $new_name ($new_vmid)..."
    local q_name
    q_name="$(printf '%q' "$new_name")"
    if [[ "$USE_REMOTE_PROXMOX" == true ]]; then
        _proxmox_remote "pct clone $template_vmid $new_vmid --hostname ${q_name} --full --storage ${LXC_ROOTFS_STORAGE}" || return 1
        _proxmox_remote "pct set $new_vmid --cores $cores --memory $memory --tags element-deck" 2>/dev/null || true
        _proxmox_remote "pct set $new_vmid --net0 name=eth0,bridge=vmbr0,ip=dhcp,ip6=off" 2>/dev/null || true
    else
        pct clone "$template_vmid" "$new_vmid" --hostname "$new_name" --full --storage "${LXC_ROOTFS_STORAGE}" || return 1
        pct set "$new_vmid" --cores "$cores" --memory "$memory" --tags element-deck 2>/dev/null || true
        pct set "$new_vmid" --net0 name=eth0,bridge=vmbr0,ip=dhcp,ip6=off 2>/dev/null || true
    fi
    echo "$new_vmid"
}

proxmox_find_container_by_vmid() {
    local vmid="$1"
    vmid=$(echo "$vmid" | tr -d '[:space:]')
    if [[ "$USE_REMOTE_PROXMOX" == true ]]; then
        _proxmox_remote "pct list 2>/dev/null | awk -v vmid=\"$vmid\" '\$1 == vmid {print \$NF}' | head -n1"
    else
        pct list 2>/dev/null | awk -v vmid="$vmid" '$1 == vmid {print $NF}' | head -n1
    fi
}

# True if name is the canonical LXC hostname or a known pre-rename alias.
element_deck_is_known_container_name() {
    local name="${1:-}"
    [[ -z "$name" ]] && return 1
    [[ "$name" == "${CONTAINER_NAME:-}" ]] && return 0
    local aliases="${CONTAINER_ALIASES:-element-deck}"
    local a
    local IFS=','
    for a in $aliases; do
        a="${a//[[:space:]]/}"
        [[ -n "$a" && "$name" == "$a" ]] && return 0
    done
    return 1
}

proxmox_set_container_hostname() {
    local vmid="$1" new_name="$2"
    local q_name
    vmid=$(echo "$vmid" | tr -d '[:space:]')
    q_name="$(printf '%q' "$new_name")"
    log_info "Renaming VMID $vmid hostname -> $new_name (in-place, no recreate)..."
    if [[ "$USE_REMOTE_PROXMOX" == true ]]; then
        _proxmox_remote "pct set $vmid --hostname ${q_name}"
    else
        pct set "$vmid" --hostname "$new_name"
    fi
}

_proxmox_destroy_vmid() {
    local vmid="$1"
    local hostname_hint="${2:-}"
    vmid=$(echo "$vmid" | tr -d '[:space:]')
    [[ -n "$vmid" ]] || return 0
    local rm_script="${DEPLOYMENT_DIR}/proxmox/remove-lxc-from-tailscale.sh"
    if [[ -f "$rm_script" ]]; then
        bash "$rm_script" "$vmid" "$hostname_hint" || true
    fi
    log_info "Destroying VMID $vmid..."
    if [[ "$USE_REMOTE_PROXMOX" == true ]]; then
        _proxmox_remote "pct stop $vmid" 2>/dev/null || true
        sleep 2
        _proxmox_remote "pct destroy $vmid --purge" || _proxmox_remote "pct destroy $vmid"
    else
        pct stop "$vmid" 2>/dev/null || true
        sleep 2
        pct destroy "$vmid" --purge 2>/dev/null || pct destroy "$vmid"
    fi
}

ensure_element_deck_container() {
    local recreate="${1:-false}"
    VMID=""
    local named_vmid occupant_name
    named_vmid=$(proxmox_find_container_by_name "$CONTAINER_NAME" | tr -d '[:space:]')
    occupant_name=""
    if [[ -n "$FIXED_VMID" ]]; then
        occupant_name="$(proxmox_find_container_by_vmid "$FIXED_VMID" | tr -d '[:space:]')"
    fi

    if [[ "$recreate" == true ]]; then
        local destroyed_vmid=""
        if [[ -n "$named_vmid" ]]; then
            log_info "Recreate: destroying '$CONTAINER_NAME' (VMID $named_vmid)..."
            _proxmox_destroy_vmid "$named_vmid" "$CONTAINER_NAME"
            destroyed_vmid="$named_vmid"
        fi
        if [[ -n "$occupant_name" && "$FIXED_VMID" != "$destroyed_vmid" ]]; then
            log_info "Recreate: VMID $FIXED_VMID is occupied by '$occupant_name'; destroying..."
            _proxmox_destroy_vmid "$FIXED_VMID" "$occupant_name"
        fi
        named_vmid=""
        occupant_name=""
    fi

    if [[ -n "$named_vmid" ]]; then
        VMID="$named_vmid"
        log_info "Found container '$CONTAINER_NAME' (VMID $VMID)"
    elif [[ -n "$occupant_name" ]]; then
        if element_deck_is_known_container_name "$occupant_name"; then
            VMID="$FIXED_VMID"
            if [[ "$occupant_name" != "$CONTAINER_NAME" ]]; then
                log_info "VMID $VMID is '$occupant_name' (legacy alias of '$CONTAINER_NAME'); keeping the LXC and renaming in-place."
                proxmox_set_container_hostname "$VMID" "$CONTAINER_NAME" || \
                    log_warn "Could not set Proxmox hostname; continuing with existing LXC '$occupant_name'"
            else
                log_info "Using existing VMID $VMID ($CONTAINER_NAME)"
            fi
        else
            log_error "VMID $FIXED_VMID is already used by '$occupant_name' (expected '$CONTAINER_NAME')"
            log_error "Re-run with --recreate to drop '$occupant_name' and create '$CONTAINER_NAME'."
            exit 1
        fi
    fi

    if [[ -z "$VMID" ]]; then
        if [[ -n "$CLONE_TEMPLATE" ]]; then
            proxmox_clone_container "$CLONE_TEMPLATE" "$CONTAINER_NAME" "$FIXED_VMID" "$CORES" "$MEMORY_MB" >/dev/null
            VMID="$FIXED_VMID"
        else
            log_error "Set ELEMENT_DECK_CLONE_TEMPLATE in deployment.conf (e.g. moneytree-lxc-frontend-base)"
            exit 1
        fi
        if [[ -n "$ROOTFS_GB" ]] && [[ "$ROOTFS_GB" =~ ^[0-9]+$ ]]; then
            if [[ "$USE_REMOTE_PROXMOX" == true ]]; then
                _proxmox_remote "pct resize $VMID rootfs ${ROOTFS_GB}G" 2>/dev/null || true
            else
                pct resize "$VMID" rootfs "${ROOTFS_GB}G" 2>/dev/null || true
            fi
        fi
    fi

    proxmox_start_container "$VMID" || exit 1
    if [[ "$USE_REMOTE_PROXMOX" == true ]]; then
        _proxmox_remote "pct set $VMID --onboot 1 --startup \"order=$VMID\"" 2>/dev/null || true
    else
        pct set "$VMID" --onboot 1 --startup "order=$VMID" 2>/dev/null || true
    fi
}

ensure_lxc_tailscale_prereqs() {
    local vmid="$1"
    log_info "Ensuring LXC has /dev/net/tun for Tailscale..."
    local cmd="
CONF=/etc/pve/lxc/${vmid}.conf
changed=0
grep -q 'dev/net/tun' \"\$CONF\" 2>/dev/null || {
  echo 'lxc.cgroup2.devices.allow: c 10:200 rwm' >> \"\$CONF\"
  echo 'lxc.mount.entry: /dev/net/tun dev/net/tun none bind,create=file' >> \"\$CONF\"
  changed=1
}
if [ \"\$changed\" = 1 ]; then
  pct stop ${vmid} 2>/dev/null || true
  sleep 2
  pct start ${vmid}
  sleep 3
fi
"
    if [[ "$USE_REMOTE_PROXMOX" == true ]]; then
        _proxmox_remote "$cmd"
    else
        bash -c "$cmd"
    fi
}

bootstrap_container_basics() {
    local vmid="$1"
    local safe_name q_name
    safe_name="$(printf '%s' "$CONTAINER_NAME" | tr -d '\r')"
    q_name="$(printf '%q' "$safe_name")"
    proxmox_exec_in_container "$vmid" "printf '%s\\n' ${q_name} > /etc/hostname && hostname -F /etc/hostname" || true
    proxmox_exec_in_container "$vmid" "systemctl stop systemd-resolved 2>/dev/null; systemctl disable systemd-resolved 2>/dev/null; systemctl mask systemd-resolved 2>/dev/null; rm -f /etc/resolv.conf; printf 'nameserver 8.8.8.8\nnameserver 8.8.4.4\nnameserver 100.100.100.100\n' > /etc/resolv.conf" || true
    proxmox_exec_in_container "$vmid" "
      if ! id ${CONTAINER_USER} >/dev/null 2>&1; then
        useradd -m -s /bin/bash ${CONTAINER_USER}
      fi
      if [[ -n '${CONTAINER_PASSWORD}' ]]; then
        echo '${CONTAINER_USER}:${CONTAINER_PASSWORD}' | chpasswd || true
      fi
    " || true
    proxmox_exec_in_container "$vmid" "command -v ufw >/dev/null 2>&1 && (ufw allow 22/tcp; ufw allow ${UI_PORT}/tcp; ufw --force enable) || true" || true
}

ensure_nginx() {
    local vmid="$1"
    if proxmox_exec_in_container "$vmid" "dpkg -l nginx 2>/dev/null | grep -q '^ii'"; then
        return 0
    fi
    log_info "Installing nginx and unzip..."
    proxmox_exec_in_container "$vmid" "DEBIAN_FRONTEND=noninteractive apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -y -qq nginx unzip curl" || return 1
}
