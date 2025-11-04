local awful = require("awful")
local gears = require("gears")
local rofi = require("config.scripts.rofi")

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
  local cmd = "xrandr --ouput " .. source " --auto"
  choice = choice:gsub("[\n\r]$", "")

  if choice == options[1] then
    cmd = cmd .. "--output " .. target .. "--same-as " .. source
  elseif choice == options[2] then
    cmd = cmd .. "--output " .. target .. "--left-of " .. source
  elseif choice == options[3] then
    cmd = cmd .. "--output " .. target .. "--right-of " .. source
  elseif choice == options[4] then
    cmd = cmd .. "--output " .. target .. "--off"
  end

  if cmd ~= "" then
    awful.spawn.with_shell(cmd)
    gears.timer.start_new(1, function()
      awesome.restart()
      return false
    end)
  end
end

M.run = function()
  local source = nil
  local target = nil

  local function set_source(display) source = display end
  local function set_target(display) source = display end

  rofi.run("Select Source", options, set_source)
end

return M
