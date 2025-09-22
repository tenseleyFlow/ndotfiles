## pick a host from ~/.ssh/config and tailscale peers
#
function sshf
    set -l cfghosts (awk '/^Host[[:space:]]+/ {for (i=2;i<=NF;i++) if ($i !~ /[*?]/) print $i}' ~/.ssh/config 2>/dev/null)
    for f in ~/.ssh/config.d/*.conf
        test -r $f; and set cfghosts $cfghosts (awk '/^Host[[:space:]]+/ {for (i=2;i<=NF;i++) if ($i !~ /[*?]/) print $i}' $f)
    end
    set -l lines
    for h in $cfghosts; set lines $lines $h; end
    if type -q tailscale; and type -q jq
        set -l ts (tailscale status --json | jq -r '.Peer[] | "\(.HostName)\t\(.TailscaleIPs[0])"')
        set lines $lines $ts
    end
    test (count $lines) -gt 0; or begin; echo "no hosts found"; return 1; end
    set -l sel (printf '%s\n' $lines | column -t -s \t | fzf --prompt="ssh> " --preview 'echo {}')
    test -n "$sel"; or return
    set -l last (echo $sel | awk '{print $NF}')
    if string match -qr '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' -- $last
        set host $last
    else
        set host (echo $sel | awk '{print $1}')
    end
    ssh $host
end
