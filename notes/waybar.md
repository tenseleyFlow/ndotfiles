# Waybar Configuration Reference

Status bar configuration for Hyprland with custom modules and styling.

## Layout Overview

**Position:** Top bar with 10px margins left/right

**Left modules:**
- Hyprland workspaces
- Temperature monitor
- Spotify integration

**Center modules:**
- Date/time display
- Weather information

**Right modules:**
- Backlight control
- Storage usage
- Memory usage
- CPU usage
- Battery status
- Audio (WirePlumber)
- Custom integrations:
  - Almanta
  - Screenshot tools
  - JetBrains launcher
- System tray
- Power menu

## Custom Modules

**Media:**
- `custom/spotify` - Spotify player status

**System Info:**
- `custom/storage` - Disk usage display
- `custom/weather` - Weather information
- `custom/almanta` - Custom system integration

**Launchers:**
- `custom/jetbrains` - JetBrains IDE launcher
- `custom/screenshot_t` - Screenshot tools
- `custom/power` - Power management menu

## Module Scripts

Custom modules use scripts from `waybar/modules/`:
- `spotify.sh` - Spotify integration
- `storage.sh` - Storage monitoring  
- `weather.sh` - Weather display
- `jetbrains_menu.sh` - IDE launcher
- `almanta.sh` - System integration
- `mail.py` - Mail notifications

## Styling Features

- Custom CSS styling in `style.css`
- Modular spacing (5px between modules)
- Integrated with Hyprland workspace switching
- Temperature and hardware monitoring
- Audio control via WirePlumber

## Reload

Waybar can be reloaded with:
- `$mainMod + W` (from Hyprland keybinds)
- `killall -SIGUSR2 waybar`