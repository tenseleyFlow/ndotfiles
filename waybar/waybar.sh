#!/usr/bin/env sh

# Terminate already running bar instances
killall -q waybar

# Wait until the processes have been shut down
while pgrep -x waybar >/dev/null; do sleep 1; done

# Launch waybar for landscape monitors
waybar -c ~/.config/waybar/config-landscape &

# Launch waybar for portrait monitor
waybar -c ~/.config/waybar/config-portrait &
