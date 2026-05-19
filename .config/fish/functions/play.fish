function play --description 'Query and play mp4/mkv files recursively using fd, fzf, and mpv'
    set -l selected_files (fd -e mp4 -e mkv | fzf --multi --prompt="Select videos (TAB to multi-select, Enter to play): ")

    if test -n "$selected_files[1]"
        echo "Playing selected files in order..."
        mpv -- $selected_files
    else
        echo "No files selected."
    end
end
