#!/usr/bin/env bash
# Simple working version that avoids complex quoting
set -euo pipefail

HOST="espadon@almanta"
SSH_OPTS=(-T -o BatchMode=yes -o ConnectTimeout=3 -o ConnectionAttempts=1)

# Test connectivity
if ! ssh "${SSH_OPTS[@]}" "$HOST" "echo 'test'" >/dev/null 2>&1; then
  echo '{"text":"⚬ almanta: down","tooltip":"SSH connection failed","class":"down"}'
  exit 0
fi

# Get metrics with very simple commands
get_load() {
  ssh "${SSH_OPTS[@]}" "$HOST" "cut -d' ' -f1 /proc/loadavg" 2>/dev/null || echo "?"
}

get_disk() {
  ssh "${SSH_OPTS[@]}" "$HOST" "df / | tail -1 | awk '{print \$5}' | tr -d '%'" 2>/dev/null || echo "?"
}

get_memory() {
  ssh "${SSH_OPTS[@]}" "$HOST" "free | grep '^Mem:' | awk '{printf \"%.0f\", (\$3/\$2)*100}'" 2>/dev/null || echo "?"
}

get_service() {
  # Check for web services
  for service in nginx httpd apache2; do
    if ssh "${SSH_OPTS[@]}" "$HOST" "systemctl is-active --quiet $service" 2>/dev/null; then
      echo "$service|active"
      return
    elif ssh "${SSH_OPTS[@]}" "$HOST" "systemctl list-unit-files | grep -q '^$service\.service'" 2>/dev/null; then
      echo "$service|inactive" 
      return
    fi
  done
  echo "web|unknown"
}

get_uptime() {
  ssh "${SSH_OPTS[@]}" "$HOST" "uptime -p" 2>/dev/null || echo ""
}

# Gather all metrics
load=$(get_load)
disk=$(get_disk) 
mem=$(get_memory)
up=$(get_uptime)

# Get service info
service_info=$(get_service)
IFS='|' read -r svc web <<<"$service_info"

# Build output - escape newlines properly for JSON
text="⚬ ${svc:-web}  L:$load  M:$mem%  D:$disk%"
tip="almanta (${svc:-—}): ${web:-unknown}\\nload(1m): $load\\nmemory: $mem%\\ndisk /: $disk%\\n$up"

# Determine class
class="ok"
[ "${web:-unknown}" != "active" ] && class="warn"
[[ "$mem" =~ ^[0-9]+$ ]] && [ "$mem" -ge 90 ] && class="warn"  
[[ "$disk" =~ ^[0-9]+$ ]] && [ "$disk" -ge 90 ] && class="warn"

# Use jq for proper JSON encoding to handle all special characters
jq -cn --arg text "$text" --arg tooltip "$tip" --arg class "$class" \
  '{text:$text, tooltip:$tooltip, class:$class}'
