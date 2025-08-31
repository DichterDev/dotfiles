local awful = require("awful")

local util = require("scripts.util")
local opt = require("config.options")

local keymap = {}

keymap.awesome = {
  {{}, "s", require("awful.hotkeys_popup").show_help "show help",},
  {{ opt.CTRL }, "r", awesome.restart, "reload awesome",},
  {{ opt.SHIFT }, "q", awesome.quit, "quit awesome",},
  {{}, "Return", function () awful.spawn(opt.TERM) end, "open a terminal"},
}

keymap.tag = {
  {{}, "Left", awful.tag.viewprev, "view previous",},
  {{}, "Right", awful.tag.viewnext, "view next",},
}

keymap.client = {
  {{}, "j", function () awful.client.focus.byidx(1) end, "focus next by index",},
  {{}, "k", function () awful.client.focus.byidx(-1) end, "focus previous by index",},
  {{}, "Tab", function () awful.client.focus.history.previous() if client.focus then client.focus:raise() end end, "go back",},
  {{ opt.CTRL }, "n", function () local c = awful.client.restore() if c then c:activate({ raise = true, context = "key.unminimize" }) end end, "restore minimized"},
  {{ opt.SHIFT }, "j", function () awful.client.swap.byidx(1) end, "swap with next client by index",},
  {{ opt.SHIFT }, "k", function () awful.client.swap.byidx(-1) end, "swap with previous client by index",},
  {{}, "u", awful.client.urgent.jumpto, "jump to urgent client",}
}

keymap.layout = {
  {{}, "l", function () awful.tag.incmwfact(0.05) end, "increase master width factor",},
  {{}, "h", function () awful.tag.incmwfact(-0.05) end, "decrease master width factor",},
  {{ opt.SHIFT }, "l", function () awful.tag.incnmaster(1, nil, true) end, "increase number of master clients",},
  {{ opt.SHIFT }, "h", function () awful.tag.incnmaster(-1, nil, true) end, "decrease number of master clients",},
}

keymap.screen = {
  {{ opt.CTRL }, "j", function () awful.screen.focus_relative(1) end, "focus the next screen"},
  {{ opt.CTRL }, "k", function () awful.screen.focus_relative(-1) end, "focus the previous screen",}
}

local bindings = {}

for group, keys in pairs(keymap) do
  table.insert(bindings, util.createKeys(group, keys))
end

awful.keyboard.append_global_keybindings(bindings)
