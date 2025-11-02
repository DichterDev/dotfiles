local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")

local editor_cmd = TERM .. "-e" .. EDITOR

awesomemenu = {
  { "hotkeys",     function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "manual",      TERM .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart",     awesome.restart },
  { "quit",        function() awesome.quit() end },
}

mainmenu = awful.menu({
  items = {
    { "awesome",       awesomemenu, beautiful.awesome_icon },
    { "open terminal", TERM }
  }
})

launcher = awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = mainmenu
})
