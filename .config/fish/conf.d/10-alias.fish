# SOURCE
alias src="exec fish"

# SYSTEMCTL
alias sv="systemctl --user"

# KITTENS
alias ssh="kitten ssh"
alias icat="kitten icat"

# LS
alias ls="eza -1F --git --icons --group-directories-first --time-style=long-iso"
alias la="ls -alh"
alias lt="ls -T --level=2"
alias lta="la -T --level=2"

# GIT
alias ga="git add"
alias gs="git status"
alias gd="git diff"
alias gcm="git commit -m"
alias gco="git checkout"
alias gp="git push"
alias gm="git merge"
alias gma="git merge --abort"
alias grb="git rebase"
alias grba="grb --abort"
alias grbc="grb --continue"

# NVIM
alias nv="nvim ."

# DOCKER
alias dc="docker compose"
alias dps="docker ps -a --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}'"
alias dcu="docker compose up -d"
alias dcuf="docker compose up -d --force-recreate"
alias dcr="docker compose restart"
alias dcd="docker compose down"
