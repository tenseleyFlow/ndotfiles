#!/bin/bash

# Get wifi interface name
WIFI_DEVICE=$(networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}')

# Get wifi info using networksetup
WIFI_STATE=$(networksetup -getairportpower "$WIFI_DEVICE" | awk '{print $NF}')
CURRENT_NETWORK=$(networksetup -getairportnetwork "$WIFI_DEVICE" | awk -F": " '{print $2}')

# Use system_profiler for signal strength (returns RSSI in dBm)
SIGNAL_INFO=$(system_profiler SPAirPortDataType 2>/dev/null | awk '/Signal \/ Noise/ {print $4; exit}')
RSSI=$SIGNAL_INFO
[[ -z "$RSSI" ]] && RSSI=0

# Function to get appropriate icon based on signal strength
get_wifi_icon() {
    local strength=$1
    
    if [[ -z "$strength" ]] || [[ "$WIFI_STATE" == "Off" ]]; then
        echo "󰤮" # Disconnected
        return
    fi
    
    # RSSI is negative, so we compare directly
    if (( strength >= -50 )); then
        echo "󰤨" # Full (greater than -50 dBm)
    elif (( strength >= -60 )); then
        echo "󰤥" # Good (between -60 and -50 dBm)
    elif (( strength >= -70 )); then
        echo "󰤢" # Fair (between -70 and -60 dBm)
    else
        echo "󰤟" # Poor (less than -70 dBm)
    fi
}

# Get icon
ICON=$(get_wifi_icon "$RSSI")

# Update sketchybar
if [[ "$WIFI_STATE" == "On" ]]; then
    sketchybar --set wifi icon="$ICON" label="${RSSI} dBm"
else
    sketchybar --set wifi icon="󰤮" label="Not Connected"
fi