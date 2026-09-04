vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,folds,terminal"

require("mini.sessions").setup({
	autowrite = true,
	directory = vim.fn.stdpath("data") .. "/session",
})

local get_session_name = function()
	local cwd = vim.fn.getcwd()
	local folder_name = vim.fn.fnamemodify(cwd, ":t")
	local hash = vim.fn.sha256(cwd):sub(1, 8)
	return string.format("%s-%s", folder_name, hash)
end

Autocmd("VimEnter", "mini-session", {
	callback = function()
		if vim.fn.argc() == 0 then
			local session_name = get_session_name()
			if MiniSessions.detected[session_name] then
				MiniSessions.read(session_name)
				vim.schedule(function()
					local buf = vim.api.nvim_get_current_buf()

					if vim.api.nvim_buf_line_count(buf) <= 15000 then
						vim.cmd("silent! doautocmd BufReadPost")
						vim.cmd("silent! doautocmd FileType")
						vim.cmd("silent! doautocmd ColorScheme")
					end
				end)
			end
		end
	end,
})

Usercmd("MkSession", function()
	local session_name = get_session_name()
	if not MiniSessions.detected[session_name] then
		MiniSessions.write(session_name)
	end
end, { desc = "Make Session" })

Map("n", "<leader>fs", MiniSessions.select, { desc = "[f]ind [s]ession" })
