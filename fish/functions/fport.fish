## pick a listening port, kill owning proc
#
function fport
    set -l sel (ss -lntp | awk 'NR>1 {gsub(/,/, ""); print $1,$4,$7}' | \
        fzf --prompt='ports> ' --header='PROTO  LOCAL:PORT  PID/NAME')
    test -n "$sel"; or return
    set -l pid (echo $sel | sed -n 's/.*pid=\([0-9]\+\).*/\1/p')
    test -n "$pid"; or begin; echo "no pid found"; return 1; end
    sudo kill -9 $pid
end
