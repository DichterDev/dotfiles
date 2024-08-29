--  _____ __  __ _____   ____  _____ _______
-- |_   _|  \/  |  __ \ / __ \|  __ \__   __|
--   | | | \  / | |__) | |  | | |__) | | |
--   | | | |\/| |  ___/| |  | |  _  /  | |
--  _| |_| |  | | |    | |__| | | \ \  | |
-- |_____|_|  |_|_|     \____/|_|  \_\ |_|

local u = require("utils")

u.backup()

if u.check_args(arg) then
	u.handle_args(arg, u.import)
else
	u.iter_dir(u.import)
end
