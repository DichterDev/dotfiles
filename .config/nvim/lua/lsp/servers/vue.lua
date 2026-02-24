---@type vim.lsp.Config
local vstls = {
	filetypes = { "vue" },
	capabilities = require("lsp.defaults").capabilities({}),
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

vim.lsp.config("vstls", vstls)
vim.lsp.enable("vstls")

---@type vim.lsp.Config
local vue = {
	capabilities = require("lsp.defaults").capabilities({}),
}

vim.lsp.config("vue_ls", vue)
vim.lsp.enable("vue_ls")
