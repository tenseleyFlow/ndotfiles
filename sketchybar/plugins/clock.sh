#!/bin/zsh
# date/time indicators for my sketchybar
#
# NOTE: @espadonne (mfw) this takes 1 arg or none
#       the expected first arg is the string LEFT

label=""

if [[ "$1" == "LEFT" ]]; then
    label="$(date '+%Y.%m.%d (%A)')"
else
    label="$(date '+%-H:%M')"
fi

sketchybar --set $NAME label="$label"
# echo tom
# date '+%a %b %-d %-H:%M'