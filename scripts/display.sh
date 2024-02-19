#!/bin/bash

# Check if DP-1-5 is connected
dp_connected=$(xrandr --query | grep 'DP-1-5 connected')

# Check if DP-1-5 is currently the active primary monitor
dp_active=$(xrandr --query | grep 'DP-1-5 connected primary')

if [[ ! -z $dp_connected ]]; then
	if [[ -z $dp_active ]]; then
		# DP-1-5 is connected but not active, switch to DP-1-5
		xrandr --output DP-1-5 --auto --primary
		xrandr --output eDP-1 --off
	else
		# DP-1-5 is connected and active, switch back to eDP-1
		xrandr --output eDP-1 --auto --primary
		xrandr --output DP-1-5 --off
	fi
else
	# DP-1-5 is not connected, make sure eDP-1 is active
	xrandr --output eDP-1 --auto --primary
fi
