local gh = require("util").pack.gh

-- vim.pack.add({ gh("nvim-mini/mini.nvim") })
--
-- require("mini.pick").setup({ use_icons = true })
--
-- vim.keymap.set("n", "<leader>ff", ":lua MiniPick.builtin.files()<CR>", { desc = "[f]ind [f]iles" })
-- vim.api.nvim_set_hl(0, "MiniPickBorder", { bg = "none" })
-- vim.api.nvim_set_hl(0, "MiniPickBorderBusy", { bg = "none" })
-- vim.api.nvim_set_hl(0, "MiniPickBorderText", { bg = "none" }) vim.api.nvim_set_hl(0, "MiniPickNormal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "MiniPickPrompt", { bg = "none" })
-- vim.api.nvim_set_hl(0, "MiniPickPromptCaret", { bg = "none" })
-- vim.api.nvim_set_hl(0, "MiniPickPromptPrefix", { bg = "none" })

vim.pack.add({ gh("ibhagwan/fzf-lua"), gh("nvim-mini/mini.icons") })

local fzf = require("fzf-lua")
fzf.setup({
	file_ignore_patterns = {
		"node_modules/.*",
		"build/.*",
		"bin/.*",
		"target/.*",
		".next/*",
	},
})

fzf.register_ui_select()

vim.keymap.set("n", "<leader>F", fzf.global, { desc = "[F]ind" })
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "[f]ind [f]iles" })
vim.keymap.set("n", "<leader>fg", fzf.git_files, { desc = "[f] [g]it files" })
vim.keymap.set("n", "<leader>fr", fzf.live_grep, { desc = "[f]ind [r]ipgrep" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "[f]ind [b]uffers" })
vim.keymap.set("n", "<leader>fo", fzf.oldfiles, { desc = "[f]ind [o]ldfiles" })
vim.keymap.set("n", "<leader>fq", fzf.quickfix, { desc = "[f]ind [q]ickfix" })
vim.keymap.set("n", "<leader>fh", fzf.quickfix_stack, { desc = "[f]ind [h]istory" })
vim.keymap.set("n", "<leader>fk", fzf.keymaps, { desc = "[f]ind [k]eymaps" })
vim.keymap.set("n", "/", fzf.blines, { desc = "Search" })
vim.keymap.set("n", "<leader>ft", fzf.tags_live_grep, { desc = "[f]ind [t]ags" })

-- vim.api.nvim_set_hl(0, "FzfLuaNormal", { bg = "none", link = "" })
-- vim.api.nvim_set_hl(0, "FzfLuaPreviewNormal", { bg = "none", link = "" })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local fzf = require("fzf-lua")
		local function opts(desc)
			return { desc = desc, noremap = true, silent = true, buffer = args.buf }
		end

		vim.keymap.set("n", "gd", fzf.lsp_definitions, opts("[g]o [d]efinition"))
		vim.keymap.set("n", "gr", fzf.lsp_references, opts("[g]o [r]efrences"))
		vim.keymap.set("n", "gD", fzf.lsp_declarations, opts("[g]o [D]eclaration"))
		vim.keymap.set("n", "gi", fzf.lsp_implementations, opts("[g]o [i]mplementation"))
		vim.keymap.set("n", "<C-.>", fzf.lsp_code_actions, opts("[c]ode [a]ctions"))

		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("[r]e[n]ame"))

		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, opts("Hover Documentation"))

		vim.keymap.set("n", "<leader>fD", function()
			fzf.lsp_document_symbols({ query = "Function | Method " })
		end, opts("[f]ind [D]ocument methods"))
	end,
})

vim.pack.add({ gh("stephansama/fzf-nerdfont.nvim") })

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind

		if name == "fzf-nerdfont" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("fzf-nerdfont")
			end
			vim.cmd("FzfNerdfont generate")
		end
	end,
})

require("fzf-nerdfont").setup({})

vim.keymap.set("n", "<leader>fi", ":FzfNerdfont<CR>", { desc = "[f]ind [i]con" })
