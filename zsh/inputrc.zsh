# as long as in the $ZSH_CUSTOM dir, 
# this is loaded automatically

# alt-left/right: back/forward word
bindkey '\e[1;3C' forward-word
bindkey '\e[1;3D' backward-word

# cmd+left/right: end/beg. line
# NOTE: in wezterm this requires redirecting
#		    the string to PTY via wezterm.action.SendString
bindkey '\e[1;9C' end-of-line
bindkey '\e[1;9D' beginning-of-line
