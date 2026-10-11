#!/bin/bash
# One-shot public Funnel check (DNS-over-HTTPS). Does not block deploy.
# Usage: wait-funnel-public.sh <host> [timeout_sec ignored]
set -euo pipefail

HOST="${1:?host (e.g. elementdeck.tailce422e.ts.net)}"
HOST="${HOST#https://}"
HOST="${HOST%%/*}"

pub_ip="$(python3 - "$HOST" <<'PY'
import ipaddress, json, sys, urllib.request

host = sys.argv[1]
cgnat = ipaddress.ip_network("100.64.0.0/10")

def answers(qtype: str):
    url = f"https://dns.google/resolve?name={host}&type={qtype}"
    try:
        with urllib.request.urlopen(url, timeout=5) as resp:
            return json.load(resp)
    except Exception:
        return {}

def global_ip(payload):
    if payload.get("Status") != 0:
        return None
    for ans in payload.get("Answer") or []:
        data = (ans.get("data") or "").split()[0]
        try:
            addr = ipaddress.ip_address(data)
        except Exception:
            continue
        if addr in cgnat or not addr.is_global:
            continue
        return str(addr)
    return None

ip = global_ip(answers("A")) or global_ip(answers("AAAA"))
if not ip:
    sys.exit(1)
print(ip)
PY
)" || {
  echo "Public DNS not ready for ${HOST} — watchdog will retry."
  exit 1
}

echo "Public DNS ${HOST} -> ${pub_ip}"
code="$(curl -s -o /dev/null -w '%{http_code}' --max-time 8 --resolve "${HOST}:443:${pub_ip}" "https://${HOST}/health" || true)"
if [[ "$code" == "200" ]]; then
  echo "Public HTTPS /health OK via Funnel edge ${pub_ip}"
  exit 0
fi
echo "DNS ready but https://${HOST}/health returned ${code:-none} via ${pub_ip}"
exit 1
