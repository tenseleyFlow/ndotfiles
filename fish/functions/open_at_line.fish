## open file at a specific line in editor (agnostic. sorta)
#
function open_at_line
    set -l file $argv[1]; set -l line $argv[2]
    if test -z "$file" -o -z "$line"
        echo "usage: open_at_line <file> <line>"; return 1
    end

    # Extract the base command from $EDITOR ("code --wait" -> "code")
    set -l editor_base (basename -- (string split ' ' -- $EDITOR)[1])

    switch $editor_base
        case 'code' 'code-insiders'
            # VS Code: --goto file:line
            $EDITOR -g "$file":$line

        case 'hx'
            # Helix understands path:row[:col] in recent builds; fall back to +LINE
            hx "$file":$line; or hx +$line "$file"

        case 'micro'
            # Micro: enable parsecursor so file:line works reliably
            micro --parsecursor "$file":$line

        case 'nvim' 'vim' 'vi' 'kak' 'nano'
            # Many TUI editors accept +LINE
            $EDITOR +$line "$file"

        case '*'
            # Generic fallback used by many editors (sed-like)
            $EDITOR +$line "$file"
    end
end
