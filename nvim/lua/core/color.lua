local M = {}

---@class core.color.Opts
---@field path? string
---@field fallback? string

M.config = {
	path = vim.fn.stdpath("state") .. "/color",
	fallback = "default",
}

---@param opts? core.color.Opts
function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})

	M.load()

	local group = vim.api.nvim_create_augroup("PersistColorScheme", { clear = true })
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = group,
		callback = function()
			vim.schedule(M.save)
		end,
	})
end

function M.save()
	local scheme = vim.g.colors_name
	local bg = vim.o.background
	if not scheme then
		return
	end

	local uv = vim.uv or vim.loop
	local fd = uv.fs_open(M.config.path, "w", 438)
	if fd then
		local content = string.format("%s:%s\n", scheme, bg)
		uv.fs_write(fd, content)
		uv.fs_close(fd)
	end
end

function M.load()
	local fallback = M.config.fallback or "default"

	local uv = vim.uv or vim.loop
	local fd = uv.fs_open(M.config.path, "r", 438)

	local target_scheme = fallback
	local target_bg = nil

	if fd then
		local stat = uv.fs_fstat(fd)
		if stat and stat.size > 0 then
			local data = uv.fs_read(fd, stat.size)
			if data then
				local line = vim.trim(data)
				local parts = vim.split(line, ":")
				target_scheme = parts[1]
				target_bg = parts[2]
			end
		end
		uv.fs_close(fd)
	end

	if target_bg and (target_bg == "dark" or target_bg == "light") then
		vim.o.background = target_bg
	end

	local ok, _ = pcall(vim.cmd.colorscheme, target_scheme)
	if not ok and target_scheme ~= fallback then
		pcall(vim.cmd.colorscheme, fallback)
	end
end

return M
