local wezterm = require("wezterm")
local w = require("utils/wallpaper")

local config = wezterm.config_builder()

-- color scheme
config.color_scheme = "Catppuccin Macchiato"
config.audible_bell = "Disabled"
config.tab_bar_at_bottom = true

-- Background wallpaper
config.background = {
	w.get_wallpaper(),
}

-- and finally, return the configuration to wezterm
return config
