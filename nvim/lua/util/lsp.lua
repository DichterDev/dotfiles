local M = {}

M.default = {}

---@param capabilities lsp.ClientCapabilities
M.default.capabilities = function(capabilities)
	if capabilities then
		return require("blink.cmp").get_lsp_capabilities(capabilities, true)
	end
	return require("blink.cmp").get_lsp_capabilities({}, true)
end

---@param name string
---@param config vim.lsp.Config
M.setup = function(name, config)
	local capabilities = config.capabilities or {}
	config.capabilities = M.default.capabilities(capabilities)

	vim.lsp.config(name, config)
	vim.lsp.enable(name)
end

return M
