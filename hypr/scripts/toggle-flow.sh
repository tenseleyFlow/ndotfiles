#!/usr/bin/env bash
# Toggle Hyprland animations on/off at runtime.

# Read current value (0/1) of animations:enabled
STATE="$(hyprctl -j getoption animations:enabled 2>/dev/null | sed -n 's/.*"int":\s*\([01]\).*/\1/p')"

if [ "$STATE" = "1" ]; then
  # Turn OFF (instant mode)
  hyprctl keyword animations:enabled 0
  # (Optional) kill any lingering “special” anim feel by forcing short workspace anims
  hyprctl keyword animations:workspacesIn "1 1 default slide"
  hyprctl keyword animations:workspacesOut "1 1 default slide"
  notify-send "hyprland flow" "animations OFF"
else
  # Turn ON (back to your config-defined animations)
  hyprctl keyword animations:enabled 1
  hyprctl reload
  notify-send "hyprland flow" "animations ON"
fi
