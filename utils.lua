local d = require("directories")

local M = {}

M.export = function(c, t)
	M.clean(string.format("%s/%s", c, t))
	os.execute(string.format("/bin/cp -r ./%s %s", t, c))
	print(string.format("%s -> %s/", t, c))
end

M.clean = function(t)
	os.execute(string.format("/bin/rm -r %s", t))
end

M.import = function(c, t)
	M.clean(string.format("./%s", t))
	os.execute(string.format("/bin/cp -r %s/%s ./", c, t))
	print(string.format("%s/%s -> %s", c, t, t))
end

M.check_backup = function()
	local dir = "./.backup/export"
	local f = io.popen("/bin/ls " .. dir)
	local i = 0
	for _ in f:lines() do
		i = i + 1
	end
	if i > 1 then
		return true
	else
		return false
	end
end

M.backup = function()
	if M.check_backup() then
		return
	end
	local undo = "./.backup"
	M.clean(undo)
	os.execute(string.format("mkdir -p %s/import && mkdir -p %s/export", undo, undo))
	print("Backup in progess")
	for k, v in pairs(d) do
		for _, w in pairs(v) do
			local t = M.gen_path(k)
			os.execute(string.format("cp -r %s%s %s/import/", t, w, undo))
			os.execute(string.format("cp -r ./%s %s/export/", w, undo))
		end
	end
	print("Backup finished")
end

M.gen_path = function(t)
	if t == "home" then
		return "~/"
	elseif t == "config" then
		return "~/.config/"
	end
end

M.iter_dir = function(f)
	for k, v in pairs(d) do
		for i, _ in pairs(v) do
			f(k, v[i])
		end
	end
end

M.check = function(t)
	for _, v in pairs(d) do
		for i in pairs(v) do
			if t == v[i] then
				return true
			end
		end
	end
	return false
end

M.get_path = function(t)
	for k, v in pairs(d) do
		for _, w in pairs(v) do
			if t == w then
				return k
			end
		end
	end
end

M.check_args = function(arg)
	if arg[1] then
		return true
	end
	return false
end

M.handle_args = function(arg, f)
	for k, v in pairs(arg) do
		if k <= 0 then
			goto continue
		end
		if not M.check(v) then
			print(string.format("%s not found in config", v))
			goto continue
		end

		local c = M.get_path(v)
		f(c, v)
		::continue::
	end
end

return M
