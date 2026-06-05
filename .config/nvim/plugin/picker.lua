vim.pack.add({
	Gh("ibhagwan/fzf-lua"),
	Gh("nvim-mini/mini.icons"),
	Gh("folke/tokyonight.nvim"),
})

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

Map("n", "<leader>F", fzf.global, { desc = "[F]ind" })
Map("n", "<leader>ff", fzf.files, { desc = "[f]ind [f]iles" })
Map("n", "<leader>fg", fzf.git_files, { desc = "[f] [g]it files" })
Map("n", "<leader>fr", fzf.live_grep, { desc = "[f]ind [r]ipgrep" })
Map("n", "<leader>fb", fzf.buffers, { desc = "[f]ind [b]uffers" })
Map("n", "<leader>fo", fzf.oldfiles, { desc = "[f]ind [o]ldfiles" })
Map("n", "<leader>fq", fzf.quickfix, { desc = "[f]ind [q]ickfix" })
Map("n", "<leader>fh", fzf.quickfix_stack, { desc = "[f]ind [h]istory" })
Map("n", "<leader>fk", fzf.keymaps, { desc = "[f]ind [k]eymaps" })
Map("n", "/", fzf.blines, { desc = "Search" })
Map("n", "<leader>ft", fzf.tags_live_grep, { desc = "[f]ind [t]ags" })
Map("n", "<leader>fd", fzf.lsp_workspace_diagnostics, { desc = "[f]ind [d]iagnostics" })
Map("n", "<leader>fx", fzf.lsp_document_diagnostics, { desc = "[f]ind buffer diagnostics" })

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		local remove_bg = require("util").hl.remove_bg
		remove_bg("FzfLuaNormal")
		remove_bg("FzfLuaPreviewNormal")
		remove_bg("FzfLuaBackdrop")
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local fzf = require("fzf-lua")
		local function opts(desc)
			return { desc = desc, noremap = true, silent = true, buffer = args.buf }
		end

		Map("n", "gd", fzf.lsp_definitions, opts("[g]o [d]efinition"))
		Map("n", "gr", fzf.lsp_references, opts("[g]o [r]efrences"))
		Map("n", "gD", fzf.lsp_declarations, opts("[g]o [D]eclaration"))
		Map("n", "gi", fzf.lsp_implementations, opts("[g]o [i]mplementation"))
		Map("n", "<C-.>", fzf.lsp_code_actions, opts("[c]ode [a]ctions"))

		Map("n", "<leader>rn", vim.lsp.buf.rename, opts("[r]e[n]ame"))

		Map("n", "K", function()
			vim.lsp.buf.hover({ border = { " ", " ", " ", " ", " ", " ", " ", " " } })
		end, opts("Hover Documentation"))

		Map("n", "<leader>fD", function()
			fzf.lsp_document_symbols({ query = "Function | Method " })
		end, opts("[f]ind [D]ocument methods"))
	end,
})

vim.pack.add({ Gh("stephansama/fzf-nerdfont.nvim") })

Autocmd("PackChanged", "packchanged-fzf", {
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

Map("n", "<leader>fi", ":FzfNerdfont<CR>", { desc = "[f]ind [i]con" })
