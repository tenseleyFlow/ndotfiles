#!/bin/sh
pkill -f "mouse-follows-focus" 2>/dev/null

i3-msg -t subscribe -m '["window"]' | while read -r event; do
  eval $(xdotool getactivewindow getwindowgeometry --shell)
  WIN_X=$X
  WIN_Y=$Y
  WIN_W=$WIDTH
  WIN_H=$HEIGHT
  eval $(xdotool getmouselocation --shell)
  MOUSE_X=$X
  MOUSE_Y=$Y
  if [ "$MOUSE_X" -lt "$WIN_X" ] || [ "$MOUSE_X" -gt "$((WIN_X + WIN_W))" ] || \
     [ "$MOUSE_Y" -lt "$WIN_Y" ] || [ "$MOUSE_Y" -gt "$((WIN_Y + WIN_H))" ]; then
    xdotool mousemove --window "$(xdotool getactivewindow)" $((WIN_W/2)) $((WIN_H/2))
  fi
done
