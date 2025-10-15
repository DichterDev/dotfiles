# SOURCE
alias src="exec fish"

# LS
alias ls="eza -1F --git --icons --group-directories-first --time-style=long-iso"
alias la="ls -alh"
alias lt="la -T --level=2"

# GIT
alias ga="git add"
alias gs="git status"
alias gd="git diff"
alias gcm="git commit -m"

# RSYNC
alias cp="rsync -aP"
alias mv="rsync -aP --remove-source-files"
alias scp="rsync -avzP --rsh=ssh"
