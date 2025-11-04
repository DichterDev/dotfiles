local awful = require("awful")

local M = {}

local function options_builder(options)
  local s = ""
  for _, opt in ipairs(options) do
    s = s .. opt .. "\n"
  end
  return s
end

M.run = function(title, options, callback)
  local cmd = "rofi -show drun -p " .. title .. "-i"
  local opts = options_builder(options)

  awful.spawn.easy_async_with_shell(
    "echo -e '" .. opts .. "' | " .. cmd,
    function(choice)
      if choice and choice ~= "" then
        callback(choice)
      end
    end
  )
end

return M
