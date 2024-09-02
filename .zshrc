# Created by newuser for 5.9

[[ $- != *i* ]] && return

autoload -Uz compinit promptinit
compinit
promptinit

zstyle ':completion::complete:*' gain-privileges 1

# ALIASES
alias ls='exa -T --level=1 --group-directories-first'
alias lsa='ls -al'
alias mv='mv -vi'
alias ssh='wezterm ssh'

eval "$(starship init zsh)"
