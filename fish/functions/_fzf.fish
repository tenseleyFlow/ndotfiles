## use a tmux popup when available
#
function _fzf
    if set -q TMUX
        # 85% x 85% popup; pass through args
        fzf-tmux -p 85%,85% -- $argv
    else
        fzf $argv
    end
end
