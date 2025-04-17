#!/bin/zsh
# show used system memory
# as reported by `memory_pressure` cmd
#
# NOTE: this is not portable. 
#       and Apple is weird as all_.
#       at least they're unix though.

free_pct=$(memory_pressure \
  | awk -F': ' '/System-wide memory free percentage/ { gsub(/%/,"",$2); print $2; exit }')
used_pct=$(( 100 - free_pct ))
sketchybar --set "${NAME}" label="${used_pct}%"
