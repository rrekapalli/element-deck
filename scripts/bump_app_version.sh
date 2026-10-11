#!/usr/bin/env bash
# Bump Element Deck app version in pubspec.yaml before a deploy build.
#
# Flutter format: MAJOR.MINOR.PATCH+BUILD
#   Default:        keep MAJOR, MINOR += 1, PATCH = 0, BUILD += 1
#   --major N:      set MAJOR = N (if changed: MINOR=0, PATCH=0), BUILD += 1
#   --major:        MAJOR += 1, MINOR = 0, PATCH = 0, BUILD += 1
#
# Usage:
#   ./scripts/bump_app_version.sh
#   ./scripts/bump_app_version.sh --major 1
#   ./scripts/bump_app_version.sh --major
#   ./scripts/bump_app_version.sh --dry-run
#   ./scripts/bump_app_version.sh --print   # print current version only

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PUBSPEC="${ROOT_DIR}/pubspec.yaml"

MAJOR_ARG=""
BUMP_MAJOR=false
DRY_RUN=false
PRINT_ONLY=false

show_help() {
  cat <<'EOF'
Usage: ./scripts/bump_app_version.sh [OPTIONS]

Update pubspec.yaml version for the next deploy/build.

OPTIONS:
  --major [N]   Set major to N, or omit N to increment major by 1.
                When major changes: minor and patch reset to 0.
                When major is unchanged: behave like a normal minor bump.
  --dry-run     Print the next version without writing pubspec.yaml
  --print       Print the current version and exit
  --help, -h    Show this help

Default (no --major): preserve major, increment minor, reset patch, increment build.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --major)
      BUMP_MAJOR=true
      if [[ $# -ge 2 && "$2" =~ ^[0-9]+$ ]]; then
        MAJOR_ARG="$2"
        shift 2
      else
        shift
      fi
      ;;
    --dry-run) DRY_RUN=true; shift ;;
    --print) PRINT_ONLY=true; shift ;;
    --help|-h) show_help; exit 0 ;;
    *)
      echo "Unknown option: $1" >&2
      show_help
      exit 1
      ;;
  esac
done

[[ -f "$PUBSPEC" ]] || {
  echo "ERROR: missing $PUBSPEC" >&2
  exit 1
}

current_line="$(grep -E '^version:' "$PUBSPEC" | head -n1 || true)"
[[ -n "$current_line" ]] || {
  echo "ERROR: no version: line in $PUBSPEC" >&2
  exit 1
}

# Accept "version: 1.2.3+4" or "version: 1.2.3"
if [[ "$current_line" =~ ^version:[[:space:]]*([0-9]+)\.([0-9]+)\.([0-9]+)(\+([0-9]+))? ]]; then
  major="${BASH_REMATCH[1]}"
  minor="${BASH_REMATCH[2]}"
  patch="${BASH_REMATCH[3]}"
  build="${BASH_REMATCH[5]:-0}"
else
  echo "ERROR: cannot parse version from: $current_line" >&2
  echo "Expected: version: MAJOR.MINOR.PATCH+BUILD" >&2
  exit 1
fi

current="${major}.${minor}.${patch}+${build}"

if [[ "$PRINT_ONLY" == true ]]; then
  echo "$current"
  exit 0
fi

new_major="$major"
new_minor="$minor"
new_patch="$patch"
new_build=$((build + 1))

if [[ "$BUMP_MAJOR" == true ]]; then
  if [[ -n "$MAJOR_ARG" ]]; then
    new_major="$MAJOR_ARG"
  else
    new_major=$((major + 1))
  fi
  if [[ "$new_major" -ne "$major" ]]; then
    new_minor=0
    new_patch=0
  else
    # Same major requested → normal minor bump under that major.
    new_minor=$((minor + 1))
    new_patch=0
  fi
else
  new_minor=$((minor + 1))
  new_patch=0
fi

next="${new_major}.${new_minor}.${new_patch}+${new_build}"

if [[ "$DRY_RUN" == true ]]; then
  echo "$next"
  echo "dry-run: would change ${current} → ${next}" >&2
  exit 0
fi

# Portable in-place edit (GNU sed and BSD sed).
tmp="$(mktemp)"
# shellcheck disable=SC2001
sed "s/^version:[[:space:]]*.*/version: ${next}/" "$PUBSPEC" >"$tmp"
mv "$tmp" "$PUBSPEC"

echo "$next"
echo "Bumped app version: ${current} → ${next}" >&2
