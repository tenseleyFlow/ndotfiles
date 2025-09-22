function viewnotes --description 'fzf-pick a note from ~/GithubOrgs/tenseleyFlow/ndotfiles/notes and view it'
    set -l NOTES_DIR ~/GithubOrgs/tenseleyFlow/ndotfiles/notes
    if test (count $argv) -gt 0
        set NOTES_DIR $argv[1]
    end

    if not test -d $NOTES_DIR
        echo "Directory not found: $NOTES_DIR" >&2
        return 1
    end

    # Choose a viewer by preference
    set -l viewer ''
    for v in md-tui glow mdcat mdless mdp bat less
        if type -q $v
            set viewer $v
            break
        end
    end
    if test -z "$viewer"
        echo "No suitable markdown viewer found (md-tui/glow/mdcat/mdless/mdp/bat/less)." >&2
        echo "Install one (e.g., 'sudo pacman -S glow' or 'paru -S md-tui')." >&2
        return 1
    end

    # Build preview command for fzf
    set -l preview ''
    if type -q glow
        set preview 'glow -p --style dark --width 0 {}'
    else if type -q bat
        set preview 'bat --paging=never --style=plain --language=markdown {}'
    else
        set preview 'sed -n "1,200p" {}'
    end

    # Collect .md files; use fd if present for speed
    set -l files
    if type -q fd
        set files (fd -t f -e md . $NOTES_DIR | sort)
    else
        set files (command find $NOTES_DIR -type f -name '*.md' | sort)
    end

    if test (count $files) -eq 0
        echo "No .md files found in $NOTES_DIR" >&2
        return 1
    end

    # fzf pick
    set -l pick (printf '%s\n' $files | fzf --prompt='notes> ' --bind='alt-p:toggle-preview' --preview="$preview" --height=80% --layout=reverse --border --preview-window='right,60%,border')
    if test -z "$pick"
        return 0
    end

    # View according to the chosen tool
    switch $viewer
        case 'md-tui'
            md-tui "$pick"
        case 'glow'
            glow -p --style dark --width 0 "$pick"
        case 'mdcat'
            mdcat "$pick" | less -R
        case 'mdless'
            mdless "$pick"
        case 'mdp'
            mdp "$pick"
        case 'bat'
            bat --paging=always --style=plain --language=markdown "$pick"
        case 'less'
            less -R "$pick"
    end
end
