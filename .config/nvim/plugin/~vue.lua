local setup = require("util").lsp.setup

---@type vim.lsp.Config
local vstls = {
	filetypes = { "vue" },
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					{
						name = "@vue/typescript-plugin",
						location = vim.fn.stdpath("data")
							.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
						languages = { "vue" },
						configNamespace = "typescript",
					},
				},
			},
		},
	},
}

---@type vim.lsp.Config
local vue = {}

setup("vstls", vstls)
setup("vue_ls", vue)
