---@type LazySpec
return {
	"ibhagwan/fzf-lua",
	dependencies = { "echasnovski/mini.icons" },
	---@module "fzf-lua"
	---@type fzf-lua.Config|{}
	---@diagnostic disable: missing-fields
	opts = {
		file_ignore_patterns = {
			"node_modules/.*",
			"build/.*",
			"bin/.*",
			"target/.*",
		},
	},
	---@diagnostic enable: missing-fields
	config = function(_, opts)
		local fzf = require("fzf-lua")
		fzf.setup(opts)

		fzf.register_ui_select()

		Map("n", "<leader>ff", fzf.files, { desc = "[f]ind [f]iles" })
		Map("n", "<leader>fg", fzf.git_files, { desc = "[f] [g]it files" })
		Map("n", "<leader>fr", fzf.live_grep, { desc = "[f]ind [r]ipgrep" })
		Map("n", "<leader>fb", fzf.buffers, { desc = "[f]ind [b]uffers" })
		Map("n", "<leader>fo", fzf.oldfiles, { desc = "[f]ind [o]ldfiles" })
		Map("n", "<leader>fq", fzf.lgrep_quickfix, { desc = "[f]ind [q]ickfix" })
		Map("n", "<leader>fh", fzf.quickfix_stack, { desc = "[f]ind [h]istory" })
		Map("n", "<leader>fk", fzf.keymaps, { desc = "[f]ind [k]eymaps" })
		Map("n", "/", fzf.blines, { desc = "Search" })
		Map("n", "<leader>ft", fzf.tags_live_grep, { desc = "[f]ind [t]ags" })
	end,
}
