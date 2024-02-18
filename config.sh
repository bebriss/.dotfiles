#!/bin/bash
username=$(id -u -n 1000)
builddir=$(pwd)

# Moving config files
DIR="$builddir/.config"

for dir in "$DIR"/*; do
  mkdir -p "/home/$username/.config/"
  cp -rf "$dir" "/home/$username/.config/"
done

cp -rf scripts /home/$username/
cp -rf .zshrc /home/$username/
