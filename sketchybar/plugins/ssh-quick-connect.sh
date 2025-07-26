

#!/usr/bin/env zsh
#
# ssh‑quick‑connect.sh
# A SketchyBar plugin that shows the number of online Tailnet peers and,
# on click, pops up a list of online hosts that you can SSH into.
#
# Requirements:
#   * Tailscale CLI (`tailscale`) and `jq`
#   * iTerm2 or Terminal for the click‑launch (adjust OPEN_CMD below)
#
# Add to sketchybarrc:
#   sketchybar --add item ssh_menu right \
#              --set ssh_menu update_freq=60 \
#                           script="$PLUGDIR/ssh-quick-connect.sh" \
#                           icon=$'\uf489' \
#              --subscribe ssh_menu mouse.clicked
#
########################################################################

ITEM_NAME="${NAME:-ssh_menu}"   # When run by SketchyBar, $NAME is set.
SENDER="${SENDER:-routine}"     # "routine" when run via update_freq

# Resolve Tailscale CLI path explicitly because SketchyBar's PATH may be minimal
if command -v tailscale &>/dev/null; then
  TS_BIN="$(command -v tailscale)"
elif [[ -x "/Applications/Tailscale.app/Contents/MacOS/Tailscale" ]]; then
  TS_BIN="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
else
  TS_BIN=""
fi

OPEN_CMD='osascript -e "tell application \"iTerm2\" to create window with default profile command \"%s\""'   # change to Terminal as desired

# ---------- Helpers --------------------------------------------------

json_status() {
  [[ -z "$TS_BIN" ]] && return
  "$TS_BIN" status --json 2>/dev/null
}

online_hosts() {
  jq -r '.Peer[] | select(.Online==true) | .HostName' <<<"$1"
}

# ---------- Update routine (every 60 s) ------------------------------

if [[ "$SENDER" == "routine" ]]; then
  TS_JSON=$(json_status)
  if [[ -z "$TS_JSON" ]]; then
    sketchybar --set "$ITEM_NAME" icon="󰼀" label="TS Down"
    exit 0
  fi

  ONLINE=$(jq '[.Peer[] | select(.Online==true)] | length' <<<"$TS_JSON")
  TOTAL=$(jq '.Peer | length' <<<"$TS_JSON")

  ICON="󰼂"   # default t/s icon
  LABEL="$ONLINE/$TOTAL"

  sketchybar --set "$ITEM_NAME" icon="$ICON" label="$LABEL"
  exit 0
fi

# ---------- Click handler -------------------------------------------

if [[ "$SENDER" == "mouse.clicked" ]]; then
  # ----- 1. nuke children using sketchybar --query  ----------------
  CHILDREN=($(sketchybar --query "$ITEM_NAME" | jq -r '.popup.items[]?'))
  for C in "${CHILDREN[@]}"; do
    sketchybar --remove "$C"
  done

  # ----- 2. rebuild list  ----------------
  TS_JSON=$(json_status)
  HOSTS=($(online_hosts "$TS_JSON"))

  if (( ${#HOSTS} == 0 )); then
    sketchybar --add item ssh_nopeers popup."$ITEM_NAME" \
               --set ssh_nopeers label="No peers online" icon=""
  else
    INDEX=0
    for HOST in "${HOSTS[@]}"; do
      POP="ssh_pop_$INDEX"
      sketchybar --add item "$POP" popup."$ITEM_NAME" \
                 --set "$POP" label="$HOST" icon="" \
                      click_script="open -a iTerm \"ssh $HOST\""
      (( INDEX++ ))
    done
  fi

  # ----- 3. show popup (always flips state)  ----------------
  sketchybar --toggle "$ITEM_NAME" popup
  exit 0
fi