# SOURCE
abbr -a src "exec fish"
abbr -a q exit

# SYSTEMCTL
abbr -a sv "systemctl --user"
abbr -a jv "journalctl --user -xeu"

# PACMAN
alias pkg "pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"

# KITTENS
alias ssh "kitten ssh"
abbr -a icat "kitten icat"

# BASE
abbr -a rm "rm -Ir"
abbr -a cp "cp -av"

# LS

if type -q eza
    alias ls="eza -1F --git --icons --group-directories-first --time-style=long-iso"
    abbr -a lt "ls -hT --level=2"
    abbr -a lta "ls -ahT --level=2"
    abbr -a llt "ls -alhT --level=2"
else
    alias ls="ls --color=auto --group-directories-first"
end

abbr -a la "ls -ah"
abbr -a ll "ls -alh"

# CD

if type -q z
    alias cd="z"
end

# SUDO
function last_history_item
    echo $history[1]
end

abbr -a !! --position anywhere --function last_history_item

# GIT
abbr -a ga "git add"
abbr -a gs "git status"
abbr -a gd "git diff"
abbr -a gl "git log --oneline --graph --decorate"
abbr -a gcm "git commit -m"
abbr -a gco "git checkout"
abbr -a gp "git push"
abbr -a gm "git merge"
abbr -a gma "git merge --abort"
abbr -a grs "git reset HEAD"
abbr -a grb "git rebase"
abbr -a grba "grb --abort"
abbr -a grbc "grb --continue"

# NVIM
alias nv="nvim"

# DOCKER
abbr -a dc "docker compose"
alias dps "docker ps -a --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}'"
abbr -a dcu "docker compose up -d"
abbr -a dcub "docker compose up -d --build"
abbr -a dcuf "docker compose up -d --force-recreate"
abbr -a dcr "docker compose restart"
abbr -a dcd "docker compose down"
