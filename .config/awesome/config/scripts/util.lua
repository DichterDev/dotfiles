local awful = require("awful")
local unpack = table.unpack
local insert = table.insert

local M = {}

M.keys = {
  create = function(group, key)
    local k = awful.key({ SUPER, unpack(key[1]) }, key[2], key[3], { description = key[4], group = group })
    return k
  end,
  generate = function(tbl)
    local t = {}
    for group, keys in pairs(tbl) do
      for _, key in ipairs(keys) do
        local k = M.keys.create(group, key)
        insert(t, k)
      end
    end
    return t
  end
}

return M
