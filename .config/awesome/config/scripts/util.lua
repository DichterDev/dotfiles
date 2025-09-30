require("config.keymaps.keys")
local awful = require("awful")

local M = {}

M.createKey = function (group, key)
  return awful.key({ SUPER, table.unpack(key[1]) }, key[2], key[3], { description = key[4], group = group })
end

M.createKeys = function (group, keys)
  local t = {}
  for _, key in ipairs(keys) do
    table.insert(t, M.createKey(group, key))
  end
  return t
end

M.addKeys = function (tbl)
  local t = {}
  for group, keys in pairs(tbl) do
    table.insert(t, M.createKeys(group, keys))
  end
  return t
end

return M
