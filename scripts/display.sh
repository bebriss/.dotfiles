#!/bin/bash

# Function to get connected monitors
get_connected_monitors() {
	xrandr --query | grep " connected" | awk '{print $1}'
}

# Function for automatic configuration
auto_configure() {
	local monitors=($(get_connected_monitors))
	local count=${#monitors[@]}

	# If only the laptop screen is connected
	if [ "$count" -eq 1 ]; then
		xrandr --output ${monitors[0]} --auto --primary
	elif [ "$count" -eq 2 ]; then
		# Assuming the first is the laptop and the second is the external monitor
		xrandr --output ${monitors[0]} --off --output ${monitors[1]} --auto --primary
	else
		# More complex setup, prompt for manual selection
		manual_selection
	fi
}

# Function for manual selection via dmenu
manual_selection() {
	local monitors=($(get_connected_monitors))
	local selected=$(printf "%s\n" "${monitors[@]}" | dmenu -i -p "Select primary display:")

	# Enable selected monitor as primary, turn off others
	for monitor in "${monitors[@]}"; do
		if [ "$monitor" == "$selected" ]; then
			xrandr --output "$monitor" --auto --primary
		else
			xrandr --output "$monitor" --off
		fi
	done
}

# Main logic
monitors=($(get_connected_monitors))
if [ ${#monitors[@]} -gt 1 ]; then
	# If more than one monitor is connected, ask the user
	choice=$(echo -e "Auto-configure\nManual selection" | dmenu -i -p "Choose an option:")
	case $choice in
	"Auto-configure") auto_configure ;;
	"Manual selection") manual_selection ;;
	esac
else
	# If only one monitor is connected, automatically use it
	auto_configure
fi
