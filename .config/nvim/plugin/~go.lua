---@type vim.lsp.Config
local config = {
	settings = {},
}

require("util").lsp.setup("gopls", config)
