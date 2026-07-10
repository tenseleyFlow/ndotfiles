# source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
export PATH="$HOME/.local/bin:$PATH"

# gump
gump init fish | source

# Correct $SHELL to the fish binary actually running. herdr spawns fish
# directly (bypassing the login/PAM step that would set SHELL from passwd),
# so panes otherwise inherit a stale SHELL=/usr/bin/zsh from herdr's launch
# env. `status fish-path` = the running fish, so this self-corrects with no
# hardcoded path and propagates to children. Must precede the exec below.
set -gx SHELL (status fish-path)

# gitswitch: point SSH_AUTH_SOCK / GNUPGHOME at the active account, and
# auto-resume the last-used account on the first login after a reboot.
# Placed before the herdr exec so it also runs in remote sessions.
if status is-interactive
    set -gx GPG_TTY (tty)
end
gitswitch init fish | source

# herdr: when reached over ssh (from another box), drop into the shared,
# persistent "remote" session so remote logins are seamless.
# Guards: interactive only; ssh sessions only; skip if already inside herdr
# (panes export HERDR_ENV) to avoid re-exec loops; skip if herdr is missing;
# HERDR_NO_AUTOATTACH=1 disables it. Escape hatch if ever wedged: `ssh kasumi -t bash`.
if status is-interactive
    and set -q SSH_CONNECTION
    and not set -q HERDR_ENV
    and not set -q HERDR_NO_AUTOATTACH
    and type -q herdr
    exec herdr --session remote
end

# Starship prompt
starship init fish | source
