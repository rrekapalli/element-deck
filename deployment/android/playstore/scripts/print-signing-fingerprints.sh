#!/usr/bin/env bash
# Print Android signing fingerprints (debug|release) or convert SHA-1 hex → MSAL Base64.
# Usage:
#   ./scripts/print-signing-fingerprints.sh debug
#   ./scripts/print-signing-fingerprints.sh release
#   ./scripts/print-signing-fingerprints.sh --sha1-hex 'C9:01:8B:...'

set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../.." && pwd)"
TARGET="${1:-release}"
SHA1_HEX=""

sha1_to_msal() {
  local hex="${1//[: ]/}"
  hex="$(printf '%s' "$hex" | tr '[:lower:]' '[:upper:]')"
  if [[ ${#hex} -ne 40 ]]; then
    echo "SHA-1 hex must be 40 hex chars (colons optional)" >&2
    exit 1
  fi
  if command -v xxd >/dev/null 2>&1; then
    printf '%s' "$hex" | xxd -r -p | base64 | tr -d '\n'
    echo
  elif command -v python3 >/dev/null 2>&1; then
    python3 -c "import binascii,base64; print(base64.b64encode(binascii.unhexlify('$hex')).decode())"
  elif command -v python >/dev/null 2>&1; then
    python -c "import binascii,base64; print(base64.b64encode(binascii.unhexlify('$hex')).decode())"
  else
    echo "Need xxd or python to convert SHA-1 → MSAL Base64" >&2
    exit 1
  fi
}

if [[ "${1:-}" == "--sha1-hex" ]]; then
  SHA1_HEX="${2:-}"
  [[ -n "$SHA1_HEX" ]] || { echo "missing hex" >&2; exit 1; }
  echo "MSAL Base64: $(sha1_to_msal "$SHA1_HEX")"
  exit 0
fi

if [[ "$TARGET" == "debug" ]]; then
  KEYSTORE="${HOME}/.android/debug.keystore"
  # WSL: debug keystore lives on the Windows profile, not $HOME in the distro.
  if [[ ! -f "$KEYSTORE" ]]; then
    for candidate in \
      "/mnt/c/Users/rajar/.android/debug.keystore" \
      "/mnt/c/Users/${USER}/.android/debug.keystore" \
      "/mnt/c/Users/${WINUSER:-}/.android/debug.keystore"
    do
      if [[ -f "$candidate" ]]; then KEYSTORE="$candidate"; break; fi
    done
  fi
  ALIAS="androiddebugkey"
  PASS="android"
else
  PROPS="$ROOT/android/key.properties"
  [[ -f "$PROPS" ]] || { echo "Missing android/key.properties — run create-upload-keystore.sh" >&2; exit 1; }
  # shellcheck disable=SC1090
  storePassword=""; keyAlias="upload"; storeFile="upload-keystore.jks"
  while IFS= read -r line || [[ -n "$line" ]]; do
    [[ "$line" =~ ^[[:space:]]*# ]] && continue
    case "$line" in
      storePassword=*) storePassword="${line#storePassword=}" ;;
      keyAlias=*) keyAlias="${line#keyAlias=}" ;;
      storeFile=*) storeFile="${line#storeFile=}" ;;
    esac
  done <"$PROPS"
  ALIAS="$keyAlias"
  PASS="$storePassword"
  if [[ "$storeFile" = /* ]]; then
    KEYSTORE="$storeFile"
  else
    KEYSTORE="$ROOT/android/$storeFile"
  fi
fi

command -v keytool >/dev/null || { echo "keytool not on PATH" >&2; exit 1; }
[[ -f "$KEYSTORE" ]] || { echo "Keystore not found: $KEYSTORE" >&2; exit 1; }

OUT="$(keytool -list -v -keystore "$KEYSTORE" -alias "$ALIAS" -storepass "$PASS" 2>&1)"
SHA1="$(printf '%s\n' "$OUT" | sed -n 's/.*SHA1: *//p' | head -1 | tr -d '\r')"
SHA256="$(printf '%s\n' "$OUT" | sed -n 's/.*SHA256: *//p' | head -1 | tr -d '\r')"
# Some JDKs print "SHA-1:" with a hyphen
[[ -n "$SHA1" ]] || SHA1="$(printf '%s\n' "$OUT" | sed -n 's/.*SHA-1: *//p' | head -1 | tr -d '\r')"
[[ -n "$SHA256" ]] || SHA256="$(printf '%s\n' "$OUT" | sed -n 's/.*SHA-256: *//p' | head -1 | tr -d '\r')"
[[ -n "$SHA1" ]] || { echo "$OUT" >&2; echo "Failed to parse SHA1" >&2; exit 1; }

MSAL="$(sha1_to_msal "$SHA1" | tr -d '\r\n')"

echo ""
echo "=== Android signing fingerprints ($TARGET) ==="
echo "Package:     com.vislesha.element_deck"
echo "Keystore:    $KEYSTORE"
echo "Alias:       $ALIAS"
echo "SHA-1:       $SHA1"
echo "SHA-256:     $SHA256"
echo "MSAL Base64: $MSAL"
echo ""
echo "SHA1=$SHA1"
echo "SHA256=$SHA256"
echo "MSAL_BASE64=$MSAL"
