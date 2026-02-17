---@type Server
local M = {}

M.ignored = true

M.config = {
	cmd = { "vstls" },
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
	root_markers = {
		"package.json",
		"tsconfig.json",
		"package-lock.json",
		"yarn.lock",
		"pnpm-lock.yaml",
		"bun.lockb",
		"bun.lock",
	},
}

return M
