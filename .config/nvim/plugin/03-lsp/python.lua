local setup = require("util").lsp.setup

---@type vim.lsp.Config
local config = {}

---@type vim.lsp.Config
local format = {}

setup("ty", config)
setup("ruff", format)
