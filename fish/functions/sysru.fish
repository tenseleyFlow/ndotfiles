## restart a user service
#
function sysru
    set -l unit (systemctl --user list-units --type=service --no-legend --no-pager \
        | awk '{print $1}' | fzf --preview 'systemctl --user status {1} --no-pager' --preview-window=right,70%)
    test -n "$unit"; or return
    systemctl --user restart $unit
end
