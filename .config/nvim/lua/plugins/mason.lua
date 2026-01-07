return {
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
        check_outdated_packages_on_open = true,
        border = "rounded",
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
        -- CONFIG
        "fish-lsp",
        -- LUA
        "lua_ls",
        -- JSON
        "jsonls",
        -- MARKDOWN
        "marksman",
        -- DOCKER
        "docker-language-server",
        -- PRETTIER
        "prettierd", -- formatter
        -- HTML
        "superhtml",
        "htmx-lsp",
        -- CSS
        "css-lsp",
        -- JS / TS
        "tsgo",
        "vtsls", -- only used for VUE
        -- VUE
        "vue-language-server",
        -- PYTHON
        "ty",
        "ruff", -- formatter
        -- C / C++
        "clangd",
        -- RUST
        "rust-analyzer",
        -- JAVA
        "jdtls",
        "java-test",
        "java-debug-adapter",
        "vscode-spring-boot-tools",
      },
    }
  }
}
