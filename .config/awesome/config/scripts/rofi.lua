local awful = require("awful")

local M = {}

M.run = function(prompt, options, callback)
  local options_str = table.concat(options, "\n")
  local rofi_cmd = "rofi -dmenu -p '" .. prompt .. "' -i"

  awful.spawn.easy_async_with_shell(
    "echo -e '" .. options_str .. "' | " .. rofi_cmd,
    function(choice)
      if choice and choice ~= "" then
        callback(choice:gsub("[\n\r]$", ""))
      end
    end
  )
end

return M
