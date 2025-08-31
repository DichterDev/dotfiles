local add = {
  source = "neovim/nvim-lspconfig",
  depends = {
    "b0o/schemastore.nvim",
    "saghen/blink.cmp",
    "mason-org/mason-lspconfig.nvim",
  },
}

local setup = function()
  local mason_lspconfig = require("mason-lspconfig")
  local schemastore = require("schemastore")
  local blink_cmp = require("blink.cmp")

  local capabilities = vim.tbl_deep_extend("force", blink_cmp.get_lsp_capabilities(), {
    offsetEncoding = { "utf-16" },
  })

  mason_lspconfig.setup({
    ensure_installed = {
      "jsonls",
      "lua_ls",
    },
    automatic_installation = false, -- Set to true if you want LSPs to auto-install on first file open
    automatic_enable = true,

    handlers = {
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
        })
      end,

      ["jsonls"] = function()
        require("lspconfig").jsonls.setup({
          capabilities = capabilities,
          settings = {
            json = {
              schemas = schemastore.json.schemas(),
              validate = { enable = true },
            },
          },
        })
      end,

      ["yamlls"] = function()
        require('lspconfig').yamlls.setup({
          capabilities = capabilities,
          settings = {
            yaml = {
              -- Disable yamlls' built-in schemaStore to use schemastore.nvim
              schemaStore = {
                enable = false,
                url = '',
              },
              schemas = schemastore.yaml.schemas(),
              validate = true,
              format = { enable = true },
            },
          },
        })
      end,
    }
  })

  local diagnostic_opts = {
    signs = true,
    underline = {
      severity = vim.diagnostic.severity.WARN,
    },
    virtual_text = {
      prefix = "●",
    },
    update_in_insert = false,
    severity_sort = true,
    float = {
      border = "rounded",
      source = "always",
    },
  }

  vim.diagnostic.config(diagnostic_opts)
end

return { add = add, setup = setup }
