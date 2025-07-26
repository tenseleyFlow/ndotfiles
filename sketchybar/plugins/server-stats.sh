

#!/usr/bin/env zsh
#
# server-stats.sh <host>
#   Polls <host> over SSH for one‑minute load average and memory usage,
#   then updates the SketchyBar item named $NAME (set automatically).
#
# Example in sketchybarrc:
#   sketchybar --add item srv_right right \
#              --set srv_right update_freq=30 \
#                           script="$PLUGDIR/server-stats.sh myserver" \
#                           icon=$'\uf233'
#
########################################################################

HOST="$1"
ITEM_NAME="${NAME:-server_stats}"

[[ -z "$HOST" ]] && sketchybar --set "$ITEM_NAME" label="No host" icon="󰜺" && exit 0

# Use ControlMaster for speed if configured
SSH="ssh -o ConnectTimeout=2 -o BatchMode=yes $HOST"

LOAD=$($SSH "awk '{print \$1}' /proc/loadavg" 2>/dev/null)
MEM=$($SSH "free -m | awk '/Mem:/ {printf \"%d\", (\$3*100)/\$2}'" 2>/dev/null)

if [[ -z "$LOAD" || -z "$MEM" ]]; then
  sketchybar --set "$ITEM_NAME" label="offline" icon="󱈸"
  exit 0
fi

LABEL="${LOAD} / ${MEM}%"
# ICON=$'\uf1c0'   # database icon

# Colour shifts with load relative to 1.0
COLOR_GREEN=0xff8AED9C
COLOR_ORANGE=0xffffc300
COLOR_RED=0xffff3c00
if (( ${LOAD/.*} < 1 )); then COLOR=$COLOR_GREEN
elif (( ${LOAD/.*} < 2 )); then COLOR=$COLOR_ORANGE
else COLOR=$COLOR_RED
fi

sketchybar --set "$ITEM_NAME" \
           icon.font="Font Awesome 6 Pro:Regular:18" \
           icon.color="$COLOR" \
           label="$LABEL"