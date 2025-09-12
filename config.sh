#!/bin/bash
set -euo pipefail

username=$(id -u -n 1000)
builddir=$(pwd)
config_src="$builddir/.config"
config_dst="/home/$username/.config"

# Ensure destination config directory exists
mkdir -p "$config_dst"

for dir in "$config_src"/*; do
  name=$(basename "$dir")

  if [[ "$name" == "nvim" ]]; then
    # Special handling for nvim (LazyVim)
    mkdir -p "$config_dst/nvim"
    cp -rf "$dir/lua" "$config_dst/nvim/"
    # Optional: copy init.lua if present
    if [[ -f "$dir/init.lua" ]]; then
      cp -f "$dir/init.lua" "$config_dst/nvim/"
    fi
  else
    # Normal handling for everything else
    cp -rf "$dir" "$config_dst/"
  fi
done

# Copy scripts and zshrc
mkdir -p "/home/$username/.local/bin"
cp -rf "$builddir/scripts/"* "/home/$username/.local/bin/"
cp -f "$builddir/.zshrc" "/home/$username/"
