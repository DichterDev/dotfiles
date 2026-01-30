-- TODO: standard paths like mason, data, config

-- CONFIG
require("config.globals")
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.filetypes")
require("config.diagnostics")

-- PLUGINS
require("config.lazy")

-- LSP
require("lsp")
