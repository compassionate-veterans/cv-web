#!/usr/bin/env bash
# Regenerate web-ready WebPs from the source images in img/originals/.
#
# Source:  img/originals/*.{png,jpg,jpeg}   (committed brand source assets)
# Output:  img/web/*.webp                   (served to the browser)
#
# Usage:   ./scripts/optimize-images.sh              # rebuild all
#          ./scripts/optimize-images.sh community    # rebuild one
#
# Requires: cwebp (Homebrew: `brew install webp`)

set -euo pipefail
cd "$(dirname "$0")/.."

command -v cwebp >/dev/null 2>&1 || {
  echo "error: cwebp not found. install with: brew install webp" >&2; exit 1;
}

mkdir -p img/web

# name:quality:max_edge  (sources live in img/originals/)
# Note: the logo lockup + OG image are built separately via ImageMagick from
# img/originals/logo-lockup-trans.png (transparent), not by this cwebp pass.
TARGETS=(
  "community:82:1600"
)

process() {
  local name="$1" q="$2" edge="$3" src=""
  for ext in png jpg jpeg; do
    [ -f "img/originals/${name}.${ext}" ] && { src="img/originals/${name}.${ext}"; break; }
  done
  [ -n "$src" ] || { echo "  skip (no source): $name"; return; }
  cwebp -q "$q" -m 6 -resize "$edge" 0 -mt -quiet "$src" -o "img/web/${name}.webp"
  printf "  %-24s %s\n" "${name}.webp" "$(ls -lh "img/web/${name}.webp" | awk '{print $5}')"
}

filter="${1:-}"
for t in "${TARGETS[@]}"; do
  IFS=: read -r name q edge <<< "$t"
  [ -z "$filter" ] || [ "$filter" = "$name" ] && process "$name" "$q" "$edge"
done
echo "done."
