# iTerm2 Reference

Terminal emulator for macOS with shell integration features.

## Shell Integration

**Installation:**
```fish
# Already configured in ~/.config/fish/config.fish
source ~/.config/fish/iterm2_shell_integration.fish
```

**What it does:**
- Marks command boundaries with escape sequences
- Tracks command success/failure
- Enables command navigation and output selection
- Provides recent directory history

## Command Navigation

| Keybind | Action |
|---------|--------|
| `Cmd+Shift+Up` | Jump to previous command prompt |
| `Cmd+Shift+Down` | Jump to next command prompt |
| `Cmd+Shift+A` | Select output of last command |
| `Cmd+Option+B` | Instant Replay (rewind terminal) |

**Visual Indicators:**
- Blue arrow in left margin = successful command
- Red arrow = failed command
- Right-click margin → Show Timestamps

## Output Selection

| Action | Result |
|--------|--------|
| `Cmd+Click` on command | Highlight that command's output |
| Double-click between prompts | Select entire output block |
| Right-click output → Copy Output | Copy just that command's output |
| `Cmd+Shift+A` | Select output of last command |

## Directory Navigation

| Keybind | Action |
|---------|--------|
| `Cmd+Option+/` | Recent Directories popup |
| `Cmd+Shift+B` | Toggle Toolbelt (includes Recent Directories) |

**Recent Directories:**
- Automatically tracks all directories you `cd` into
- Press number key to jump to that directory
- Searchable list

## Split Panes

| Keybind | Action |
|---------|--------|
| `Cmd+D` | Split horizontally (left/right) |
| `Cmd+Shift+D` | Split vertically (top/bottom) |
| `Cmd+Option+Arrow` | Navigate between panes |
| `Cmd+Ctrl+Arrow` | Resize current pane |
| `Cmd+Shift+Enter` | Maximize/restore current pane |
| `Cmd+Option+E` | Broadcast input to all panes in tab |

## Tabs & Windows

| Keybind | Action |
|---------|--------|
| `Cmd+T` | New tab |
| `Cmd+N` | New window |
| `Cmd+W` | Close tab/pane |
| `Cmd+Shift+[` | Previous tab |
| `Cmd+Shift+]` | Next tab |
| `Cmd+Number` | Jump to tab by number |
| `Cmd+Option+Number` | Jump to window by number |

## Search & Selection

| Keybind | Action |
|---------|--------|
| `Cmd+F` | Find/search |
| `Cmd+E` | Use selection for find |
| `Cmd+G` | Find next |
| `Cmd+Shift+G` | Find previous |
| `Cmd+Option+E` | Search in all tabs |

## Toolbelt (Sidebar)

| Keybind | Action |
|---------|--------|
| `Cmd+Shift+B` | Toggle toolbelt |

**Toolbelt Features:**
- Recent Directories (click to `cd`)
- Command History (searchable)
- Recent Commands
- Notes
- Jobs

## Useful Features

**Triggers:**
- iTerm2 → Preferences → Profiles → Advanced → Triggers
- Auto-detect patterns and take actions
- Example: Highlight lines with "ERROR" in red
- Example: Send notification when "Build complete" appears

**Automatic Profile Switching:**
- iTerm2 → Preferences → Profiles → Advanced → Automatic Profile Switching
- Switch profiles based on hostname, username, directory
- Useful for different colors on production vs dev servers

**Instant Replay:**
- `Cmd+Option+B` - Scrub backwards through terminal history
- Like a DVR for your terminal
- ESC to exit replay mode

**Paste History:**
- `Cmd+Shift+H` - Show paste history
- Search and re-paste previous clipboard contents

## Configuration

**Preferences Location:**
- Default: `~/Library/Preferences/com.googlecode.iterm2.plist` (binary)
- Custom: iTerm2 → Preferences → General → Preferences → Load from custom folder

**Dynamic Profiles:**
- `~/Library/Application Support/iTerm2/DynamicProfiles/`
- JSON-based profile definitions
- Version control friendly
