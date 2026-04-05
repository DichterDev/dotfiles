-- CONFIG
require("core.globals")
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.filetypes")
require("core.diagnostics")

-- PLUGINS
require("core.lazy")

-- LSP
require("lsp")

vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nvim.difftool")
vim.cmd.packadd("nvim.tohtml")
