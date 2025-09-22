# Micro Editor Configuration Reference

Current keybinds, plugins, and workflow for the micro editor setup.

## Core Keybinds

| Keybind | Action |
|---------|--------|
| `Ctrl-E` | Command bar (`help`, `plugin list`, `open`, etc.) |
| `Ctrl-S` | Save file |
| `Ctrl-Q` | Close buffer/quit |
| `Ctrl-O` | Open file (fallback) |

## File Management

**FZF File Finder:**
| Keybind | Action |
|---------|--------|
| `Alt-f` | Fuzzy file finder (mfzf) |

**Current settings:**
- Uses custom `mfzf` wrapper (git-aware)
- Preview with `bat -f -p {}`
- Opens in new tab
- Shows relative paths
- External clipboard integration

**Inside fzf:**
- Type to filter, `↑/↓` or `Ctrl-j/k` to navigate
- `Enter` to open, `Tab/Shift-Tab` for multi-select

## Command Palette

| Keybind | Action |
|---------|--------|
| `Ctrl-P` | Command palette (palettero) |
| `Ctrl-Space` | Command palette (alt binding) |

**Usage:**
- Fuzzy search any micro/plugin command
- Type command names ("jump", "tree", "help", "pipe jq .") and run
- Great for command discovery and one-liners

## LSP Integration

| Keybind | Action |
|---------|--------|
| `Alt-d` | Go to definition |
| `Alt-k` | Show hover info |
| `Alt-r` | Show references |

*Note: Requires LSP servers installed and configured*

## Build & Run System

| Keybind | Action |
|---------|--------|
| `F5` | Run current file |
| `F12` | Make (foreground) |
| `F9` | Make (background) |

**Features:**
- Auto-detects file type/shebang
- Makefile support for projects
- Language-aware execution

## File Tree

| Keybind | Action |
|---------|--------|
| `Ctrl-b` | Toggle file tree |

**Usage:**
- Navigate with arrows, open with `Enter`
- Add `"filemanager.openonstart": true` to auto-open

## Code Navigation

| Keybind | Action |
|---------|--------|
| `F4` | Jump to symbol/heading |

**Features:**
- Functions, classes, Markdown headings
- Fuzzy search within current buffer

## Comments

| Keybind | Action |
|---------|--------|
| `Alt-/` | Toggle comment |
| `Ctrl-_` | Toggle comment (alt) |

*Uses comment.lua plugin*

## Plugin Configuration

**Current plugins:**
- **fzfinder** - Fuzzy file finding with mfzf
- **palettero** - Command palette
- **comment** - Smart commenting
- **LSP integration** - Language server support
- **runit** - File execution
- **jumptag** - Symbol navigation
- **makeup** - Build system

**Useful Commands:**
- `pipe jq .` - Pretty-print JSON
- `pipe yq -P` - JSON→YAML conversion  
- `pipe sort -u` - Sort unique lines
- `pipe sed -E 's/[[:space:]]+$//'` - Strip trailing whitespace

## Settings Summary

- External clipboard integration
- Custom mfzf command for file finding
- Bat preview integration
- New tab opening for files
- Relative path display