#!/usr/bin/env bash
set -euo pipefail

required_nvim="0.12.0"

sudo apt update
sudo apt install -y \
  git curl tar unzip build-essential \
  ripgrep fd-find \
  nodejs npm \
  python3 python3-pip python3-venv

if ! sudo apt install -y tree-sitter-cli; then
  echo "tree-sitter-cli was not available from apt. Install it from npm or your preferred package source." >&2
fi

if ! sudo apt install -y stylua; then
  echo "stylua was not available from apt. Install it from Mason, cargo, or GitHub releases." >&2
fi

if ! command -v nvim >/dev/null 2>&1; then
  cat >&2 <<'MSG'
Neovim is not installed.
Install Neovim 0.12+ from an official release tarball, AppImage, Homebrew on Linux,
or another current source. Avoid old Ubuntu apt packages if they are below 0.12.
MSG
  exit 1
fi

version="$(nvim --version | awk 'NR==1 { sub(/^v/, "", $2); print $2 }')"
if [ "$(printf '%s\n%s\n' "$required_nvim" "$version" | sort -V | head -n1)" != "$required_nvim" ]; then
  echo "Neovim $required_nvim or newer is required. Found $version." >&2
  exit 1
fi

echo "WSL dependencies look ready."
