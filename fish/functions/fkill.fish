## pick process(es) send TERM, kill if needed
#
function fkill
    set -l pids (ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | sed 1d | \
        fzf --multi --header='PID  USER  %CPU  %MEM  CMD' \
            --preview 'ps -p (awk "{print \$1}" <<< {}) -o pid,ppid,etime,cmd --no-headers' \
        | awk '{print $1}')
    test -n "$pids"; or return
    for p in $pids
        kill $p; or sudo kill -9 $p
    end
end
