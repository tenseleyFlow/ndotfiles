## restart a system service
#
function sysrs
    set -l unit (systemctl list-units --type=service --no-legend --no-pager \
        | awk '{print $1}' | fzf --preview 'systemctl status {1} --no-pager' --preview-window=right,70%)
    test -n "$unit"; or return
    sudo systemctl restart $unit
end
