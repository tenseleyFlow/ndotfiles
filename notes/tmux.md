# Plugin Defaults — Quick Reference

> “prefix” means your tmux prefix key (default: Ctrl+b).

| Plugin | Default keys | Context | What it does | Notes / Tips |
|---|---|---|---|---|
| tmux-yank | prefix + **y** | Normal mode | Copy the current command-line text to system clipboard. | Also **prefix + Y** copies the pane’s CWD. |
|  | **y** | Copy-mode | Yank the current selection to system clipboard. | **Y** “puts” selection to the command line. |
| tmux-copycat | prefix + **/** | Normal mode | Start regex (or plain text) search; enter “copycat mode”. | Then **n/N** next/prev match; **Enter** to copy (vi mode). |
|  | prefix + **Ctrl-f** | Normal mode | Predefined search: files. | Other presets below. |
|  | prefix + **Ctrl-g** | Normal mode | Predefined search: `git status` files. |  |
|  | prefix + **Alt-h** | Normal mode | Predefined search: SHA hashes. |  |
|  | prefix + **Ctrl-u** | Normal mode | Predefined search: URLs. |  |
|  | prefix + **Ctrl-d** | Normal mode | Predefined search: numbers (digits). |  |
|  | prefix + **Alt-i** | Normal mode | Predefined search: IP addresses. |  |
| tmux-open | **o** | Copy-mode | Open highlighted path/URL with system default app. | **Ctrl-o** open in `$EDITOR`; **Shift-s** search the text. |
| tmux-fzf | prefix + **F** (Shift+f) | Normal mode | Launch fzf-driven session/window/pane switcher (popup on modern tmux). | Inside fzf: **Tab/Shift-Tab** to multi-select. |
| tmux-fzf-url | prefix + **u** | Normal mode | Fuzzy-pick any URL visible in the pane and open it. | Change with `set -g @fzf-url-bind 'x'` if desired. |
| tmux-resurrect | prefix + **Ctrl-s** | Normal mode | Save full tmux state (sessions/windows/panes, dirs, layout). |  |
|  | prefix + **Ctrl-r** | Normal mode | Restore last saved state. |  |
| tmux-continuum | *(no keys; runs in background)* | — | Auto-saves every ~15 min; auto-restore on tmux start if enabled. | Enable restore: `set -g @continuum-restore 'on'`. |
| tmux-prefix-highlight | *(no keys)* | — | Adds `#{prefix_highlight}` segment showing when prefix is active. | Add it to your status-left/right to display. |
| TPM (plugin manager) | prefix + **I** | Normal mode | Install/refresh plugins. |  |
|  | prefix + **U** | Normal mode | Update plugins. |  |
|  | prefix + **Alt+u** | Normal mode | Uninstall plugins removed from config. |  |

## Verify what’s bound in *your* session
- List keys: `tmux list-keys | grep -Ei 'yank|copycat|open|fzf|resurrect|continuum|tpm'`
- Some plugins adapt to tmux version/OS; use the command above as source of truth.
