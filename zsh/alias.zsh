

alias pls="sudo !!"

# :::
# :::: shelly ::::
# ::::: :::::: :::::
# 
alias refresh="source ${HOME}/.zshrc"
alias zconfig="micro ${HOME}/.zshrc || ${EDITOR} ${HOME}/.zshrc"


# :::
# :::: navigation ::::
# ::::: :::::::::: :::::
# 
# NOTE: the short circuit wont work in bash
#       and (may??) not ALWAYS work in zsh (or fish)
#
#       so what's the point?
#       well with the short circuit you can do:
#
#            >>> up up up
#
# which will correctly change dirs to ../../../
#
alias bk="- || cd -"
alias up="../ || cd ../"
alias goclass="cd ${HOME}/Documents/Class/"
alias goproj="cd ${HOME}/Documents/Project/"
alias goorg="cd ${HOME}/Documents/GithubOrgs/"
alias goterse="cd ${HOME}/Documents/GithubOrgs/tenselyflow"
alias godot="cd ${HOME}/Documents/GithubOrgs/tenselyflow/ndotfiles"

# :::
# :::: python things ::::
# ::::: ::::::::::::: :::::
# 
alias setpy="asdf set python"
alias mange="python manage.py"

# :::
# :::: nodey things ::::
# ::::: nodey things :::::
# 
alias ni="npm --install"
alias setnode="asdf set nodejs"

# :::
# :::: gitty ::::
# ::::: ::::: :::::
# 
alias gad="git add"
alias gas="git status"
alias gall="git add --all"
alias gcomm="git commit --message"
alias gpull="git pull origin trunk"
alias gporg="git push origin trunk"
alias gcamm="git commit --all --message"
alias glogg="git log --online --graph --decorate --all"

# :::
# :::: make ::::
# ::::: :::: :::::
# 
alias mk="make"
alias mka="make all"
alias mkr="make run"
alias mkt="make test"
alias mkc="make clean"

# :::
# :::: other ::::
# ::::: ::::: :::::
# 
alias gfort="gfortran"
alias brewup="brew update && brew upgrade && brew cleanup"



