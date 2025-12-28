# Zellij Configuration Reference

Modern terminal multiplexer with tmux-compatible keybinds and zjstatus integration.

## Mode System

Zellij uses a modal interface. Press a mode key to enter that mode, then use mode-specific bindings.

| Keybind | Mode | Exit |
|---------|------|------|
| `Ctrl g` | Locked (passthrough) | `Ctrl g` |
| `Ctrl p` | Pane | `Ctrl p` / `Esc` |
| `Ctrl t` | Tab | `Ctrl t` / `Esc` |
| `Ctrl n` | Resize | `Ctrl n` / `Esc` |
| `Ctrl h` | Move | `Ctrl h` / `Esc` |
| `Ctrl s` | Scroll | `Ctrl s` / `Esc` |
| `Ctrl o` | Session | `Ctrl o` / `Esc` |
| `Ctrl b` / `Ctrl Space` | Tmux | `Esc` |

## Tmux Mode (Prefix Style)

Familiar tmux-like bindings. Press `Ctrl Space` or `Ctrl b`, then:

**Pane Management:**
| Key | Action |
|-----|--------|
| `\|` or `%` | Split right |
| `-` or `"` | Split down |
| `h/j/k/l` or arrows | Navigate panes |
| `x` | Close pane |
| `z` | Toggle fullscreen |
| `o` | Focus next pane |
| `space` | Next layout |

**Tab Management:**
| Key | Action |
|-----|--------|
| `c` | New tab |
| `n` | Next tab |
| `p` | Previous tab |
| `1-9` | Go to tab N |
| `,` | Rename tab |

**Session:**
| Key | Action |
|-----|--------|
| `d` | Detach |
| `Ctrl b` | Send literal Ctrl-b |
| `Ctrl Space` | Send literal Ctrl-Space |

## Pane Mode (`Ctrl p`)

| Key | Action |
|-----|--------|
| `h/j/k/l` or arrows | Move focus |
| `n` | New pane (auto direction) |
| `d` | New pane down |
| `r` | New pane right |
| `s` | New stacked pane |
| `x` | Close pane |
| `f` | Toggle fullscreen |
| `e` | Toggle embed/floating |
| `w` | Toggle floating panes |
| `z` | Toggle pane frames |
| `i` | Pin pane |
| `c` | Rename pane |
| `p` | Switch focus |

## Tab Mode (`Ctrl t`)

| Key | Action |
|-----|--------|
| `h/l` or arrows | Previous/next tab |
| `n` | New tab |
| `x` | Close tab |
| `r` | Rename tab |
| `1-9` | Go to tab N |
| `b` | Break pane to new tab |
| `[` | Break pane left |
| `]` | Break pane right |
| `s` | Sync tab (send input to all panes) |
| `tab` | Toggle between last two tabs |

## Resize Mode (`Ctrl n`)

| Key | Action |
|-----|--------|
| `h/j/k/l` or arrows | Increase size in direction |
| `H/J/K/L` | Decrease size in direction |
| `+` / `=` | Increase overall |
| `-` | Decrease overall |

## Move Mode (`Ctrl h`)

| Key | Action |
|-----|--------|
| `h/j/k/l` or arrows | Move pane in direction |
| `n` / `tab` | Move pane forward |
| `p` | Move pane backward |

## Scroll Mode (`Ctrl s`)

| Key | Action |
|-----|--------|
| `j/k` or arrows | Scroll line by line |
| `d` / `u` | Half page down/up |
| `Ctrl f` / `Ctrl b` | Full page down/up |
| `PageDown` / `PageUp` | Full page down/up |
| `s` | Enter search mode |
| `e` | Edit scrollback in $EDITOR |
| `Ctrl c` | Exit to normal mode |

## Search Mode (from Scroll)

| Key | Action |
|-----|--------|
| `n` | Next match |
| `p` | Previous match |
| `c` | Toggle case sensitivity |
| `w` | Toggle wrap |
| `o` | Toggle whole word |

## Session Mode (`Ctrl o`)

| Key | Action |
|-----|--------|
| `w` | Session manager (switch/create) |
| `d` | Detach |
| `c` | Configuration |
| `p` | Plugin manager |
| `a` | About |
| `s` | Share session |

## Global Bindings (Always Available)

| Keybind | Action |
|---------|--------|
| `Alt h/j/k/l` | Move focus (or tab if at edge) |
| `Alt arrows` | Move focus (or tab if at edge) |
| `Ctrl Shift arrows` | Move focus (pane only) |
| `Alt Shift arrows` | Move focus (pane only) |
| `Alt \` | Split right (vertical) |
| `Alt \|` | Split down (horizontal) |
| `Alt Shift w` | Close pane |
| `Ctrl Alt Shift arrows` | Resize in direction |
| `Alt +` / `Alt -` | Resize increase/decrease |
| `Alt [` / `Alt ]` | Previous/next layout |
| `Alt f` | Toggle floating panes |
| `Alt n` | New pane |
| `Alt i` / `Alt o` | Move tab left/right |
| `Alt p` | Toggle pane in group |
| `Alt Shift p` | Toggle group marking |
| `Ctrl q` | Quit Zellij |

## Locked Mode (`Ctrl g`)

All Zellij keybinds disabled, keys pass through to terminal. Press `Ctrl g` again to exit.

## CLI Commands

```bash
# Start new session
zellij

# Named session
zellij -s mysession

# Attach to existing
zellij attach mysession

# List sessions
zellij list-sessions
zellij ls

# Kill session
zellij kill-session mysession
zellij kill-all-sessions

# Run command in new pane
zellij run -- htop

# Run in floating pane
zellij run -f -- htop

# Edit file in new pane
zellij edit ~/.zshrc

# Open specific layout
zellij --layout compact
```

## Configuration Files

```
~/.config/zellij/
├── config.kdl           # Main configuration
├── layouts/
│   └── tenseley.kdl     # Custom layout with zjstatus
├── themes/
│   └── tenseley.kdl     # Tmux-inspired color theme
└── plugins/
    └── zjstatus.wasm    # Custom status bar plugin
```

## Layout Structure

Current layout (`tenseley`):
- **Top**: Default Zellij tab bar
- **Middle**: Content panes
- **Bottom**: zjstatus (session, hostname, mode, datetime)

## Theme Colors

| Element | Color | Hex |
|---------|-------|-----|
| Active border/accent | Green | `#7bd88f` |
| Inactive border | Muted gray | `#4a5162` |
| Main text | Light gray | `#b8c0cc` |
| Muted text | Gray | `#8b94a6` |
| Alert/error | Red | `#e05f5f` |
| Background | Dark | `#1f2430` |

## Tips & Workflows

**Quick pane creation:**
- `Alt n` creates a new pane instantly (no mode switch needed)
- `Alt f` toggles floating panes for temporary work

**Tmux muscle memory:**
- `Ctrl Space` or `Ctrl b` enters tmux mode
- Most tmux bindings work: `%`, `"`, `c`, `n`, `p`, `x`, `z`, `d`

**Session management:**
- `Ctrl o` then `w` opens session manager
- Sessions auto-serialize for resurrection

**Passthrough mode:**
- `Ctrl g` locks Zellij, passing all keys to the terminal
- Useful for nested multiplexers or apps with conflicting binds

**Layouts:**
- `Alt [` / `Alt ]` cycles through layout presets
- `space` in tmux mode also cycles layouts

## Differences from Tmux

| Feature | Tmux | Zellij |
|---------|------|--------|
| Prefix | Single key then command | Modal (stay in mode) or tmux-style |
| Plugins | TPM + shell scripts | WebAssembly (WASM) |
| Config format | Shell-like | KDL |
| Session restore | tmux-resurrect plugin | Built-in |
| Floating panes | tmux-popup | Native |
| Stacked panes | N/A | Native |
