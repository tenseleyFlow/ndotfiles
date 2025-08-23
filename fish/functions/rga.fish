## search code, preview, open to line
#
function rga
    if test (count $argv) -eq 0
        echo 'usage: rga <pattern>'; return 1
    end
    set -l out (rg --line-number --no-heading --color=always --smart-case $argv \
        | _fzf --ansi --delimiter : \
               --preview 'bat --style=numbers --color=always --highlight-line {2} {1}')
    test -n "$out"; or return
    set -l file (echo $out | cut -d: -f1)
    set -l line (echo $out | cut -d: -f2)
    open_at_line "$file" "$line"
end
