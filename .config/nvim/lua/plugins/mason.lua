return {
  {
    "mason-org/mason.nvim",
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
    }
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    opts = {
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
        "java-test",
        "jdtls",
        "java-debug-adapter",
      },
    }
  }
}
