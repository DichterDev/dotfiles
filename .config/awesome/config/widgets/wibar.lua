require("config.bindings.keys")
local awful = require("awful")
local wibox = require("wibox")

local keyboardlayout = awful.widget.keyboardlayout()
local textclock = wibox.widget.textclock()

local function tag_filter(t)
  if t.index <= 3 then
    return true
  end
  return t.occupied or t.selected
end

screen.connect_signal("request::desktop_decoration", function(s)
  awful.tag({ "dev", "web", "misc", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

  s.promptbox = awful.widget.prompt()

  s.layoutbox = awful.widget.layoutbox {
    screen  = s,
    buttons = {
      awful.button({}, 1, function() awful.layout.inc(1) end),
      awful.button({}, 3, function() awful.layout.inc(-1) end),
      awful.button({}, 4, function() awful.layout.inc(-1) end),
      awful.button({}, 5, function() awful.layout.inc(1) end),
    }
  }

  s.taglist = awful.widget.taglist {
    screen  = s,
    filter  = tag_filter,
    buttons = {
      awful.button({}, 1, function(t) t:view_only() end),
      awful.button({ SUPER }, 1, function(t)
        if client.focus then
          client.focus:move_to_tag(t)
        end
      end),
      awful.button({}, 3, awful.tag.viewtoggle),
      awful.button({ SUPER }, 3, function(t)
        if client.focus then
          client.focus:toggle_tag(t)
        end
      end),
      awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
      awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end),
    }
  }

  s.tasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = {
      awful.button({}, 1, function(c)
        c:activate { context = "tasklist", action = "toggle_minimization" }
      end),
      awful.button({}, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
      awful.button({}, 4, function() awful.client.focus.byidx(-1) end),
      awful.button({}, 5, function() awful.client.focus.byidx(1) end),
    }
  }

  s.wibox = awful.wibar {
    position = "top",
    screen   = s,
    widget   = {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        launcher,
        s.taglist,
        s.promptbox,
      },
      s.tasklist, -- Middle widget
      {           -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        keyboardlayout,
        wibox.widget.systray(),
        textclock,
        s.layoutbox,
      },
    }
  }
end)
