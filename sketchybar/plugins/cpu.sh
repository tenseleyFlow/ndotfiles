#!/usr/bin/env bash
# show total CPU load, e.g. "12.3%",
# within dynamic sketchybar
#
# TODO: @espadonne (mfw) color-code cpu ico

cpu="$(top -l 1 | awk -F'[:,%]' '/CPU usage/ { usage = $2 + $4; printf("%.1f%%", usage) }')"

sketchybar --set "$NAME" label="${cpu}"
