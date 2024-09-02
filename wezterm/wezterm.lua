local wezterm = require("wezterm")
local w = require("utils/wallpaper")

local config = wezterm.config_builder()

-- color scheme
config.color_scheme = "Catppuccin Macchiato"
config.audible_bell = "Disabled"
config.tab_bar_at_bottom = true
config.enable_tab_bar = false

config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

-- Font configuration
config.font = wezterm.font("IBM Plex Mono")
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"

config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"

-- Background wallpaper
config.background = {
	w.get_wallpaper(),
}

config.colors = {
	background = "rgba(0, 0, 0, 1)",
	foreground = "rgba(255, 255, 255, 0.5)",
}

-- and finally, return the configuration to wezterm
return config
