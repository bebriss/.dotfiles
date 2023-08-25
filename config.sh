#!/bin/bash
username=$(id -u -n 1000)
builddir=$(pwd)

# Moving config files
DIR="$builddir/.config"

for dir in "$DIR"/*; do
  # If nvim, copy according to nvchad config 
  if [[ "$dir" == "$DIR/nvim" ]]; then
    mkdir -p "/home/$username/.config/nvim/lua/custom/"
    cp -rf "$dir/lua/custom/"* "/home/$username/.config/nvim/lua/custom/"
  else
    # For other directories, copy them directly to the target location
    mkdir -p "/home/$username/.config/"
    cp -rf "$dir" "/home/$username/.config/"
  fi
done

cp -rf scripts /home/$username/
cp -rf .zshrc /home/$username/
chsh -s $(which zsh)

