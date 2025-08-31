local awful = require("awful")

local keymap = {}
local opt = require("config.options")

keymap.client = {
  {
    {},
    "f",
    function (c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    "toggle fullscreen"
  },
  {
    {},
    "q",
    function (c)
      c:kill()
    end,
    "close",
  },
  {
    { opt.CTRL },
    opt.SPACE,
    awful.client.floating.toggle,
    "toggle floating",
  },
}
