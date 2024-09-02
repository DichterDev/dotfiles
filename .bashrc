# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


[[ "$(whoami)" = "root" ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'

## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# aliases
# ls
alias ls='lsd --tree --depth 1'
alias lsa='ls -la'
alias lah='ls -lah'
alias mv='mv -vi'
alias ssh='wezterm ssh'

