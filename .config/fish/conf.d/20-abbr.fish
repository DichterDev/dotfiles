# SOURCE
abbr -a src "exec fish"

# SYSTEMCTL
abbr -a sv "systemctl --user"

# PACMAN
abbr -a pcmni "pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"

# KITTENS
abbr -a ssh "kitten ssh"
abbr -a icat "kitten icat"

# BASE
abbr -a rm "rm -Irf"
abbr -a cp "cp -av"

# LS
alias ls="eza -1F --git --icons --group-directories-first --time-style=long-iso"
abbr -a la "ls -alh"
abbr -a lt "ls -T --level=2"
abbr -a lta "la -T --level=2"

# CD
alias cd="z"

# SUDO
function last_history_item
    echo $history[1]
end

abbr -a !! --position anywhere --function last_history_item

# GIT
abbr -a ga "git add"
abbr -a gs "git status"
abbr -a gd "git diff"
abbr -a gcm "git commit -m"
abbr -a gco "git checkout"
abbr -a gp "git push"
abbr -a gm "git merge"
abbr -a gma "git merge --abort"
abbr -a grb "git rebase"
abbr -a grba "grb --abort"
abbr -a grbc "grb --continue"

# NVIM
alias nv="nvim"

# DOCKER
abbr -a dc "docker compose"
abbr -a dps "docker ps -a --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}'"
abbr -a dcu "docker compose up -d"
abbr -a dcuf "docker compose up -d --force-recreate"
abbr -a dcr "docker compose restart"
abbr -a dcd "docker compose down"
