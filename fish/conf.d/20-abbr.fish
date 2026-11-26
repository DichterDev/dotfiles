# SOURCE
abbr -a src "exec fish"

# SYSTEMD
abbr -a sv "systemctl --user"
abbr -a svs "sv start --now"
abbr -a sve "sv enable --now"
abbr -a svd "sv stop"
abbr -a svr "sv restart"
abbr -a svps "sv status"
abbr -a svdr "sv daemon-reload"

abbr -a jv "journalctl --user -xeu"

# PACMAN
alias pkg "pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"

# KITTENS
# alias ssh "kitten ssh"
abbr -a icat "kitten icat"

# BASE
alias cp "cp -av"
alias mv "mv -v"
alias ls="ls --color=auto --group-directories-first"

abbr -a rmfr "rm -fr"
abbr -a rma "rm -fr * && rm -fr *."

# LS

if type -q eza
    alias ls="eza -1F --git --icons --group-directories-first --time-style=long-iso"
    abbr -a lt "ls -hT --level=2"
    abbr -a lta "ls -ahT --level=2"
    abbr -a llt "ls -alhT --level=2"
end

abbr -a la "ls -ah"
abbr -a ll "ls -alh"

# CD

if type -q z
    alias cd="z"
end

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
alias dps "docker ps -a --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}'"
abbr -a dc "docker compose"
abbr -a dcu "docker compose up -d"
abbr -a dcub "docker compose up -d --build"
abbr -a dcuf "docker compose up -d --force-recreate"
abbr -a dcr "docker compose restart"
abbr -a dcd "docker compose down"

# ZELLIJ
abbr -a zj zellij
abbr -a zja "zellij attach"
abbr -a zjs "zellij -s"
abbr -a zjk "zellij k"
abbr -a zjka "zellij ka"
abbr -a zjls "zellij ls"
