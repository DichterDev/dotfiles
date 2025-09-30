local awful = require("awful")
local lain = require("lain")

local M = {}

M.client = {
  {{}, "f", lain.util.magnify_client, "magnify client",},
  {{}, "q", function (c) c:kill() end, "close",},
}
