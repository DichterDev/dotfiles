local awful = require("awful")
local gears = require("gears")
local rofi = require("config.scripts.rofi")
local naughty = require("naughty")

local async = awful.spawn.easy_async_with_shell

local options = {
  "Mirror",
  "Extend Left",
  "Extend Right",
  "Disconnect",
}

local M = {}

local function parse_xrandr(stdout)
  local t = {}
  for line in stdout:gmatch("([^\n]+)") do
    if line:match(" connected") then
      local d = line:match("^([^%s]+)")
      table.insert(t, d)
    end
  end
  return t
end

local function apply_layout(choice, source, target)
  local cmd = "xrandr --output " .. source .. " --auto"

  if choice == options[1] then
    cmd = cmd .. " --output " .. target .. " --auto --same-as " .. source
  elseif choice == options[2] then
    cmd = cmd .. " --output " .. target .. " --left-of " .. source
  elseif choice == options[3] then
    cmd = cmd .. " --output " .. target .. " --right-of " .. source
  elseif choice == options[4] then
    cmd = cmd .. " --off"
  end

  if cmd ~= "" then
    naughty.notify({
      title = "Display Select",
      text = cmd
    })
    awful.spawn.with_shell(cmd)
    gears.timer.start_new(1, function()
      awesome.restart()
      return false
    end)
  end
end

M.run = function()
  local displays = nil

  async(
    "xrandr --query",
    function(stdout)
      displays = parse_xrandr(stdout)

      rofi.run("Select Source", displays, function(source)
        rofi.run("Select Option", options, function(opt)
          if opt == options[4] then
            apply_layout(opt, source, {})
            return
          end
          rofi.run("Select Target", displays, function(target)
            apply_layout(opt, source, target)
          end)
        end)
      end)
    end
  )
end

return M
