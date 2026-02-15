local M = {}

---@param opt lsp.ClientCapabilities
M.capabilities = function(opt)
  if opt then
    return require("blink.cmp").get_lsp_capabilities(opt)
  end
  return require("blink.cmp").get_lsp_capabilities()
end

M.on_init = function(client, _)
end

M.on_attach = function(client, bufnr)
end

return M
