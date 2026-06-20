# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# if [ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
#     eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# fi

run_if_exists() {
    local target_path="$1"
    shift # Removes the path from the argument list, leaving only the command
    local callback=("$@") # Captures the rest of the arguments as a safe array

    if [ -f "$target_path" ] || [ -x "$target_path" ]; then
        "${callback[@]}" "$target_path"
    fi
}

export GTK_THEME_VARIANT=dark
export MOZ_ENABLE_WAYLAND=1

# export ROS_DOMAIN_ID=30
# export TURTLEBOT3_MODEL=waffle_pi

# run_if_exists "/opt/ros/humble/setup.bash" source
# run_if_exists "/usr/share/gazebo/setup.sh" source
# run_if_exists "$HOME/FHV/sem04/software-architecture/exercises/ros/install/setup.bash" source

if [ -t 1 ]; then
    if command -v fish >/dev/null 2>&1; then
        exec fish
    fi
fi

