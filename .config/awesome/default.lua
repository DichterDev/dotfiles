pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification {
    urgency = "critical",
    title   = "Oops, an error happened" .. (startup and " during startup!" or "!"),
    message = message
  }
end)

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- TODO: needs replacement
-- myawesomemenu = {
--   { "hotkeys",     function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
--   { "manual",      terminal .. " -e man awesome" },
--   { "edit config", editor_cmd .. " " .. awesome.conffile },
--   { "restart",     awesome.restart },
--   { "quit",        function() awesome.quit() end },
-- }
--
-- mymainmenu = awful.menu({
--   items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
--     { "open terminal", terminal }
--   }
-- })
--
-- mylauncher = awful.widget.launcher({
--   image = beautiful.awesome_icon,
--   menu = mymainmenu
-- })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

tag.connect_signal("request::default_layouts", function()
  awful.layout.append_default_layouts({
    awful.layout.suit.tile,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
  })
end)

screen.connect_signal("request::wallpaper", function(s)
  awful.wallpaper {
    screen = s,
    widget = {
      {
        image     = beautiful.wallpaper,
        upscale   = true,
        downscale = true,
        widget    = wibox.widget.imagebox,
      },
      valign = "center",
      halign = "center",
      tiled  = false,
      widget = wibox.container.tile,
    }
  }
end)

-- TODO: #theme
-- mykeyboardlayout = awful.widget.keyboardlayout()
-- mytextclock = wibox.widget.textclock()

-- TODO: #theme
-- screen.connect_signal("request::desktop_decoration", function(s)
--   awful.tag({ "dev", "web", "misc" }, s, awful.layout.layouts[1])
--
--   -- TODO: replace with dmenu
--   s.mypromptbox = awful.widget.prompt()
--
--   s.mylayoutbox = awful.widget.layoutbox {
--     screen  = s,
--     buttons = {
--       awful.button({}, 1, function() awful.layout.inc(1) end),
--       awful.button({}, 3, function() awful.layout.inc(-1) end),
--       awful.button({}, 4, function() awful.layout.inc(-1) end),
--       awful.button({}, 5, function() awful.layout.inc(1) end),
--     }
--   }
--
--   -- Create a taglist widget
--   s.mytaglist = awful.widget.taglist {
--     screen  = s,
--     filter  = awful.widget.taglist.filter.all,
--     buttons = {
--       awful.button({}, 1, function(t) t:view_only() end),
--       awful.button({ modkey }, 1, function(t)
--         if client.focus then
--           client.focus:move_to_tag(t)
--         end
--       end),
--       awful.button({}, 3, awful.tag.viewtoggle),
--       awful.button({ modkey }, 3, function(t)
--         if client.focus then
--           client.focus:toggle_tag(t)
--         end
--       end),
--       awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
--       awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end),
--     }
--   }
--
--   s.mytasklist = awful.widget.tasklist {
--     screen  = s,
--     filter  = awful.widget.tasklist.filter.currenttags,
--     buttons = {
--       awful.button({}, 1, function(c)
--         c:activate { context = "tasklist", action = "toggle_minimization" }
--       end),
--       awful.button({}, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
--       awful.button({}, 4, function() awful.client.focus.byidx(-1) end),
--       awful.button({}, 5, function() awful.client.focus.byidx(1) end),
--     }
--   }
--
--   -- Create the wibox
--   s.mywibox = awful.wibar {
--     position = "top",
--     screen   = s,
--     widget   = {
--       layout = wibox.layout.align.horizontal,
--       { -- Left widgets
--         layout = wibox.layout.fixed.horizontal,
--         mylauncher,
--         s.mytaglist,
--         s.mypromptbox,
--       },
--       s.mytasklist, -- Middle widget
--       {             -- Right widgets
--         layout = wibox.layout.fixed.horizontal,
--         mykeyboardlayout,
--         wibox.widget.systray(),
--         mytextclock,
--         s.mylayoutbox,
--       },
--     }
--   }
-- end)

awful.mouse.append_global_mousebindings({
  awful.button({}, 3, function() mymainmenu:toggle() end),
  awful.button({}, 4, awful.tag.viewprev),
  awful.button({}, 5, awful.tag.viewnext),
})

-- TODO: move to signals
-- client.connect_signal("request::default_mousebindings", function()
--   awful.mouse.append_client_mousebindings({
--     awful.button({}, 1, function(c)
--       c:activate { context = "mouse_click" }
--     end),
--     awful.button({ modkey }, 1, function(c)
--       c:activate { context = "mouse_click", action = "mouse_move" }
--     end),
--     awful.button({ modkey }, 3, function(c)
--       c:activate { context = "mouse_click", action = "mouse_resize" }
--     end),
--   })
-- end)

-- {{{ Rules
-- Rules to apply to new clients.
-- @DOC_RULES@
ruled.client.connect_signal("request::rules", function()
  -- @DOC_GLOBAL_RULE@
  -- All clients will match this rule.
  ruled.client.append_rule {
    id         = "global",
    rule       = {},
    properties = {
      focus     = awful.client.focus.filter,
      raise     = true,
      screen    = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
  }

  -- @DOC_FLOATING_RULE@
  -- Floating clients.
  ruled.client.append_rule {
    id         = "floating",
    rule_any   = {
      instance = { "copyq", "pinentry" },
      class    = {
        "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
        "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
      },
      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name     = {
        "Event Tester", -- xev.
      },
      role     = {
        "AlarmWindow",   -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up",        -- e.g. Google Chrome's (detached) Developer Tools.
      }
    },
    properties = { floating = true }
  }

  -- @DOC_DIALOG_RULE@
  -- Add titlebars to normal clients and dialogs
  ruled.client.append_rule {
    -- @DOC_CSD_TITLEBARS@
    id         = "titlebars",
    rule_any   = { type = { "normal", "dialog" } },
    properties = { titlebars_enabled = true }
  }

  -- Set Firefox to always map on the tag named "2" on screen 1.
  -- ruled.client.append_rule {
  --     rule       = { class = "Firefox"     },
  --     properties = { screen = 1, tag = "2" }
  -- }
end)
-- }}}

client.connect_signal("request::titlebars", function(c)
  local buttons = {
    awful.button({}, 1, function()
      c:activate { context = "titlebar", action = "mouse_move" }
    end),
    awful.button({}, 3, function()
      c:activate { context = "titlebar", action = "mouse_resize" }
    end),
  }

  awful.titlebar(c).widget = {
    { -- Left
      awful.titlebar.widget.iconwidget(c),
      buttons = buttons,
      layout  = wibox.layout.fixed.horizontal
    },
    {   -- Middle
      { -- Title
        halign = "center",
        widget = awful.titlebar.widget.titlewidget(c)
      },
      buttons = buttons,
      layout  = wibox.layout.flex.horizontal
    },
    { -- Right
      awful.titlebar.widget.floatingbutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.stickybutton(c),
      awful.titlebar.widget.ontopbutton(c),
      awful.titlebar.widget.closebutton(c),
      layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal
  }
end)

-- {{{ Notifications

ruled.notification.connect_signal('request::rules', function()
  -- All notifications will match this rule.
  ruled.notification.append_rule {
    rule       = {},
    properties = {
      screen           = awful.screen.preferred,
      implicit_timeout = 5,
    }
  }
end)

naughty.connect_signal("request::display", function(n)
  naughty.layout.box { notification = n }
end)

-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:activate { context = "mouse_enter", raise = false }
end)
