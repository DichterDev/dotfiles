-- :: Catppuccin Macchiato AwesomeWM Theme (Solid) ::

local theme = {}

-- :: Font
-- From your kitty.conf
theme.font = "BlexMono Nerd Font Mono 10"

-- :: Colors (Catppuccin Macchiato)
-- From your .config/nushell/catppuccin.nu
local c = {
  rosewater = "#f4dbd6",
  flamingo = "#f0c6c6",
  pink = "#f5bde6",
  mauve = "#c6a0f6",
  red = "#ed8796",
  maroon = "#ee99a0",
  peach = "#f5a97f",
  yellow = "#eed49f",
  green = "#a6da95",
  teal = "#8bd5ca",
  sky = "#91d7e3",
  sapphire = "#7dc4e4",
  blue = "#8aadf4",
  lavender = "#b7bdf8",
  text = "#cad3f5",
  subtext1 = "#b8c0e0",
  subtext0 = "#a5adcb",
  overlay2 = "#939ab7",
  overlay1 = "#8087a2",
  overlay0 = "#6e738d",
  surface2 = "#5b6078",
  surface1 = "#494d64",
  surface0 = "#363a4f",
  base = "#24273a",
  mantle = "#1e2030",
  crust = "#181926",
}

-- :: Theme Variables
theme.fg_normal = c.text
theme.fg_focus = c.text
theme.fg_urgent = c.base
theme.fg_minimize = c.overlay0

theme.bg_normal = c.base
theme.bg_focus = c.surface1
theme.bg_urgent = c.red
theme.bg_minimize = c.surface0

theme.border_width = 2
theme.border_normal = c.surface0
theme.border_focus = c.blue
theme.border_marked = c.peach

-- :: Gaps
theme.useless_gap = 5

-- :: Wibar
theme.bg_systray = c.mantle
theme.wibar_bg = c.mantle
theme.wibar_height = 24

-- :: Taglist
theme.taglist_fg_normal = c.text
theme.taglist_bg_normal = c.mantle

theme.taglist_fg_focus = c.base
theme.taglist_bg_focus = c.blue

theme.taglist_fg_urgent = c.base
theme.taglist_bg_urgent = c.red

theme.taglist_fg_occupied = c.text
theme.taglist_bg_occupied = c.mantle

-- :: Tasklist (Middle widget)
theme.tasklist_fg_normal = c.text
theme.tasklist_bg_normal = c.mantle

theme.tasklist_fg_focus = c.base
theme.tasklist_bg_focus = c.blue

theme.tasklist_fg_urgent = c.base
theme.tasklist_bg_urgent = c.red

-- :: Titlebars (disabled in your rc.lua, but set just in case)
theme.titlebar_bg_focus = c.surface1
theme.titlebar_fg_focus = c.blue
theme.titlebar_bg_normal = c.base
theme.titlebar_fg_normal = c.text

-- :: Menu
theme.menu_bg_normal = c.mantle
theme.menu_fg_normal = c.text
theme.menu_bg_focus = c.surface1
theme.menu_fg_focus = c.blue
theme.menu_border_width = 1
theme.menu_border_color = c.surface0

return theme
