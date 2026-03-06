require("lsp.keybinds")

-- Script
require("lsp.servers.bash")
require("lsp.servers.fish")

-- Data
require("lsp.servers.json")
require("lsp.servers.toml")
require("lsp.servers.yaml")
require("lsp.servers.docker")

-- Language
require("lsp.servers.go")
require("lsp.servers.ts")
require("lsp.servers.lua")
require("lsp.servers.rust")
require("lsp.servers.python")
require("lsp..servers.groovy")

-- Web
require("lsp.servers.html")
require("lsp.servers.css")
require("lsp.servers.vue")
require("lsp.servers.glsl")

-- Markup
require("lsp.servers.typst")
require("lsp.servers.markdown")

-- Formatters
require("lsp.formatters.ox")
require("lsp.formatters.ruff")
require("lsp.formatters.stylua")
