#!/usr/bin/env bash
# JetBrains menu for Waybar
# Left click shows IDEs from .desktop files (Toolbox, Flatpak, distro installs)
# Right click (configured in Waybar) opens jetbrains-toolbox

set -euo pipefail

# Pick a menu program
if command -v wofi >/dev/null 2>&1; then
  MENU_CMD=(wofi --dmenu -i -p "JetBrains")
elif command -v rofi >/dev/null 2>&1; then
  MENU_CMD=(rofi -dmenu -i -p "JetBrains")
else
  command -v notify-send >/dev/null 2>&1 && notify-send "JetBrains" "Install wofi or rofi for the menu."
  exit 1
fi

# Directories where .desktop files commonly live
dirs=(
  "$HOME/.local/share/applications"
  "$HOME/.local/share/flatpak/exports/share/applications"
  "/var/lib/flatpak/exports/share/applications"
  "/usr/share/applications"
)

# Gather JetBrains desktop entries (Toolbox uses jetbrains-*.desktop, Flatpak uses com.jetbrains.*)
mapfile -t files < <(
  for d in "${dirs[@]}"; do
    [[ -d "$d" ]] || continue
    find "$d" -maxdepth 1 -type f \( -name 'jetbrains-*.desktop' -o -name 'com.jetbrains*.desktop' \) -print
  done | awk '!seen[$0]++'
)

if (( ${#files[@]} == 0 )); then
  if command -v jetbrains-toolbox >/dev/null 2>&1; then
    command -v notify-send >/dev/null 2>&1 && notify-send "JetBrains" "No IDE entries found. Opening Toolbox…"
    nohup jetbrains-toolbox >/dev/null 2>&1 &
    exit 0
  else
    command -v notify-send >/dev/null 2>&1 && notify-send "JetBrains" "No JetBrains IDEs detected."
    exit 0
  fi
fi

# Build "Name|||desktop-id" lines so we can sort but keep mapping
mapfile -t lines < <(
  for f in "${files[@]}"; do
    id="$(basename "$f" .desktop)"
    name="$(grep -m1 '^Name=' "$f" | cut -d= -f2-)"
    [[ -n "$name" ]] || name="$id"
    printf '%s|||%s\n' "$name" "$id"
  done | sort -f
)

# Show menu of just the names
selection="$(printf '%s\n' "${lines[@]}" | sed 's/|||.*//' | "${MENU_CMD[@]}")"
[[ -n "$selection" ]] || exit 0

id="$(printf '%s\n' "${lines[@]}" | awk -F'\|\|\|' -v sel="$selection" '$1==sel{print $2; exit}')"

# Launch via gtk-launch (preferred), else fall back to Exec= line
if command -v gtk-launch >/dev/null 2>&1; then
  setsid gtk-launch "$id" >/dev/null 2>&1 &
  exit 0
fi

# Fallback: run the Exec= command from the .desktop file
desktop_file=""
for d in "${dirs[@]}"; do
  [[ -f "$d/$id.desktop" ]] && desktop_file="$d/$id.desktop" && break
done
[[ -z "$desktop_file" ]] && exit 1

exec_line="$(grep -m1 '^Exec=' "$desktop_file" | cut -d= -f2-)"
# Strip desktop placeholders like %f %u etc.
exec_line="${exec_line//%[fFuUdDnNickvm]/}"
nohup bash -lc "$exec_line" >/dev/null 2>&1 &
