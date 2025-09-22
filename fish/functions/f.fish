## preview file, open in editor
#
function f
    set -l files (_fzf --multi)
    test -n "$files"; and $EDITOR $files
end
