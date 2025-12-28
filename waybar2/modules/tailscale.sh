#!/usr/bin/env bash
set -euo pipefail

# Get tailscale status
status_output=$(tailscale status 2>&1) || {
    echo '{"text":"TS: down","tooltip":"Tailscale not running","class":"disconnected"}'
    exit 0
}

# Check if we're connected (if status command worked, we have output)
if [[ -z "$status_output" ]] || echo "$status_output" | grep -qi "stopped\|not running"; then
    echo '{"text":"TS: off","tooltip":"Tailscale is not running","class":"disconnected"}'
    exit 0
fi

# Get current hostname
my_hostname=$(tailscale status --self --json 2>/dev/null | jq -r '.Self.HostName // empty' 2>/dev/null) || my_hostname=""

# Count online devices (lines that don't contain "offline")
online_count=$(echo "$status_output" | grep -v "^#" | grep -v "offline" | grep -c "^[0-9]" 2>/dev/null) || online_count=0
total_count=$(echo "$status_output" | grep -v "^#" | grep -c "^[0-9]" 2>/dev/null) || total_count=0

# Build tooltip with device list
tooltip="Tailnet Devices ($online_count/$total_count online)"
tooltip+=$'\n'"─────────────────────────────"

while IFS= read -r line; do
    # Skip comments and empty lines
    [[ "$line" =~ ^# ]] && continue
    [[ -z "$line" ]] && continue

    # Parse: IP hostname user OS status...
    ip=$(echo "$line" | awk '{print $1}')
    hostname=$(echo "$line" | awk '{print $2}')
    os=$(echo "$line" | awk '{print $4}')

    # Skip if not a valid IP line
    [[ ! "$ip" =~ ^100\. ]] && continue

    # Check if online or offline
    if echo "$line" | grep -q "offline"; then
        status_icon="○"
        # Extract last seen info (already includes "ago")
        last_seen=$(echo "$line" | grep -oP 'last seen \K[^,]+' | sed 's/ *$//' || echo "")
        device_info="$status_icon $hostname ($os) - offline"
        [[ -n "$last_seen" ]] && device_info="$status_icon $hostname ($os) - $last_seen"
    else
        status_icon="●"
        device_info="$status_icon $hostname ($os) - $ip"
    fi

    # Mark current device
    if [[ "$hostname" == "$my_hostname" ]]; then
        device_info="$device_info [this device]"
    fi

    tooltip+=$'\n'"$device_info"
done <<< "$status_output"

# Determine class based on status
if [[ "$online_count" -gt 0 ]]; then
    class="connected"
else
    class="partial"
fi

# Output JSON
jq -cn --arg text "TS: $online_count" --arg tooltip "$tooltip" --arg class "$class" \
    '{text:$text, tooltip:$tooltip, class:$class}'
