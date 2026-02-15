local quarkus = require("lsp.servers.quarkus").config
local microprofile = require("lsp.servers.microprofile").config

vim.lsp.start(quarkus)
vim.lsp.start(microprofile)
