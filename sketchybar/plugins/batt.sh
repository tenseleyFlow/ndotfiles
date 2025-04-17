#!/bin/zsh
# dynamic battery icon script for SketchyBar
#
# NOTE: the code points for icons. 
#       I'm using FA icons, which I pay for, but they have a
#       free set you can add w. package manager

COLOR_GOOD=0xff81A1C1
COLOR_NORMAL=0xffEBCB8B
COLOR_CHARGING=0xffA3BE8C
COLOR_CRITICAL=0xffBF616A

# default to bad news
color=$COLOR_CRITICAL

# Read PMSET output: first line for state, second for stats
raw_state=$(pmset -g batt | head -1)
raw=$(pmset -g batt | tail -1)

# check if charging or discharging
if echo "$raw_state" | grep -q "AC Power"; then
  state="charging"
else
  state="discharging"
fi

# extract numeric percentage (and strip the '%')
percent=$(echo "$raw" | grep -Eo '[0-9]+%' | head -1 | tr -d '%')

# select icon based on state and percentage
# TODO: @espadonne (mfw) case and cascade
#       on the color transitions
if [ "$state" = "charging" ]; then
  icon=$'\uf376'
  color=$COLOR_CHARGING
elif [ "$percent" -ge 90 ]; then
  icon=$'\uf240'
  color=$COLOR_GOOD
elif [ "$percent" -ge 65 ]; then
  icon=$'\uf241'
  color=$COLOR_GOOD
elif [ "$percent" -ge 50 ]; then
  icon=$'\uf241'
  color=$COLOR_NORMAL
elif [ "$percent" -ge 40 ]; then
  icon=$'\uf242'
  color=$COLOR_NORMAL
elif [ "$percent" -ge 20 ]; then
  icon=$'\uf243'
  color=$COLOR_NORMAL
elif [ "$percent" -ge 15 ]; then
  icon=$'\uf243'
  color=$COLOR_CRITICAL
elif [ "$percent" -ge 5 ]; then
  icon=$'\ue0b1'
  color=$COLOR_CRITICAL
else
  icon=$'\uf377'
  color=$COLOR_CRITICAL
fi

sketchybar --set "$NAME" icon=$icon
sketchybar --set "$NAME" icon.color="${color}"
sketchybar --set "$NAME" label="${percent}%"