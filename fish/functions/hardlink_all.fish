## Hardlink every regular file from SRC to DST (non-recursive; includes dotfiles, skips dirs)
#
function hardlink_all --description "Hardlink every file from SRC to DST (includes dotfiles, skips dirs)"
    set -l USAGE "Usage: hardlink_all SRC DST\n\nLinks: regular files only (top-level). Includes dotfiles. Creates DST if missing.\nNote: Hardlinks must be on the same filesystem."

    if test (count $argv) -lt 1 -o "$argv[1]" = "-h" -o "$argv[1]" = "--help"
        echo -e $USAGE
        return 0
    end

    if test (count $argv) -ne 2
        echo -e $USAGE >&2
        return 1
    end

    set -l src "$argv[1]"
    set -l dst "$argv[2]"

    if not test -d "$src"
        echo "hardlink_all: SRC is not a directory: $src" >&2
        return 1
    end

    # Ensure destination directory exists
    mkdir -p "$dst" ^/dev/null
    if not test -d "$dst"
        echo "hardlink_all: failed to create DST: $dst" >&2
        return 1
    end

    # Best-effort filesystem check (hardlinks can't cross filesystems)
    set -l srcfs (df -P "$src" | tail -1 | awk '{print $1}')
    set -l dstfs (df -P "$dst" | tail -1 | awk '{print $1}')
    if test -n "$srcfs" -a -n "$dstfs" -a "$srcfs" != "$dstfs"
        echo "hardlink_all: SRC and DST are on different filesystems ($srcfs ≠ $dstfs); hardlinks will fail." >&2
        return 1
    end

    set -l count 0
    set -l fail 0

    # Top-level files, including dotfiles; exclude '.' and '..'
    set -l files  $src/*
    set -l dot1   $src/.[!.]*
    set -l dot2   $src/..?*

    for f in $files $dot1 $dot2
        if test -f "$f"
            ln -f "$f" "$dst/"; or begin
                echo "hardlink_all: failed to link: $f" >&2
                set fail 1
            end
            set count (math $count + 1)
        end
    end

    if test $count -eq 0
        echo "hardlink_all: nothing to link (no regular files found in $src)."
    else
        echo "hardlink_all: linked $count file(s) from $src → $dst"
    end

    return $fail
end
