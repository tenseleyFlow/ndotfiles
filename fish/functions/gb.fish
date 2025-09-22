## switch branch with preview
#
function gb
    command git rev-parse --git-dir >/dev/null ^/dev/null; or begin; echo "not a git repo"; return 1; end
    set -l branch (git for-each-ref --format='%(refname:short)' refs/heads refs/remotes \
        | sort -u | fzf --prompt="git branch> " --height=70% \
               --preview 'git log --oneline --decorate -n 20 {1}')
    test -n "$branch"; or return
    set branch (string replace -r '^remotes/[^/]+/' '' -- $branch)
    git checkout $branch
end
