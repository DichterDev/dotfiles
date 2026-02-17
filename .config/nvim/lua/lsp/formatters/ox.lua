local M = {}

local function oxlint_conf_mentions_typescript(root_dir)
	local fn = vim.fs.joinpath(root_dir, ".oxlintrc.json")
	for line in io.lines(fn) do
		if line:find("typescript") then
			return true
		end
	end
	return false
end

---@type vim.lsp.Config
M.lint = {
	name = "oxline",
	cmd = { "oxlint", "--lsp" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
		"astro",
	},
	root_markers = { ".oxlintrc.json" },
	workspace_required = true,
	on_attach = function(client, bufnr)
		vim.api.nvim_buf_create_user_command(bufnr, "LspOxlintFixAll", function()
			client:exec_cmd({
				title = "Apply Oxlint automatic fixes",
				command = "oxc.fixAll",
				arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
			})
		end, {
			desc = "Apply Oxlint automatic fixes",
		})
	end,
	settings = {
		-- run = 'onType',
		-- configPath = nil,
		-- tsConfigPath = nil,
		-- unusedDisableDirectives = 'allow',
		-- typeAware = false,
		-- disableNestedConfig = false,
		-- fixKind = 'safe_fix',
	},
	before_init = function(init_params, config)
		local settings = config.settings or {}
		if settings.typeAware == nil and vim.fn.executable("tsgolint") == 1 then
			local ok, res = pcall(oxlint_conf_mentions_typescript, config.root_dir)
			if ok and res then
				settings = vim.tbl_extend("force", settings, { typeAware = true })
			end
		end
		local init_options = config.init_options or {}
		init_options.settings = vim.tbl_extend("force", init_options.settings or {} --[[@as table]], settings)

		init_params.initializationOptions = init_options
	end,
}

---@type vim.lsp.Config
M.fmt = {
	name = "oxfmt",
	cmd = { "oxfmt", "--lsp" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"toml",
		"json",
		"jsonc",
		"json5",
		"yaml",
		"html",
		"vue",
		"handlebars",
		"hbs",
		"css",
		"scss",
		"less",
		"graphql",
		"markdown",
		"mdx",
	},
	workspace_required = true,
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local root_markers = { ".oxlintrc.json", ".oxfmtrc.jsonc", "package.json", "package.json5" }
		on_dir(vim.fs.dirname(vim.fs.find(root_markers, { path = fname, upward = true })[1]))
	end,
}

return M
