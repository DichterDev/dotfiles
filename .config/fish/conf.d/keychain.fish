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
        set -l kc_out keychain --eval -Q --quiet $private_keys --nogui | source
        set -l fish_commands (echo "$kc_out" | awk '{gsub(/;/, ""); print "set -gx "$1}' | string collect)
        eval $fish_commands
    end
end
