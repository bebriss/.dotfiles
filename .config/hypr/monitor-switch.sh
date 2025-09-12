#!/usr/bin/env zsh

if [[ "$(hyprctl monitors)" =~ "\sDP-" ]]; then
  if [[ $1 == "open" ]]; then
    hyprctl keyword monitor "eDP-1,1920x1080,2560x0,1"
  else
    hyprctl keyword monitor "eDP-1,disable"
  fi
fi
