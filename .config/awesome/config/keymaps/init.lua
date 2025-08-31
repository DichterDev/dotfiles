-- init keymaps
local global = require("config.keymaps.global")
local util = require("scripts.util")
local awful = require("awful")

local bindings = {}

for group, keys in pairs(global) do
  table.insert(bindings, util.createKeys(group, keys))
end

awful.keyboard.append_global_keybindings(bindings)
