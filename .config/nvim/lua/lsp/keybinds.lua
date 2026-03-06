Autocmd("LspAttach", {
	group = Augroup("lsp_keybinds"),
	callback = function(args)
		local fzf = require("fzf-lua")

		local function opts(desc)
			return { desc = desc, noremap = true, silent = true, buffer = args.buf }
		end
		Map("n", "gd", fzf.lsp_definitions, opts("[g]o [d]efinition"))
		Map("n", "gr", fzf.lsp_references, opts("[g]o [r]efrences"))
		Map("n", "gD", fzf.lsp_declarations, opts("[g]o [D]eclaration"))
		Map("n", "gi", fzf.lsp_implementations, opts("[g]o [i]mplementation"))
		Map("n", "K", vim.lsp.buf.hover, opts("Hover Documentation"))
		Map("n", "<C-.>", fzf.lsp_code_actions, opts("[c]ode [a]ctions"))
		Map("n", "<leader>rn", vim.lsp.buf.rename, opts("[r]e[n]ame"))
		Map("n", "<leader>f", function(_, bufnr)
			local clients = vim.lsp.get_clients({ bufnr = bufnr })
			local lsp_can_format = false

			for _, client in ipairs(clients) do
				if client.supports_method("textDocument/formatting") then
					lsp_can_format = true
					break
				end
			end

			if lsp_can_format then
				vim.lsp.buf.format({ async = true })
			else
				local view = vim.fn.winsaveview()
				vim.cmd("normal! gg=G")
				vim.fn.winrestview(view)
			end
		end, opts("[f]ormat"))
		Map("n", "<leader>fD", function()
			fzf.lsp_document_symbols({ query = "Function | Method " })
		end, opts("[f]ind [D]ocument methods"))
	end,
})
