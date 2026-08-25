#!/usr/bin/env bash
set -euo pipefail

force=0
if [[ ${1:-} == "--force" ]]; then
  force=1
  shift
fi
if [[ $# -ne 0 ]]; then
  echo "Usage: $0 [--force]" >&2
  exit 64
fi

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
plugin_dir=$(CDPATH= cd -- "$script_dir/.." && pwd)
source_dir="$plugin_dir/assets/pet/bonzi"
codex_root="${CODEX_HOME:-${HOME}/.codex}"
target_dir="$codex_root/pets/bonzi"

expected_sprite="6171db4dffa833c4ed6d1cde4828753f92a4209498431502b0860fc5dfbcc145"
expected_pet="5aab8bddc9e0cd01042b6667843abe1a38bb049b94c9e1bbc081bc57bd5e9a0b"

sha256_file() {
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{print $1}'
  elif command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  else
    echo "A SHA-256 utility (shasum or sha256sum) is required." >&2
    return 127
  fi
}

verify_hash() {
  local path=$1
  local expected=$2
  local actual
  actual=$(sha256_file "$path")
  if [[ "$actual" != "$expected" ]]; then
    echo "Checksum mismatch: $path" >&2
    return 1
  fi
}

verify_hash "$source_dir/spritesheet.webp" "$expected_sprite"
verify_hash "$source_dir/pet.json" "$expected_pet"

if [[ -f "$target_dir/spritesheet.webp" && -f "$target_dir/pet.json" ]] && \
   cmp -s "$source_dir/spritesheet.webp" "$target_dir/spritesheet.webp" && \
   cmp -s "$source_dir/pet.json" "$target_dir/pet.json"; then
  echo "Bonzi is already installed and verified at $target_dir"
  exit 0
fi

if [[ -e "$target_dir/spritesheet.webp" || -e "$target_dir/pet.json" ]] && [[ $force -ne 1 ]]; then
  echo "A different Bonzi package already exists at $target_dir" >&2
  echo "Re-run with --force only after approving replacement." >&2
  exit 2
fi

mkdir -p "$target_dir"
tmp_sprite=$(mktemp "$target_dir/.spritesheet.webp.XXXXXX")
tmp_pet=$(mktemp "$target_dir/.pet.json.XXXXXX")
cleanup() {
  [[ -n ${tmp_sprite:-} ]] && rm -f -- "$tmp_sprite"
  [[ -n ${tmp_pet:-} ]] && rm -f -- "$tmp_pet"
  return 0
}
trap cleanup EXIT HUP INT TERM

cp "$source_dir/spritesheet.webp" "$tmp_sprite"
cp "$source_dir/pet.json" "$tmp_pet"
verify_hash "$tmp_sprite" "$expected_sprite"
verify_hash "$tmp_pet" "$expected_pet"
chmod 0644 "$tmp_sprite" "$tmp_pet"
mv -f "$tmp_sprite" "$target_dir/spritesheet.webp"
tmp_sprite=""
mv -f "$tmp_pet" "$target_dir/pet.json"
tmp_pet=""

verify_hash "$target_dir/spritesheet.webp" "$expected_sprite"
verify_hash "$target_dir/pet.json" "$expected_pet"
echo "Installed and verified Bonzi at $target_dir"
