--  ________   _______   ____  _____ _______
-- |  ____\ \ / /  __ \ / __ \|  __ \__   __|
-- | |__   \ V /| |__) | |  | | |__) | | |
-- |  __|   > < |  ___/| |  | |  _  /  | |
-- | |____ / . \| |    | |__| | | \ \  | |
-- |______/_/ \_\_|     \____/|_|  \_\ |_|

local u = require("utils")

u.backup()

if u.check_args(arg) then
	u.handle_args(arg, u.export)
else
	u.iter_dir(u.export)
end
