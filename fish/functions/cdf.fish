## jump to dir
#
function cdf
    set -l dir (fd --type d --hidden --follow --exclude .git | fzf)
    test -n "$dir"; and cd "$dir"
end
