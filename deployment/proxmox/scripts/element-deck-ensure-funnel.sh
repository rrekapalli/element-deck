#!/bin/bash
# Keep Tailscale Funnel on nginx :80 (public HTTPS for phones without Tailscale).
#
# Do not reset Funnel just because public DNS is NXDOMAIN. Only re-apply when
# Funnel is actually off, or ELEMENT_DECK_FUNNEL_FORCE_REAPPLY=1.
set -euo pipefail

if ! command -v tailscale >/dev/null 2>&1; then
  echo "ERROR: tailscale not installed" >&2
  exit 1
fi

if ! tailscale status >/dev/null 2>&1; then
  echo "ERROR: tailscaled not ready" >&2
  exit 1
fi

local_funnel_on() {
  printf '%s\n' "$1" | grep -qi 'Funnel on'
}

status="$(tailscale funnel status 2>/dev/null || true)"
force="${ELEMENT_DECK_FUNNEL_FORCE_REAPPLY:-}"

if [[ "$force" != "1" ]] && local_funnel_on "$status"; then
  echo "Funnel already on — not resetting"
  echo "$status"
  exit 0
fi

echo "Applying tailscale funnel --bg 80"
tailscale serve reset 2>/dev/null || true
if [[ "$force" == "1" ]]; then
  tailscale funnel reset 2>/dev/null || true
  tailscale down --accept-risk=lose-ssh 2>/dev/null || tailscale down 2>/dev/null || true
  sleep 2
  tailscale up --accept-dns=false --accept-routes --accept-risk=lose-ssh 2>/dev/null \
    || tailscale up --accept-dns=false --accept-routes 2>/dev/null \
    || tailscale up 2>/dev/null || true
  sleep 2
fi
tailscale funnel --bg 80

status="$(tailscale funnel status 2>/dev/null || true)"
if ! local_funnel_on "$status"; then
  echo "ERROR: Funnel did not enable. Check ACL Funnel nodeAttrs and HTTPS Certificates." >&2
  printf '%s\n' "$status" >&2
  exit 1
fi

echo "$status"
