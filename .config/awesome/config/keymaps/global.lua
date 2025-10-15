require("config.options")
require("config.keymaps.keys")

local awful = require("awful")

local function restore_client()
  local c = awful.client.restore()
  if c then c:activate({ raise = true, context = "key.unminimize" }) end
end


local function focus_prev()
  awful.client.focus.history.previous()
  if client.focus then client.focus:raise() end
end

local M = {
  awesome = {
    { {},        "s", require("awful.hotkeys_popup").show_help, "show help", },
    { { CTRL },  "r", awesome.restart,                          "reload awesome", },
    { { SHIFT }, "q", awesome.quit,                             "quit awesome", },
  },
  tag = {
    { {}, "Left",  awful.tag.viewprev, "view previous", },
    { {}, "Right", awful.tag.viewnext, "view next", },
  },
  client = {
    { {},        "j",   function() awful.client.focus.byidx(1) end,  "focus next by index", },
    { {},        "k",   function() awful.client.focus.byidx(-1) end, "focus previous by index", },
    { {},        "Tab", focus_prev,                                  "focus previous by history", },
    { { CTRL },  "n",   restore_client,                              "restore minimized" },
    { { SHIFT }, "j",   function() awful.client.swap.byidx(1) end,   "swap with next client by index", },
    { { SHIFT }, "k",   function() awful.client.swap.byidx(-1) end,  "swap with previous client by index", },
    { {},        "u",   awful.client.urgent.jumpto,                  "jump to urgent client", }
  },
  layout = {
    { {},        "l", function() awful.tag.incmwfact(0.05) end,           "increase master width factor", },
    { {},        "h", function() awful.tag.incmwfact(-0.05) end,          "decrease master width factor", },
    { { SHIFT }, "l", function() awful.tag.incnmaster(1, nil, true) end,  "increase number of master clients", },
    { { SHIFT }, "h", function() awful.tag.incnmaster(-1, nil, true) end, "decrease number of master clients", },
  },
  screen = {
    { { CTRL }, "j", function() awful.screen.focus_relative(1) end,  "focus the next screen" },
    { { CTRL }, "k", function() awful.screen.focus_relative(-1) end, "focus the previous screen", }
  },
  launcher = {
    { {}, SPACE,  function() awful.spawn(APP_LAUNCHER) end, "open app launcher" },
    { {}, RETURN, function() awful.spawn(TERM) end,         "open terminal" },
    { {}, "b",    function() awful.spawn(BROWSER) end,      "open browser" }
  },
}

return M
