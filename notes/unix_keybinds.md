# Basic UNIX Readline Keybindings

| Keybinding                    | Action                                                          |
|-------------------------------|-----------------------------------------------------------------|
| `Ctrl-A`                      | Move cursor to **start** of line                                |
| `Ctrl-E`                      | Move cursor to **end** of line                                  |
| `Ctrl-B`                      | Move cursor **back** one character                              |
| `Ctrl-F`                      | Move cursor **forward** one character                           |
| `Alt-B` (or `Esc` then `B`)   | Move cursor **back** one word                                   |
| `Alt-F` (or `Esc` then `F`)   | Move cursor **forward** one word                                |
| `Ctrl-P`                      | Previous command in history                                     |
| `Ctrl-N`                      | Next command in history                                         |
| `Ctrl-R`                      | **Reverse**-search through history                              |
| `Ctrl-S`                      | **Forward**-search (often disabled)                             |
| `Ctrl-U`                      | **Kill** (cut) from cursor to start of line                     |
| `Ctrl-K`                      | **Kill** from cursor to end of line                             |
| `Ctrl-W`                      | **Kill** (cut) word before cursor                               |
| `Alt-D` (or `Esc` then `D`)   | **Kill** word after cursor                                      |
| `Ctrl-Y`                      | **Yank** (paste) last killed text                               |
| `Ctrl-T`                      | **Transpose** (swap) character under cursor and previous one    |
| `Alt-T` (or `Esc` then `T`)   | **Transpose** (swap) current and previous word                  |
| `Alt-.` (or `Esc` then `.`)   | Insert **last argument** of previous command                    |
| `Ctrl-L`                      | Clear screen (**NOT** the same as running `clear`)              |
| `Ctrl-C`                      | **Cancel** current command/line (**SIGINT**)                    |
| `Ctrl-D`                      | **EOF** / close shell if line empty                             |
| `Ctrl-_` (or `Ctrl-X Ctrl-U`) | **Undo** last edit (if enabled)                                 |
| `Ctrl-X Ctrl-E`               | Open current command in your `$EDITOR` for multi-line editing   |