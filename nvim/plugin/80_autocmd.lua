vim.api.nvim_create_autocmd("BufReadPre", {
	pattern = "*",
	callback = function(ev)
		local max_size = 20 * 1024 * 1024
		local file = ev.file
		local ok, stats = pcall(vim.uv.fs_stat, file)

		if ok and stats and stats.size > max_size then
			local size_mb = string.format("%.2f", stats.size / (1024 * 1024))
			local prompt_msg = string.format("File is large (%s MB). Load anyway?", size_mb)

			local choice = vim.fn.confirm(prompt_msg, "&Yes\n&No", 2)

			if choice ~= 1 then
				vim.notify("Loading aborted for large file.", vim.log.levels.WARN, { title = "File Size Limit" })
				vim.cmd("bd!")
			end
		end
	end,
})
