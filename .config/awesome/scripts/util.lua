local awful = require("awful")
local opt = require("config.options")

local M = {}

M.createKey = function(group, key)
  return awful.key({ opt.MOD, table.unpack(key[1]) }, key[2], key[3], { description = key[4], group = group })
end

M.createKeys = function (group, keys)
  local t = {}
  for _, key in ipairs(keys) do
    table.insert(t, M.createKey(group, key))
  end
  return t
end

return M
