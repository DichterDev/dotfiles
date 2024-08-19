-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Catppuccin Macchiato'
config.audible_bell = 'Disabled'
config.tab_bar_at_bottom = true

-- Background wallpaper
config.background = {
  {
    source = {
      File = '/home/dichter/Pictures/term/JByY6XQ.png',
    },
  }
}

-- and finally, return the configuration to wezterm
return config
