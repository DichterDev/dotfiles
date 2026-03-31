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
			focus_on_enter = true,
			git_signs = true,
			keymaps = {
				["q"] = "actions.close_win",
			},
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
						require("Otree.actions").focus_file()
					end
				end,
				desc = "File Explorer",
			},
		},
		config = function(_, opts)
			require("Otree").setup(opts)

			Autocmd("BufEnter", {
				group = Augroup("sync_Otree"),
				callback = function()
					local bufname = vim.api.nvim_buf_get_name(0)
					if vim.bo.filetype ~= "Otree" and vim.bo.buftype == "" and bufname ~= "" then
						pcall(function()
							require("Otree.actions").focus_file()
						end)
					end
				end,
			})
		end,
	},
}
