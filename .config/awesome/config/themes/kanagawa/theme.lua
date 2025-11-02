-- :: Kanagawa AwesomeWM Theme ::

local theme = {}

-- :: Font
theme.font = "BlexMono Nerd Font Mono 10"

-- :: Colors (Kanagawa Palette)
local c = {
  sumiInk1 = "#1F1F28",    -- Default Background
  sumiInk3 = "#363646",    -- Lighter Background (Cursorline)
  sumiInk4 = "#54546D",    -- Darker Foreground (Line numbers, borders)
  fujiWhite = "#DCD7BA",   -- Default Foreground
  waveBlue1 = "#223249",   -- Visual selection background
  crystalBlue = "#7E9CD8", -- Functions and Titles
  springGreen = "#98BB6C", -- Strings
  samuraiRed = "#E82424",  -- Diagnostic Error
  roninYellow = "#FF9E3B", -- Diagnostic Warning
  waveAqua1 = "#6A9589",   -- Diagnostic Info
}

-- :: Theme Variables
theme.fg_normal = c.fujiWhite
theme.fg_focus = c.fujiWhite
theme.fg_urgent = c.fujiWhite
theme.fg_minimize = c.sumiInk4

theme.bg_normal = c.sumiInk1
theme.bg_focus = c.waveAqua1 -- Use selection bg for focused window
theme.bg_urgent = c.samuraiRed
theme.bg_minimize = c.sumiInk3

theme.border_width = 2
theme.border_normal = c.sumiInk4
theme.border_focus = c.waveAqua1
theme.border_marked = c.roninYellow

-- :: Gaps
theme.useless_gap = 5

-- :: Taglist
theme.taglist_fg_normal = c.fujiWhite
theme.taglist_bg_normal = c.sumiInk1

theme.taglist_fg_focus = c.sumiInk1
theme.taglist_bg_focus = c.waveAqua1

theme.taglist_fg_urgent = c.sumiInk1
theme.taglist_bg_urgent = c.samuraiRed

theme.taglist_fg_occupied = c.fujiWhite
theme.taglist_bg_occupied = c.sumiInk1

-- :: Tasklist (Middle widget)
theme.tasklist_fg_normal = c.fujiWhite
theme.tasklist_bg_normal = c.sumiInk1

theme.tasklist_fg_focus = c.sumiInk1
theme.tasklist_bg_focus = c.waveAqua1

theme.tasklist_fg_urgent = c.sumiInk1
theme.tasklist_bg_urgent = c.samuraiRed

-- :: Wibar
theme.bg_systray = theme.bg_normal
theme.wibar_bg = theme.bg_normal
theme.wibar_height = 24

-- :: Titlebars
theme.titlebar_bg_focus = theme.bg_focus
theme.titlebar_fg_focus = theme.fg_focus
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_normal = theme.fg_normal

-- :: Menu
theme.menu_bg_normal = theme.bg_normal
theme.menu_fg_normal = theme.fg_normal
theme.menu_bg_focus = theme.bg_focus
theme.menu_fg_focus = theme.fg_focus
theme.menu_border_width = 1
theme.menu_border_color = theme.border_normal

-- :: Icons
-- (You can set paths to Kanagawa-themed icons here if you have them)
-- theme.layout_fairh = "/path/to/icons/fairh.png"
-- ...

return theme
