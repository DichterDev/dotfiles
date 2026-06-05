---@type vim.lsp.Config
local config = {
	cmd = { "superhtml", "lsp" },
	capabilities = { "documentFormattingProvider" },
}

require("util").lsp.setup("superhtml", config)
