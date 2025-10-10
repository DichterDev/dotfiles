return {
  "folke/lazydev.nvim",
  opts = {
    ui = {
      icons = {
        package_installed = '✓',
        package_pending = '➜',
        package_uninstalled = '✗',
      },
      check_outdated_packages_on_open = true,
      border = 'rounded',
      width = 0.9,
      height = 0.9,
    }
  },
  config = function(_, opts)
    require("lazydev").setup(opts)

    local ok, lazydev_lsp = pcall(require, "lazydev.lsp")
    if ok then
      local orig_supports = lazydev_lsp.supports
      lazydev_lsp.supports = function(client)
        return client and vim.tbl_contains({ "lua", "emmylua-analyzer-rust" }, client.name)
      end
    end
  end
}
