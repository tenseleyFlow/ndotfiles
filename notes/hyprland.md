# Hyprland Configuration Reference

Quick reference for current Hyprland keybinds, workspaces, and workflows.

## Core Applications & Launchers

| Keybind | Action |
|---------|--------|
| `$mainMod + RETURN` | Terminal (standard) |
| `$mainMod + SHIFT + RETURN` | Terminal with tmux:main session |
| `$mainMod + SPACE` | App launcher (wofi) |
| `$mainMod + E` | File manager |
| `$mainMod + C` | New VSCode window |
| `$mainMod + J` | JetBrains app picker |
| `$mainMod + SHIFT + V` | Clipboard manager |
| `$mainMod + SHIFT + M` | Exit Hyprland |

## Window Management

| Keybind | Action |
|---------|--------|
| `$mainMod + Q` | Close window |
| `$mainMod + Y` | Pin window (all workspaces) |
| `$mainMod + F` | Toggle fullscreen |
| `$mainMod + V` | Toggle float/tile |
| `$mainMod + /` | Toggle split mode |
| `$mainMod + K` | Toggle group mode |
| `$mainMod + Tab` | Next window in group |
| `$mainMod + X` | Toggle flow (disable animations) |
| `$mainMod + LMB drag` | Move window |
| `$mainMod + RMB drag` | Resize window |

## Layouts & Gaps

| Keybind | Action |
|---------|--------|
| `$mainMod + F10` | Master layout |
| `$mainMod + F11` | Dwindle layout |
| `$mainMod + G` | Remove gaps |
| `$mainMod + SHIFT + G` | Reset gaps (5/3) |

## Focus & Movement

| Keybind | Action |
|---------|--------|
| `$mainMod + Arrow Keys` | Move focus |
| `$mainMod + SHIFT + Arrow Keys` | Move window |

## Resizing (Multi-tier)

**Resize Mode:**
- `$mainMod + R` → Enter resize mode
- Arrow keys or `h/j/k/l` to resize
- `Esc` to exit

**Quick Resize:**
- `$mainMod + CTRL + Arrows` → Small resize (25px)
- `$mainMod + CTRL + SHIFT + Arrows` → Medium resize (55px)  
- `$mainMod + ALT + CTRL + Arrows` → Large resize (85px)
- `$mainMod + ALT + CTRL + SHIFT + Arrows` → XL resize (115px)

## Workspaces (1-10)

**Primary Monitor (DP-1):** Workspaces 1-5  
**Secondary Monitor (HDMI-A-1):** Workspaces 6-10

| Keybind | Action |
|---------|--------|
| `$mainMod + [1-0]` | Switch workspace |
| `$mainMod + CTRL + [1-0]` | Move window & switch |
| `$mainMod + SHIFT + [1-0]` | Move window silently |
| `$mainMod + ,/.` | Previous/next workspace |
| `$mainMod + mouse scroll` | Cycle workspaces |

## Special Workspaces (Scratchpads)

| Keybind | App | Auto-launch |
|---------|-----|--------------|
| `$mainMod + Z` | Zen Browser | ✓ |
| `$mainMod + T` | Terminal (Ghostty) | ✓ |
| `$mainMod + H` | Guides | - |
| `$mainMod + D` | Discord | ✓ |
| `$mainMod + A` | Audacity | ✓ |
| `$mainMod + O` | TickTick | ✓ |
| `$mainMod + B` | Bitwarden | ✓ |
| `$mainMod + M` | Spotify | ✓ |
| `$mainMod + N` | Notes viewer | tmux layout |
| `$mainMod + -` | Default scratchpad | - |
| `$mainMod + SHIFT + -` | Send to scratchpad | - |

## Auto-Workspace Rules

- **Workspace 9:** REAPER (auto-launch on create)
- **Workspace 10:** LibreWolf (auto-launch on create)

## Media & System

| Keybind | Action |
|---------|--------|
| `Print` | Screenshot region |
| `ALT + Print` | Screenshot screen |  
| `CTRL + Print` | Screenshot window |
| `XF86Audio*` | Media controls (volume, play/pause) |
| `XF86MonBrightness*` | Brightness ±5% |
| `$mainMod + L` | Lock screen |
| `$mainMod + W` | Reload Waybar |
| `$mainMod + SHIFT + M` | Exit Hyprland |

## Custom Scenes

| Keybind | Action |
|---------|--------|
| `$mainMod + ALT + 1/2` | Toggle scene 1/2 |

## Monitor Setup

- **Primary (DP-1):** 3840×2160, workspaces 1-5
- **Secondary (HDMI-A-1):** 2560×1440, workspaces 6-10

## Window Rules Summary

- **Floating:** PiP, dialogs, system tools
- **Opacity:** File managers (92%), Discord (96%)
- **Auto-blur disabled:** Firefox
- **Smart gaps:** Different for tiled vs floating windows  
