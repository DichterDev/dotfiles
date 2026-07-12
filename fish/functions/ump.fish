function ump
    # 1. Check for dependencies
    if not command -v fzf >/dev/null
        echo "Error: fzf is not installed."
        return 1
    end

    # 2. Get ONLY USB partitions (e.g., sdb1, sdc2)
    # Using -E (extended regex) to ensure we only catch names ending in a number
    set -l selection (lsblk -rno NAME,LABEL,SIZE,MOUNTPOINT | grep -E '^sd[a-z][0-9]' | fzf --header="Select Partition (Mount or Jump)" --height=10% --layout=reverse)

    if test -z "$selection"
        echo "No partition selected."
        return 1
    end

    # 3. Parse the selection
    set -l parts (string split -m 3 ' ' $selection)
    set -l target_dev $parts[1]
    set -l current_mount $parts[4]

    # 4. Failsafe: Check if already mounted
    if test -n "$current_mount"
        echo "Already mounted at $current_mount. Jumping..."
        cd "$current_mount"
    else
        # 5. Mount using udisksctl
        echo "Mounting /dev/$target_dev..."
        set -l mount_output (udisksctl mount -b /dev/$target_dev)

        if test $status -eq 0
            # Extract path and trim trailing period
            set -l mount_path (echo $mount_output | string split ' ')[-1]
            set mount_path (string trim -r -c '.' $mount_path)

            echo "Mounted at: $mount_path"
            cd "$mount_path"
        else
            echo "Mounting failed."
        end
    end
end
