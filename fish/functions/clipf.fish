## fuzzy pick from clipboard history, copy
#
function clipf
    type -q cliphist; or begin; echo "cliphist not installed"; return 1; end
    set -l id (cliphist list | fzf --tac --preview 'cliphist decode {} | sed -n "1,200p"')
    test -n "$id"; or return
    cliphist decode $id | wl-copy
end
