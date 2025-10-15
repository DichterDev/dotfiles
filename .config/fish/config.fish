if status is-interactive
    # Commands to run in interactive sessions can go here
end

set SHELL /bin/fish

starship init fish | source
zoxide init fish | source
