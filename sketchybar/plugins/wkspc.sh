#!/bin/zsh
# simple aerospace workspace status 'bar' for sketchy...'bar'
# show count of non-empty wkspcs, active workspace and up to
# 4 other non-empty workspaces in the format:
#                       "<ico> N :: F : 1 2 3 4"
#
# where N is the number of non-empty spaces
# and F is the focused space and up to 1-4 are nonempty wkspcs
active=$(aerospace list-workspaces --focused)

case "$1" in
  count)
    # count of non-empty workspaces
    num_active=$(aerospace list-workspaces --empty no --count --monitor all)
    sketchybar --set "wkspc_count" label="${num_active}" 
    sketchybar --set "wkspc_count" label.color=0xff98E6EB
    ;;
  focus)
    # grab the currently focused wkspc
    sketchybar --set "wkspc_act" label="${active}"
    ;;
  others)
    # my brain was hurting and this seemed
    # the best approach to pull newlines out
    # {
    #   mapfile -t workspaces < <( \
    #     aerospace list-workspaces --monitor all --empty no \
    #   )
    #   others=()
    #   for ws in "${workspaces[@]}"; do
    #     [[ "$ws" == "$active" ]] && continue
    #     others+=("$ws")
    #     (( ${#others[@]} == 4 )) && break
    #   done

    #   others_string="${others[*]}"
    # }

    # then gippity gave me this one...
    # either that brain pain above was an
    # anyeurism or I've gravely forgotten how to bash-a-mole
    others_string=$(aerospace list-workspaces --monitor all --empty no --format '%{workspace}' \
      | grep -v "^${active}$" \
      | head -n4 \
      | paste -sd ' ' -)

    sketchybar --set "wkspc_other" label=": ${others_string}"
    ;;
esac


