---@class Server
---@field config? vim.lsp.Config
---@field ignored? boolean

local utils = require("core.utils")

local function start(name)
	local ok, srv = pcall(require, "lsp.servers." .. name)

	---@cast srv Server
	if not ok then
		return
	end

	if srv.ignored then
		return
	end

	name = srv.config.name or name
	vim.lsp.config(name, srv.config)
	vim.lsp.enable(name)
end

local sdir = utils.fs.get_dir() .. "/servers"
local servers = utils.fs.find_files(sdir)

for _, server in ipairs(servers) do
	local name = vim.fn.fnamemodify(server, ":t:r")
	start(name)
end

-- LINTERS & FORMATTERS
local ox = require("lsp.formatters.ox")
vim.lsp.config(ox.lint.name, ox.lint)
vim.lsp.enable(ox.lint.name)

vim.lsp.config(ox.fmt.name, ox.fmt)
vim.lsp.enable(ox.fmt.name)

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
		Map("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts("[f]ormat"))
		Map("n", "<leader>fD", function()
			fzf.lsp_document_symbols({ query = "Function | Method " })
		end, opts("[f]ind [D]ocument methods"))
	end,
})
