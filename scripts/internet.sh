#!/bin/bash

manage_eth() {
	# Fetch the names of Ethernet connections
	eth_connections=$(nmcli -t -f name,type connection show | grep "ethernet" | cut -d':' -f1)

	if [[ -z "$eth_connections" ]]; then
		echo "No Ethernet connections available."
		return
	fi

	# Present the Ethernet connections for user selection
	eth_connection_name=$(echo "$eth_connections" | dmenu -i -p "Select Ethernet connection:")

	if [[ -n "$eth_connection_name" ]]; then
		echo "Connecting to Ethernet ($eth_connection_name)..."
		nmcli connection up "$eth_connection_name"
	else
		echo "No Ethernet connection selected."
	fi
}

# Function to manage WiFi connection
manage_wifi() {
	wifi_status=$(nmcli radio wifi)

	# Sub-menu for WiFi management
	options="Enable WiFi\nDisable WiFi\nConnect to a WiFi Network"
	selected_option=$(echo -e "$options" | dmenu -i -p "Manage WiFi:")

	case $selected_option in
	"Enable WiFi")
		nmcli radio wifi on
		;;
	"Disable WiFi")
		nmcli radio wifi off
		;;
	"Connect to a WiFi Network")
		if [[ $wifi_status == "enabled" ]]; then
			ssid=$(nmcli --fields IN-USE,SSID,BSSID,SIGNAL,SECURITY dev wifi | sed '/^--/d' | sed '1d' | sed 's/^\s*//;s/\s*$//' | dmenu -i -p "Select Network:" | awk -F '  +' '{print $2}')
			if [[ -n "$ssid" ]]; then
				nmcli device wifi connect "$ssid" --ask
			else
				echo "No network selected."
			fi
		else
			echo "WiFi is not enabled. Please enable WiFi first."
		fi
		;;
	esac
}

# Main menu for network management
main_options="Manage Ethernet\nManage WiFi"
choice=$(echo -e "$main_options" | dmenu -i -p "Select option:")

case $choice in
"Manage Ethernet")
	manage_eth
	;;
"Manage WiFi")
	manage_wifi
	;;
*)
	echo "Invalid option. Exiting."
	;;
esac
