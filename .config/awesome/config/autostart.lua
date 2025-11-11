local awful = require("awful")

awful.spawn.with_shell("picom")
awful.spawn.with_shell("xinput set-prop 12 'libinput Tapping Enabled' 1")
