# Neovim Modern Workflow & Plugin Guide

This guide extends the default Neovim keybinds with **modern workflows** (LSP, Telescope, Treesitter, Git, terminals) for Neovim ≥ 0.8. Designed for productivity on Wayland/Hyprland with lazy.nvim config.

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

## Custom Workflow Keymaps (from lazy config)

| Keybind     | Action                              |
|-------------|-------------------------------------|
| `<C-s>`     | Save (normal/insert/visual)         |
| `<leader>q` | Quit                                |
| `<leader>sv`| Vertical split                      |
| `<leader>sh`| Horizontal split                    |
| `<leader>to`| New tab                             |
| `<leader>ff`| Telescope: find files               |
| `<leader>fg`| Telescope: live grep                |
| `<leader>fb`| Telescope: buffers                  |
| `<leader>fh`| Telescope: help tags                |
| `-`         | Oil file manager float              |
| `<C-`>`     | Toggle floating terminal            |
| `<leader>tr`| Run task (Overseer)                 |
| `<leader>tt`| Task list toggle                    |
| `<leader>f` | Format buffer/file (Conform)        |

---

## LSP Workflow (Language Server Protocol)

Requires `mason.nvim` + `nvim-lspconfig`.

| Keybind     | Action                               |
|-------------|--------------------------------------|
| `gd`        | Goto definition                      |
| `gD`        | Goto declaration                     |
| `gi`        | Goto implementation                  |
| `gr`        | List references                      |
| `K`         | Hover docs                           |
| `<leader>rn`| Rename symbol                        |
| `<leader>ca`| Code action                          |
| `<leader>fd`| Format buffer (LSP/formatter)        |

---

## Git Integration

- **Gitsigns.nvim**  
  - Shows inline git diff signs, hunk navigation (`]c` / `[c`), staging hunks (`:Gitsigns stage_hunk`).

- **LazyGit.nvim**  
  - `:LazyGit` launches interactive TUI for Git inside Neovim.

---

## Telescope (Fuzzy Finder)

- `<leader>ff` → Files
- `<leader>fg` → Live grep
- `<leader>fb` → Buffers
- `<leader>fh` → Help tags

Extra: type `/` inside Telescope for fuzzy-in-list filtering.

---

## Treesitter (Syntax Engine)

- Auto-installs parsers for `bash`, `c/cpp`, `lua`, `python`, `rust`, `json`, `yaml`, `toml`, `html/css/js/ts`, `markdown`, `fish`, **fortran**.
- Provides better highlighting + indenting.

---

## Formatting (Conform.nvim)

| Language     | Formatter(s)                         |
|--------------|--------------------------------------|
| Lua          | stylua                               |
| Python       | ruff_format, black                   |
| Shell/Fish   | shfmt, fish_indent                   |
| C/C++        | clang-format                         |
| JS/TS/HTML   | prettier                             |
| JSON/YAML    | jq / prettier                        |
| TOML         | taplo                                |
| Markdown     | prettier                             |
| Fortran      | fprettify                            |

---

## Debugging (nvim-dap + dap-ui)

- `:DapToggleBreakpoint` → set/clear breakpoint
- `:DapContinue` → run/start
- `:DapStepOver` / `:DapStepInto` / `:DapStepOut`
- DAP UI auto-opens on session start.

---

## Bonus: Multi-Cursor

- Native block selections: `Ctrl+v` + `I`/`A`
- True multi-cursor: install **vim-visual-multi**
  - `Ctrl+n` → add cursor to next occurrence
  - `Ctrl+p` → add cursor to prev
  - `Ctrl+x` → skip

---

## Quick Efficiency Tips
- Use `.` to repeat edits, `:noh` to clear highlights
- Combine motions: `d2w` (delete 2 words), `c$` (change to end of line)
- Use **Overseer** for project build/run/test integration
- Map `-` (Oil) for directory browsing like a mini file manager
- Use `<C-`>` as a popup shell without leaving Neovim
- Keep `<leader>` easy (`<Space>` in this config) for speed

---
