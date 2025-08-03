# Neovim Keybind Guide for Modern Usage

This guide provides a concise reference for keybindings in Neovim (version 0.7 or later), focusing on quick navigation, jumping between words and lines, and handling multiple cursors or selections. Master these to enhance your productivity in this powerful text editor.

## Neovim Modes Overview

Neovim operates in distinct modes, each serving specific purposes. Understanding these is essential for effective editing.

| Mode            | Description                                      | How to Enter                     |
|-----------------|--------------------------------------------------|----------------------------------|
| **Normal Mode** | Default mode for navigation and commands        | Press `Esc` from other modes     |
| **Insert Mode** | For typing and inserting text                   | Press `i`, `a`, `o`, etc. from Normal Mode |
| **Visual Mode** | For selecting text (line, block, or character)  | Press `v`, `V`, or `Ctrl+v` from Normal Mode |
| **Command Mode**| For entering Ex commands (e.g., saving, quitting)| Press `:` from Normal Mode       |

## Navigation Keybindings

These keybindings are primarily for **Normal Mode** and help you move around your editor efficiently.

### Basic Movement
| Keybind       | Action                            |
|---------------|-----------------------------------|
| `h`           | Move left one character          |
| `j`           | Move down one line               |
| `k`           | Move up one line                 |
| `l`           | Move right one character         |
| `w`           | Jump to start of next word       |
| `b`           | Jump to start of previous word   |
| `e`           | Jump to end of current/next word |
| `0`           | Jump to start of line            |
| `$`           | Jump to end of line              |
| `gg`          | Jump to first line of file       |
| `G`           | Jump to last line of file        |
| `{number}G`   | Jump to specific line number (e.g., `5G` for line 5) |

### Scrolling and Larger Jumps
| Keybind       | Action                            |
|---------------|-----------------------------------|
| `Ctrl+u`      | Scroll up half a screen          |
| `Ctrl+d`      | Scroll down half a screen        |
| `Ctrl+b`      | Scroll up a full screen (backward)|
| `Ctrl+f`      | Scroll down a full screen (forward)|
| `%`           | Jump to matching bracket/parenthesis |

### Search-Based Navigation
| Keybind       | Action                            |
|---------------|-----------------------------------|
| `/` + `text` + `Enter` | Search forward for text; use `n` for next, `N` for previous |
| `?` + `text` + `Enter` | Search backward for text; use `n` for next, `N` for previous |
| `*`           | Jump to next occurrence of word under cursor |
| `#`           | Jump to previous occurrence of word under cursor |

## Editing and Multi-Cursor Techniques

Neovim lacks native multi-cursor support, but Visual Mode and other features provide powerful alternatives. These are mostly **Normal Mode** commands unless noted.

### Basic Editing
| Keybind       | Action                            |
|---------------|-----------------------------------|
| `i`           | Enter Insert Mode before cursor   |
| `a`           | Enter Insert Mode after cursor    |
| `o`           | Open new line below, enter Insert Mode |
| `O`           | Open new line above, enter Insert Mode |
| `x`           | Delete character under cursor     |
| `dd`          | Delete current line               |
| `yy`          | Yank (copy) current line          |
| `p`           | Paste after cursor                |
| `P`           | Paste before cursor               |

### Visual Mode for Selections (Multi-Cursor Alternative)
| Keybind       | Action                            |
|---------------|-----------------------------------|
| `v`           | Start character-wise Visual Mode  |
| `V`           | Start line-wise Visual Mode       |
| `Ctrl+v`      | Start block-wise Visual Mode (for columnar edits) |
| After selection, `I` | Insert at start of each selected line/block (block mode) |
| After selection, `A` | Append at end of each selected line/block (block mode) |

**Note:** For block edits, select with `Ctrl+v`, move with `j`/`k`, then use `I` or `A` to edit multiple lines at once. Press `Esc` to apply changes.

### Repeating Commands for Efficient Edits
| Keybind       | Action                            |
|---------------|-----------------------------------|
| `.`           | Repeat the last command          |
| `{number}{command}` | Repeat command a specific number of times (e.g., `5dd` deletes 5 lines) |

## Plugin for True Multi-Cursor Support

For a modern multi-cursor experience (like VS Code), install the `vim-visual-multi` plugin.

| Plugin        | Keybind       | Action                            |
|---------------|---------------|-----------------------------------|
| `vim-visual-multi` | `Ctrl+n` | Start multi-cursor or add cursor at next word occurrence |
| `vim-visual-multi` | `Ctrl+p` | Add cursor at previous occurrence |
| `vim-visual-multi` | `Ctrl+x` | Skip an occurrence               |

**Installation:** Add via plugin manager, e.g., `Plug 'mg979/vim-visual-multi'` with vim-plug.

## Quick Tips for Efficiency
-  **Practice Normal Mode:** Use it for navigation to minimize mode-switching.
-  **Leverage `.` for Repetition:** Repeat edits quickly with the dot operator.
-  **Combine Commands:** Use motions with actions, e.g., `d2w` (delete 2 words) or `c$` (change to end of line).
-  **Use `:help`:** Type `:help key-notation` or `:help motion` in Neovim for detailed docs.

This tabulated guide focuses on default Neovim keybindings and practical workflows. For customizations or plugin setup help, let me know!
