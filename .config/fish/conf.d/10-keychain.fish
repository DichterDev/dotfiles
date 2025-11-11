# loads all private keys in .ssh
# must be called id_xxxxx
if command -v keychain >/dev/null
    set -l key_files ~/.ssh/id_*
    set -l private_keys

    for file in $key_files
        if string match -- "*id_*.*" "$file" >/dev/null
            continue
        end
        set -a private_keys "$file"
    end

    if test (count $private_keys) -gt 0
        keychain --eval -Q --nogui $private_keys | source
    end
end
