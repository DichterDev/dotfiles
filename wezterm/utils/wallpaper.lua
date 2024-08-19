local wezterm = require('wezterm')
local h = require('utils/helpers')

local M = {}

M.get_wallpaper = function ()
  local wallpapers = {}

  for _, v in ipairs(wezterm.glob('/home/dichter/.config/wezterm/background/*')) do
    table.insert(wallpapers, v)
  end

  local wallpaper = wallpapers[math.random(#wallpapers)]
  return {
    source = { File = wallpaper },
  }
end

return M
