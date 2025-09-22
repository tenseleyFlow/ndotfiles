# Tmux Configuration Reference

Custom tmux setup with global keybind toggle and Wayland integration.

## Prefix Keys

| Key | Type |
|-----|------|
| `Ctrl-Space` | Primary prefix |
| `Ctrl-b` | Fallback prefix |
| `prefix + r` | Reload configuration |

## Global Toggle System

| Keybind | Action |
|---------|--------|
| `Ctrl-g` | Toggle ALL custom keybinds on/off |

**When OFF:** All custom binds disabled, keys pass through to applications  
**When ON:** Custom tmux binds active (default state)

## Window (Tab) Management

| Keybind | Action |
|---------|--------|
| `Ctrl-t` | New window |
| `Ctrl-w` | Close window (with confirmation) |
| `Ctrl-Alt-Left` | Previous window |
| `Ctrl-Alt-Right` | Next window |

## Pane Management

**Create Panes:**
| Keybind | Action |
|---------|--------|
| `Alt-\` | Split vertically (left/right) |
| `Alt-|` | Split horizontally (top/bottom) |

**Close Panes:**
| Keybind | Action |
|---------|--------|
| `Alt-Shift-W` | Kill pane (with confirmation) |
| `Ctrl-Alt-w` | Kill pane (backup binding) |

**Navigate Panes:**
| Keybind | Action |
|---------|--------|
| `Ctrl-Alt-Left` | Focus left pane |
| `Ctrl-Alt-Right` | Focus right pane |
| `Ctrl-Alt-Up` | Focus up pane |
| `Ctrl-Alt-Down` | Focus down pane |

**Resize Panes:**
| Keybind | Action |
|---------|--------|
| `Ctrl-Alt-Shift-Left` | Resize left (5 units) |
| `Ctrl-Alt-Shift-Right` | Resize right (5 units) |
| `Ctrl-Alt-Shift-Up` | Resize up (2 units) |
| `Ctrl-Alt-Shift-Down` | Resize down (2 units) |

## Copy Mode (Vi-style)

**Clipboard Integration (Wayland):**
| Keybind | Action |
|---------|--------|
| `y` | Copy and exit copy-mode |
| `Y` | Copy and stay in copy-mode |
| Mouse drag | Copy without exiting copy-mode |

## Plugin Keybinds

Your installed plugins and their default keybinds:

| Plugin | Keybind | Action |
|--------|---------|--------|
| **tmux-yank** | `prefix + y` | Copy command line to clipboard |
| | `y` (copy-mode) | Yank selection |
| **tmux-copycat** | `prefix + /` | Regex search |
| | `prefix + Ctrl-f` | Search files |
| | `prefix + Ctrl-g` | Search git files |
| | `prefix + Ctrl-u` | Search URLs |
| | `prefix + Ctrl-d` | Search numbers |
| | `prefix + Alt-h` | Search SHA hashes |
| | `prefix + Alt-i` | Search IP addresses |
| **tmux-open** | `o` (copy-mode) | Open highlighted path/URL |
| | `Ctrl-o` (copy-mode) | Open in $EDITOR |
| **tmux-fzf** | `prefix + F` | FZF session/window/pane picker |
| **tmux-fzf-url** | `prefix + u` | FZF URL picker |
| **tmux-resurrect** | `prefix + Ctrl-s` | Save session |
| | `prefix + Ctrl-r` | Restore session |
| **tmux-continuum** | *(automatic)* | Auto-save every 15 min |
| **TPM** | `prefix + I` | Install plugins |
| | `prefix + U` | Update plugins |
| | `prefix + Alt-u` | Uninstall removed plugins |

## Configuration Features

**Options:**
- Vi-mode keys enabled
- Mouse support enabled
- 100,000 line history
- Windows/panes start at index 1
- Auto-renumber windows
- Fast escape time (10ms)
- Wayland clipboard integration via wl-copy

**Modular Structure:**
- `~/.tmux.conf` - Main entry point
- `~/.tmux.d/10-options.conf` - General options
- `~/.tmux.d/20-keys.conf` - Custom keybinds  
- `~/.tmux.d/30-mouse.conf` - Mouse settings
- `~/.tmux.d/40-status-theme.conf` - Status bar
- `~/.tmux.d/50-plugins.conf` - Plugin configuration
- `~/.tmux.local.conf` - Local overrides

**Special Features:**
- All custom keybinds can be globally toggled with `Ctrl-g`
- When disabled, keys pass through to applications
- Wayland clipboard integration with wl-copy
- Auto-restore sessions on tmux startup