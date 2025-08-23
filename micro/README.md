# Micro — keys & workflow (fish + plugins)

---

## Core (built-in)
- **Ctrl-E** — Command bar. Run `help …`, `plugin list`, `open`, `fzfinder`, `log`, etc.
- **Ctrl-S** — Save. **Ctrl-Q** — Close current buffer (quit if last). **Ctrl-O** — Open file (fallback; you’ll usually use **Alt-f**).

---

## fzfinder (fast file open)
**Open:** **Alt-f**  
**What it does:** Fuzzy-find files using our git-aware wrapper (`mfzf`). In repos it lists `git ls-files`; otherwise it uses `fd`. Preview shows with `bat`. Opens in a **new tab**.

**Inside the picker (fzf):**
- Type to filter; **↑/↓** or **Ctrl-j/Ctrl-k** to move
- **Enter** open selection **Tab / Shift-Tab** multi-select (if enabled)
- Our options: `--height=85% --layout=reverse [--multi] --preview 'bat -f -p {}'`

**Tweakable:**
- `settings.json` → `fzfarg`, `fzfopen` (`newtab` or `open`), `fzfpath` (`relative` or `absolute`).
- Edit `/usr/local/bin/mfzf` to ignore heavy dirs (`node_modules`, `dist`, `target`, …).

---

## Palettero (command palette)
**Open:** **Ctrl-P** (also **Alt-Ctrl-Space**)  
**What it does:** Fuzzy-search *any* Micro/plug-in command (and text filters) and run it. Great for discovery.

**Use:** Open → type (“jump”, “tree”, “help fzfinder”, “pipe jq .”, …) → **Enter**.

**Pro tip:** add your favorite one-liners as palette items (JSON format via `editmenu`), e.g. JSON pretty, YAML⇄JSON, sort unique.

---

## Quickfix (project grep & jump)
**Search word under cursor:** **Alt-g**  
**Prompted search:** **Ctrl-Alt-g**  
**What it does:** Runs ripgrep (`rg -n`) and drops results into a quickfix list. Select a line → **Enter** jumps to file/line.

**Flow:** Trigger search → use **↑/↓** to browse results → **Enter** to jump. Close the panel when done.

---

## runit (run/build)
**Run current file:** **F5** **Make:** **F12** **Make (background):** **F9**  
**What it does:** Saves & runs the active file (language/shebang aware). In projects with a `Makefile`, use F12/F9 for builds.

**Tips:**
- For scripts, add a proper shebang (e.g., `#!/usr/bin/env python3`) so F5 “just works”.
- Use the command bar to run custom commands on demand if there’s no Makefile.

---

## Filemanager (side tree)
**Toggle tree:** **Ctrl-b**  
**What it does:** Opens/closes a file tree pane you can navigate with arrows and open with **Enter**. Handy for quick browsing.

**Tip:** Set `filemanager.openonstart = true` if you want it by default (add in `settings.json`).

---

## Jump (symbols / headings)
**Open outline:** **F4**  
**What it does:** Fuzzy-jump within the current buffer (functions, classes, Markdown headings, etc.).

---

## LSP (optional)
**What it does:** Hover/definition/references/completion/formatting with language servers.  
**Typical defaults:** hover, go-to-definition, references, completion (check `help lsp` after installing servers).

---

## Handy palette one-liners
Run these from **Ctrl-E** (or bind keys to them):
- `pipe jq .` — pretty-print JSON
- `pipe yq -P` — pretty JSON→YAML (needs `yq`)
- `pipe sort -u` — sort unique lines
- `pipe sed -E 's/[[:space:]]+$//'` — strip trailing whitespace
