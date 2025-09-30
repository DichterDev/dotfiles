# CATPPUCCIN
source ./catppuccin.nu

# ALIASES
source ./alias.nu

$env.config.buffer_editor = "nvim"
$env.config.show_banner = false

# STARSHIP
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
