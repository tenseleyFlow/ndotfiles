# Hyprland Keybind & Workspace Summary

## Core Applications
| Keybind                | Action                                    |
|------------------------|-------------------------------------------|
| $mainMod + RETURN      | Launch terminal (Alacritty)               |
| $mainMod + E           | Launch file manager (Dolphin)             |
| $mainMod + SPACE       | Launch app launcher (Wofi)                |
| $mainMod + SHIFT + M   | Exit Hyprland (terminate user session)    |

## Window Management
| Keybind                | Action                                    |
|------------------------|-------------------------------------------|
| $mainMod + Q           | Close window                              |
| $mainMod + Y           | Pin window (all workspaces)               |
| $mainMod + F           | Toggle fullscreen                         |
| $mainMod + J           | Toggle split mode (dwindle)               |
| $mainMod + V           | Toggle float/tile                         |
| $mainMod + LMB drag    | Move window                               |
| $mainMod + RMB drag    | Resize window                             |

### Moving Windows & Focus
| Keybind                       | Action                     |
|-------------------------------|----------------------------|
| $mainMod + Arrow Keys         | Move focus                 |
| $mainMod + SHIFT + Arrow Keys | Move window                |

### Resizing
| Keybind                                | Action                |
|----------------------------------------|-----------------------|
| $mainMod + R                           | Enter resize mode     |
| h / j / k / l, Arrows (resize mode)    | Resize                |
| Esc                                    | Exit resize mode      |
| $mainMod + CTRL + Arrows               | Resize (small)        |
| $mainMod + CTRL + SHIFT + Arrows       | Resize (medium)       |
| $mainMod + ALT + CTRL (+ SHIFT) Arrows | Resize (large)        |

## Workspaces
| Keybind                | Action                                    |
|------------------------|-------------------------------------------|
| $mainMod + [1–0]       | Switch to workspace                       |
| $mainMod + CTRL + [1–0]| Move window & switch to workspace         |
| $mainMod + SHIFT + [1–0]| Move window silently to workspace         |
| $mainMod + COMMA       | Previous workspace                        |
| $mainMod + PERIOD      | Next workspace                            |
| $mainMod + Slash       | Switch to previous workspace              |
| $mainMod + mouse scroll| Cycle workspaces                          |

### Special Workspaces (Scratchpads)
| Keybind                | Action                                    |
|------------------------|-------------------------------------------|
| $mainMod + Z           | Zen Browser                               |
| $mainMod + T           | Terminal (Ghostty)                        |
| $mainMod + D           | Discord                                   |
| $mainMod + A           | Audacity                                  |
| $mainMod + O           | TickTick                                  |
| $mainMod + B           | Bitwarden                                 |
| $mainMod + M           | Spotify                                   |
| $mainMod + Minus       | Toggle default scratchpad                 |
| $mainMod + SHIFT+Minus | Send window to scratchpad                 |

*(Auto-launch rules: REAPER → ws9, LibreWolf → ws10. Scratchpads launch respective apps if empty.)*

## Media & System
| Keybind                | Action                                    |
|------------------------|-------------------------------------------|
| XF86AudioRaiseVolume   | Volume up (+5%)                           |
| XF86AudioLowerVolume   | Volume down (–5%)                         |
| XF86AudioMute          | Toggle mute                               |
| XF86AudioPlay          | Play/pause                                |
| XF86AudioNext          | Next track                                |
| XF86AudioPrev          | Previous track                            |
| XF86MonBrightnessUp    | Increase brightness (+5%)                 |
| XF86MonBrightnessDown  | Decrease brightness (–5%)                 |

## Utilities
| Keybind                | Action                                    |
|------------------------|-------------------------------------------|
| $mainMod + L           | Lock screen (swaylock-fancy)              |
| $mainMod + W           | Reload Waybar                             |
| Print                  | Screenshot (area)                         |
| Alt + Print            | Screenshot (screen)                       |
| Ctrl + Print           | Screenshot (window)                       |

---

## Environment & Rules
- Animations: windows, workspaces, borders use slide/overshot effects  
- Window Rules:  
  - REAPER → workspace 9  
  - LibreWolf → workspace 10  
  - Scratchpads auto-launch (Discord, Spotify, Zen, etc.)  
- Monitors:  
  - DP-1 → 3840×2160 (primary)  
  - HDMI-A-1 → 2560×1440 (secondary)  
- Autostart: Waybar, swaybg, fcitx5, mako, nm-applet, polkit, idle handler  
