#!/usr/bin/env bash
set -euo pipefail

cat <<'MSG'
Install these packages with your distribution package manager:
  git curl tar unzip
  gcc or clang plus make
  ripgrep
  fd
  nodejs and npm
  python3
  tree-sitter CLI
  stylua

Then install Neovim 0.12+ from a current package source or official release.
MSG

"$(dirname "$0")/doctor.sh"
