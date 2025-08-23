# Neovim Configuration Reference

Current keybinds and workflows for the lazy.nvim-based configuration. Optimized for LSP, Telescope, and productivity with Wayland clipboard support.

---

## Modes Overview

| Mode            | Description                                   | Enter From            |
|-----------------|-----------------------------------------------|-----------------------|
| **Normal**      | Navigation, commands                         | `Esc`                 |
| **Insert**      | Insert/typing                                | `i`, `a`, `o`, `O`    |
| **Visual**      | Select text (char, line, block)              | `v`, `V`, `Ctrl+v`    |
| **Command**     | Ex commands (`:w`, `:q`)                     | `:`                   |
| **Terminal**    | Interactive terminal buffer                  | `:term`, `<C-`>`      |

---

## Navigation Keybindings (Default)

| Keybind    | Action                               |
|------------|--------------------------------------|
| `h`/`l`    | Left / right one character           |
| `j`/`k`    | Down / up one line                   |
| `w`/`e`/`b`| Next word / end word / back a word   |
| `0` / `$`  | Start / end of line                  |
| `gg` / `G` | First / last line of file            |
| `{n}G`     | Jump to line n                       |
| `Ctrl+u/d` | Scroll half screen up/down           |
| `Ctrl+b/f` | Scroll full screen up/down           |
| `%`        | Match brackets/parentheses           |
| `/text`    | Search forward (n/N = next/prev)     |
| `?text`    | Search backward (n/N = next/prev)    |
| `*` / `#`  | Next/prev word under cursor          |

---

## Editing Essentials

| Keybind | Action                                   |
|---------|------------------------------------------|
| `i`/`a` | Insert before / after cursor             |
| `o`/`O` | New line below / above                   |
| `x`     | Delete character                         |
| `dd`    | Delete line                              |
| `yy`    | Yank (copy) line                         |
| `p`/`P` | Paste after / before cursor              |
| `.`     | Repeat last command                      |
| `{n}{op}` | Repeat operation n times (`5dd`)       |

### Visual Mode Tricks
- `v`/`V`/`Ctrl+v` → char/line/block selections
- Block mode (`Ctrl+v` + `j/k`):
  - `I` insert before selection (applies to all lines)
  - `A` append after selection

---

## Custom Workflow Keymaps (Current Config)

**Core Actions:**
| Keybind | Action |
|---------|--------|
| `<C-s>` | Save (normal/insert/visual) |
| `<leader>q` | Quit |
| `<Esc>` | Clear search highlights |

**Windows & Tabs:**
| Keybind | Action |
|---------|--------|
| `<leader>sv` | Vertical split |
| `<leader>sh` | Horizontal split |
| `<leader>to` | New tab |

**File Management:**
| Keybind | Action |
|---------|--------|
| `<leader>ff` | Telescope: find files |
| `<leader>fg` | Telescope: live grep |
| `<leader>fb` | Telescope: buffers |
| `<leader>fh` | Telescope: help tags |
| `<leader>fp` | Projects picker |
| `-` | Oil file manager (float) |

**Terminal & Tasks:**
| Keybind | Action |
|---------|--------|
| `<C-`>` | Toggle floating terminal |
| `<leader>tr` | Run task (Overseer) |
| `<leader>tt` | Task list toggle |

**Formatting:**
| Keybind | Action |
|---------|--------|
| `<leader>f` | Format buffer (Conform) |

**Visual Mode:**
| Keybind | Action |
|---------|--------|
| `J` | Move selected lines down |
| `K` | Move selected lines up |

---

## LSP Workflow

**Auto-installed servers:**
`pyright`, `lua_ls`, `clangd`, `rust_analyzer`, `bashls`, `jsonls`, `yamlls`, `html`, `cssls`, `marksman`, `taplo`

| Keybind | Action |
|---------|--------|
| `gd` | Goto definition |
| `gD` | Goto declaration |
| `gi` | Goto implementation |
| `gr` | List references |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>fd` | Format buffer (LSP) |

---

## Git Integration

**Gitsigns:**
- Inline diff signs in gutter
- Hunk navigation and staging
- `:Gitsigns stage_hunk`, `:Gitsigns blame_line`

**LazyGit:**
- `:LazyGit` - Full-featured Git TUI

---

## Telescope (Fuzzy Finder)

| Keybind | Action |
|---------|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fh` | Help tags |
| `<leader>fp` | Projects |

**Inside Telescope:**
- `<C-j>/<C-k>` - Navigate results
- `/` - Fuzzy filter in results

---

## Treesitter (Syntax Engine)

**Auto-installed parsers:**
`bash`, `c`, `cpp`, `lua`, `python`, `rust`, `json`, `yaml`, `toml`, `html`, `css`, `javascript`, `typescript`, `markdown`, `markdown_inline`, `make`, `fish`

- Provides enhanced highlighting and indenting
- Smart text objects and navigation

---

## Formatting (Conform.nvim)

**Auto-format on save** (disabled for files >512KB)

| Language | Formatter(s) |
|----------|-------------|
| Lua | stylua |
| Python | ruff_format, black |
| Shell scripts | shfmt |
| Fish | fish_indent |
| C/C++ | clang_format |
| JS/TS | prettier |
| JSON | jq, prettier |
| YAML | prettier |
| TOML | taplo |
| HTML/CSS | prettier |
| Markdown | prettier |

---

## Debugging (nvim-dap + dap-ui)

**Basic DAP setup included:**
- `:DapToggleBreakpoint` - Set/clear breakpoint
- `:DapContinue` - Run/start debugging
- `:DapStepOver/Into/Out` - Step through code
- DAP UI auto-opens/closes with debug sessions

---

## UI Enhancements

**Current plugins:**
- **TokyoNight theme** (night style)
- **Lualine** - Status line with global status
- **Which-key** - Keybind hints
- **Dressing** - Better UI for inputs/selects
- **Notify** - Pretty notifications
- **Indent-blankline** - Indentation guides
- **Comment.nvim** - Easy commenting
- **nvim-surround** - Surround text objects

---

## Configuration Highlights

**Leaders:** `<Space>` (main), `,` (local)

**Auto-features:**
- Format on save (files <512KB)
- Cursor position restoration
- Yank highlighting
- Wayland clipboard integration

**Project Management:**
- Project detection via `.git`, `pyproject.toml`, `package.json`, `Makefile`
- Overseer task runner integration
- Oil file manager with hidden files shown

**Performance:**
- Removed noice.nvim for faster commands
- Lazy loading for most plugins
- Smart format-on-save size limits

---
