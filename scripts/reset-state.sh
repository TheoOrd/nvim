#!/usr/bin/env bash
set -euo pipefail

data_dir="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/nvim"
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/nvim"

cat <<MSG
This will remove local Neovim plugin installs, state, and cache:
  $data_dir
  $state_dir
  $cache_dir

It will not delete this config repository.
MSG

read -r -p "Continue? [y/N] " answer
case "$answer" in
  y|Y|yes|YES)
    rm -rf "$data_dir" "$state_dir" "$cache_dir"
    echo "Removed local Neovim state."
    ;;
  *)
    echo "Cancelled."
    ;;
esac
