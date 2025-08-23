## pick repo packages, install w. paru
#
function packin
    set -l pkgs (paru -Slq | fzf --multi --preview 'paru -Si {1}')
    test -n "$pkgs"; or return
    paru -S $pkgs
end
