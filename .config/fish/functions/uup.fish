function uup
    set -l selection (lsblk -rno NAME,LABEL,SIZE,MOUNTPOINT | grep -E '^sd[a-z][0-9]' | grep /run/media | fzf --header="Select USB to Unmount")
    if test -z "$selection"
        return
    end
    set -l target_dev (string split ' ' $selection)[1]

    cd ~
    udisksctl unmount -b /dev/$target_dev
    udisksctl power-off -b /dev/$target_dev
end
