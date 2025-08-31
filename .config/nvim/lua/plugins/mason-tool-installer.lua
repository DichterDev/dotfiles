local add = {
  source = "WhoIsSethDaniel/mason-tool-installer.nvim",
  depends = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
  }
}

local setup = function()
  require("mason-tool-installer").setup({
    auto_update = true,
    ensure_installed = {
      "jsonls",
      "lua_ls",
      "clangd",
      "rust-analyzer",
      "pyright",
      "html-lsp",
      "css-lsp",
      "dockerls",
    },
  })
end

return { add = add, setup = setup }
