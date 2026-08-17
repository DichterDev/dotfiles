if status is-interactive
    mise activate fish | source
    if not set -q SSH_AUTH_SOCK
        keychain --eval -Q --noask --quiet $private_keys | source
    end
end

fish_add_path "$HOME/.local/bin"

# cargo
fish_add_path "$HOME/.cargo/bin"

set -g fish_greeting ""
