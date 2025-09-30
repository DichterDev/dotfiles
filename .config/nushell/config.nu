$env.config.buffer_editor = "nvim"
$env.config.show_banner = false

source ($nu.config-path | path dirname | path join "alias.nu")

# STARSHIP
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
