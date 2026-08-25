#!/usr/bin/env bash
set -euo pipefail

if [[ ${1:-} != "--yes" || $# -ne 1 ]]; then
  echo "Usage: $0 --yes" >&2
  exit 64
fi

codex_root="${CODEX_HOME:-${HOME}/.codex}"
target_dir="$codex_root/pets/bonzi"

if [[ ! -d "$target_dir" ]]; then
  echo "Bonzi is not installed at $target_dir"
  exit 0
fi

rm -f -- "$target_dir/pet.json" "$target_dir/spritesheet.webp"
if rmdir "$target_dir" 2>/dev/null; then
  echo "Removed Bonzi from $target_dir"
else
  echo "Removed Bonzi pet files; preserved unexpected files in $target_dir"
fi
