local wezterm = require('wezterm')

local M = {}

M.get_random_entry = function (t)
  local s = t[math.random(#t)]
  return s
end

return M
