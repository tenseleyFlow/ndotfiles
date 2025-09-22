# Fish Functions – Quick Reference

Drop these files in `~/.config/fish/functions/` (one function per file with the same basename).  
Most commands expose `-h/--help` or print usage on bad args (by convention).

---

## Workflow & Navigation

- **`cdf`** — Fuzzy-jump into a directory (fzf picker), then `cd` there.  
  **Usage:** `cdf` or `cdf <pattern>`

- **`f`** — Fuzzy-find a file and open it in `$EDITOR` (or print path if no editor set).  
  **Usage:** `f` or `f <pattern>`

- **`open_at_line`** — Open a file at a specific line in your editor (e.g., `nvim +{line} {file}`).  
  **Usage:** `open_at_line <file> <line>`

- **`viewnotes`** — Launch your notes TUI layout (three panes: selector | renderer | preview).  
  **Usage:** `viewnotes`  
  *Notes:* Designed to wire up tmux + previewers; expects your note tree configured.

---

## Git Helpers

- **`glog`** — Pretty, condensed `git log` (graph, decorate, relative dates).  
  **Usage:** `glog [<path>] [-n <N>]`

- **`gb`** — Fuzzy switch/checkout git branches (create if `!exists` when you type a new name).  
  **Usage:** `gb`

---

## Search & Clipboard

- **`rga`** — Wrapper around ripgrep-all for searching text, PDFs, media metadata, etc.  
  **Usage:** `rga <pattern> [path]`

- **`clipf`** — Copy file contents (or stdin) to the clipboard (`wl-copy`/`xclip` fallback).  
  **Usage:** `clipf [file]` (no args → read stdin)

---

## Packages & System

- **`packin`** — “Search → choose → install” helper for Arch (paru/pacman under the hood).  
  **Usage:** `packin <pkg|pattern>`

- **`sysrs`** — Restart a *system* service (via `sudo systemctl restart`).  
  **Usage:** `sysrs <service>`

- **`sysru`** — Restart a *user* service (`systemctl --user restart`).  
  **Usage:** `sysru <service>`

---

## Processes & Ports

- **`fkill`** — Fuzzy-pick a process and kill it (smart SIGTERM→SIGKILL escalation).  
  **Usage:** `fkill` or `fkill <pattern>`

- **`fport`** — Show what’s bound to a port; optionally kill it.  
  **Usage:** `fport <port>`

---

## Files & Links

- **`hardlink_all`** — Hard-link every regular file from a source dir into a dest dir (same filesystem only).  
  **Usage:** `hardlink_all <src_dir> <dst_dir>`  
  *Notes:* Requires source and destination on the same filesystem; skips non-regular files.

---

## SSH

- **`sshf`** — Fuzzy-select and SSH into a host from your `~/.ssh/config` (or known_hosts).  
  **Usage:** `sshf`

---

## Internals & Keybinds

- **`_fzf`** — Shared fzf defaults (preview, keybinds, colors).  
  **Usage:** *(internal; sourced by other functions)*

- **`fish_user_key_bindings`** — Centralized keybindings (sets up fzf bindings, extras).  
  **Usage:** *(auto-loaded by fish; not called directly)*

---
