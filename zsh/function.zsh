# defines a function named "up" that:
#   - counts how many arguments ($#) were passed
#   - does `cd ..` exactly that many times plus one
#
# In other words:
#   up             → $# = 0  → 1 parent
#   up up          → $# = 1  → 2 parents
#   up up up       → $# = 2  → 3 parents
#
# This pattern applies to `bk` too
#   NOTE: no it doesn't
#

up() {
  # $# is “number of additional words” you typed
  local n
  n=$(( $# + 1 ))        # if no args, n=1; if “up up”, $#=1→n=2; etc.

  # Ensure all arguments are exactly "up"
  for arg in "$@"; do
    if [[ "$arg" != "up" ]]; then
      echo "Error: 'up' only accepts repeated 'up' arguments." >&2
      return 1
    fi
  done

  # Calculate how many levels to go up
  local n=$(( $# + 1 ))
  while (( n > 0 )); do
    builtin cd ..        # use builtin cd to avoid recursing into this function
    (( n-- ))
  done
}

# NOTE: does not function as intended
#
# bk() {
#   # Ensure all arguments are exactly "bk"
#   for arg in "$@"; do
#     if [[ "$arg" != "bk" ]]; then
#       echo "Error: 'bk' only accepts repeated 'bk' arguments." >&2
#       return 1
#     fi
#   done

#   # Determine number of toggles: if no args, toggle once; else toggle once per "bk"
#   local count
#   if (( $# == 0 )); then
#     count=1
#   else
#     count=$#
#   fi

#   while (( count > 0 )); do
#     builtin cd -
#     (( count-- ))
#   done
# }