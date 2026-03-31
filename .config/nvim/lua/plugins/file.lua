---@type LazySpec
return {
	{
		"Eutrius/Otree.nvim",
		lazy = false,
		dependencies = {
			"stevearc/oil.nvim",
		},
		---@module "Otree"
		opts = {
			git_signs = true,
		},
		keys = {
			{
				"<leader>x",
				mode = { "n" },
				function()
					if vim.bo.filetype == "Otree" then
						vim.cmd("Otree")
					else
						vim.cmd("OtreeFocus")
					end
				end,
				desc = "File Explorer",
			},
		},
		config = function(_, opts)
			require("Otree").setup(opts)

			Autocmd("BufWinEnter", {
				group = Augroup("OtreeSync"),
				callback = function()
					local bufname = vim.api.nvim_buf_get_name(0)

					if vim.bo.filetype ~= "Otree" and bufname ~= "" and vim.bo.buftype == "" then
						local otree_win = nil
						for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
							local buf = vim.api.nvim_win_get_buf(win)
							if vim.bo[buf].filetype == "Otree" then
								otree_win = win
								break
							end
						end

						if otree_win then
							vim.schedule(function()
								require("Otree.actions").focus_file()
								if vim.api.nvim_get_current_win() == otree_win then
									vim.cmd("wincmd p")
								end
							end)
						end
					end
				end,
			})
		end,
	},
}
