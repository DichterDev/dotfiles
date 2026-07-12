function ti --description "Tmux Interactive Window Switcher (Recency Sorted)"
    if not set -q TMUX
        echo "You must be inside a running Tmux session to switch windows!"
        return 1
    end

    set -l current_window (tmux display-message -p '#I')

    set -l raw_windows (tmux list-windows -F "#I: #W")

    set -l last_window (tmux display-message -t '-' -p '#I' 2>/dev/null)

    set -l target (begin
        if test -n "$last_window"; and test "$last_window" != "$current_window"
            tmux list-windows -F "#I: #W" | grep "^$last_window:"
        end

        for line in $raw_windows
            set -l idx (echo "$line" | cut -d: -f1)
            if test "$idx" != "$current_window"; and test "$idx" != "$last_window"
                echo "$line"
            end
        end

        tmux list-windows -F "#I: #W (active)" | grep "^$current_window:"
    end | fzf --reverse --height=40% --border=rounded \
            --prompt="󰖲  Windows » " \
            --header="Jump to Pane Layout Tab" | \
        cut -d: -f1)

    if test -n "$target"
        tmux select-window -t "$target"
    end
end
