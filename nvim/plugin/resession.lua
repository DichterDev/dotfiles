local resession = require("resession")

resession.setup({
	autosave = {
		enabled = true,
		interval = 60,
		notify = false,
	},
	buf_filter = function(bufnr)
		local filename = vim.api.nvim_buf_get_name(bufnr)
		if filename == "" then
			return true
		end

		local max_size = 15 * 1024 * 1024
		local ok, stats = pcall(vim.uv.fs_stat, filename)

		if ok and stats and stats.size > max_size then
			local size_mb = string.format("%.2f", stats.size / (1024 * 1024))
			vim.notify(
				string.format("Resession: Skipped large file '%s' (%s MB)", vim.fs.basename(filename), size_mb),
				vim.log.levels.WARN,
				{ title = "Resession File Limit" }
			)
			return false
		end

		return resession.default_buf_filter(bufnr)
	end,
})

local function get_session_name()
	local name = vim.fn.getcwd()
	local branch = vim.trim(vim.fn.system("git branch --show-current"))
	if vim.v.shell_error == 0 then
		return name .. branch
	else
		return name
	end
end
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc(-1) == 0 then
			resession.load(get_session_name(), { dir = "dirsession", silence_errors = true })

			vim.schedule(function()
				local buf = vim.api.nvim_get_current_buf()

				if vim.api.nvim_buf_line_count(buf) <= 15000 then
					vim.cmd("silent! doautocmd BufReadPost")
					vim.cmd("silent! doautocmd FileType")
					vim.cmd("silent! doautocmd ColorScheme")
				end
			end)
		end
	end,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		resession.save(get_session_name(), { dir = "dirsession", notify = false })
	end,
})

vim.api.nvim_create_user_command("MkSession", function()
	resession.save()
end, {})
