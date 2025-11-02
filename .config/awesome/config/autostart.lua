local awful = require("awful")

awful.spawn.once("picom")
awful.spawn.once("xinput set-prop 12 'libinput Tapping Enabled' 1")
