local awful = require("awful")
local lain = require("lain")
dofile("config.keymaps.keys.lua")

local M = {}

M.client = {
  { {}, "f", lain.util.magnify_client,           "magnify client" },
  { {}, "q", function(c) c:kill() end,           "close client" },
  { {}, "n", function(c) c.minimized = true end, "minimize client" },
  { {}, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
  end, "toggle maximize client" },
}

return M
