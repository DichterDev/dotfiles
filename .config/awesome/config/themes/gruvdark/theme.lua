-- :: GruvDark (Specific) AwesomeWM Theme (Solid) ::
-- Generated from your provided gruvdark.nvim palette

local theme = {}

-- :: Font
theme.font = "BlexMono Nerd Font Mono 10"

local c = {
  -- Base
  fg = "#D6CFC4",
  fg_light = "#E6E3DE",
  fg_search = "#E6E3DE",
  fg_search2 = "#212121",

  blue = "#579DD4",
  blue_dark = "#2A404F",
  red = "#E16464",
  red_dark = "#B55353",
  green = "#72BA62",
  pink = "#D159B6",
  purple = "#9266DA",
  aqua = "#00A596",
  orange = "#D19F66",
  grey = "#575757",
  grey_light = "#9D9A94",

  -- Background
  bg0 = "#1E1E1E",
  bg1 = "#232323",
  bg2 = "#252525",
  bg3 = "#303030",
  bg4 = "#323232",
  bg5 = "#373737",
  bg6 = "#3C3C3C",
  bg7 = "#424242",

  -- Extras
  none = "NONE",
  line_nr = "#545454",
  cursor_line = "#B1AFA8",

  diff_add = "#31392b",
  diff_delete = "#382b2c",
  diff_change = "#1c3448",
  diff_text = "#2c5372",
}


-- :: Theme Variables
theme.fg_normal = c.fg
theme.fg_focus = c.fg_light
theme.fg_urgent = c.fg_search2
theme.fg_minimize = c.grey_light

theme.bg_normal = c.bg0
theme.bg_focus = c.bg3
theme.bg_urgent = c.red
theme.bg_minimize = c.bg4

theme.border_width = 2
theme.border_normal = c.bg5
theme.border_focus = c.blue
theme.border_marked = c.orange

-- :: Gaps
theme.useless_gap = 5

-- :: Wibar
theme.bg_systray = c.bg1
theme.wibar_bg = c.bg1
theme.wibar_height = 24

-- :: Taglist
theme.taglist_fg_normal = c.grey_light
theme.taglist_bg_normal = c.bg1

theme.taglist_fg_focus = c.bg0
theme.taglist_bg_focus = c.blue

theme.taglist_fg_urgent = c.bg0
theme.taglist_bg_urgent = c.red

theme.taglist_fg_occupied = c.fg
theme.taglist_bg_occupied = c.bg1

-- :: Tasklist (Middle widget)
theme.tasklist_fg_normal = c.grey_light
theme.tasklist_bg_normal = c.bg1

theme.tasklist_fg_focus = c.fg
theme.tasklist_bg_focus = c.blue_dark

theme.tasklist_fg_urgent = c.bg0
theme.tasklist_bg_urgent = c.red

-- :: Titlebars (disabled in your rc.lua, but set just in case)
theme.titlebar_bg_focus = c.bg3
theme.titlebar_fg_focus = c.blue
theme.titlebar_bg_normal = c.bg0
theme.titlebar_fg_normal = c.grey_light

-- :: Menu
theme.menu_bg_normal = c.bg1
theme.menu_fg_normal = c.fg
theme.menu_bg_focus = c.bg3
theme.menu_fg_focus = c.blue
theme.menu_border_width = 1
theme.menu_border_color = c.bg5

return theme
