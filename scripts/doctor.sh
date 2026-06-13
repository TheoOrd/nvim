#!/usr/bin/env bash
set -euo pipefail

required_nvim="0.12.0"

need() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    return 1
  fi
}

need nvim
need git
need rg
if ! command -v fd >/dev/null 2>&1 && ! command -v fdfind >/dev/null 2>&1; then
  echo "Missing required command: fd or fdfind" >&2
  exit 1
fi
need node
need npm
need python3
need tree-sitter
if ! command -v gcc >/dev/null 2>&1 && ! command -v cc >/dev/null 2>&1; then
  echo "Missing required command: gcc or cc" >&2
  exit 1
fi

if ! command -v stylua >/dev/null 2>&1; then
  echo "Optional formatter missing: stylua" >&2
fi

version="$(nvim --version | awk 'NR==1 { sub(/^v/, "", $2); print $2 }')"
if [ "$(printf '%s\n%s\n' "$required_nvim" "$version" | sort -V | head -n1)" != "$required_nvim" ]; then
  echo "Neovim $required_nvim or newer is required. Found $version." >&2
  exit 1
fi

nvim --headless "+checkhealth" "+qa"

echo "Doctor checks completed."
