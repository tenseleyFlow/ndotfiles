## browse commits, preview diff, enter for full patch
#
function glog
    command git rev-parse --git-dir >/dev/null ^/dev/null; or begin; echo "not a git repo"; return 1; end
    set -l sel (git log --graph --date=short --pretty=format:'%C(auto)%h %ad %d %s %C(blue)%an%Creset' \
        | fzf --ansi --no-sort --reverse --tiebreak=index \
              --preview 'git show --color=always (echo {} | awk "{print \$1}")')
    test -n "$sel"; or return
    set -l sha (echo $sel | awk '{print $1}')
    git show --stat --patch --color=always $sha | less -R
end
