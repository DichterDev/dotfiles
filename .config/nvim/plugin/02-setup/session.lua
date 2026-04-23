local gh = require("util").pack.gh

vim.pack.add({ gh("nvim-mini/mini.nvim") })

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

vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("MiniSessionsAuto", { clear = true }),
	callback = function()
		vim.schedule(function()
			if vim.fn.argc() == 0 then
				local session_name = get_session_name()
				if MiniSessions.detected[session_name] then
					MiniSessions.read(session_name)
				else
					MiniSessions.write(session_name)
				end
			end
		end)
	end,
})

vim.keymap.set("n", "<leader>fs", MiniSessions.select, { desc = "[f]ind [s]ession" })
