return {
  --- @module "lazy"
  --- @type LazySpec
  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "mason-org/mason.nvim", "saghen/blink.cmp" },
    ft = { "java" },
    ---@module "jdtls"
    opts = function()
      vim.env.JAVA_HOME = "/usr/lib/jvm/java-21-openjdk"
      local cmd = { vim.fn.exepath("jdtls") }
      local mason_path = vim.fn.expand("$HOME/.local/share/nvim/mason")
      local lombok_jar = mason_path .. "/share/jdtls/lombok.jar"
      table.insert(cmd, string.format("--jvm-arg=-javaagent:%s", lombok_jar))
      return {
        root_dir = function(path)
          return vim.fs.root(path, vim.lsp.config.jdtls.root_markers)
        end,

        project_name = function(root_dir)
          return root_dir and vim.fs.basename(root_dir)
        end,

        jdtls_config_dir = function(project_name)
          return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
        end,
        jdtls_workspace_dir = function(project_name)
          return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
        end,

        cmd = cmd,
        full_cmd = function(opts)
          local fname = vim.api.nvim_buf_get_name(0)
          local root_dir = opts.root_dir(fname)
          local project_name = opts.project_name(root_dir)
          local cmd = vim.deepcopy(opts.cmd)
          if project_name then
            vim.list_extend(cmd, {
              "-configuration",
              opts.jdtls_config_dir(project_name),
              "-data",
              opts.jdtls_workspace_dir(project_name),
            })
          end
          return cmd
        end,

        dap = { hotcodereplace = "auto", config_overrides = {} },
        dap_main = {},
        test = true,
        settings = {
          java = {
            inlayHints = {
              parameterNames = {
                enabled = "all",
              },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      local mason_path = vim.fn.expand("$HOME/.local/share/nvim/mason")
      local bundles = {} ---@type string[]
      bundles = vim.fn.glob(mason_path .. "/share/java-debug-adapter/com.microsoft.java.debug.plugin-*jar", false, true)
      vim.list_extend(bundles, vim.fn.glob(mason_path .. "/share/java-test/*.jar", false, true))
      local function attach_jdtls()
        local fname = vim.api.nvim_buf_get_name(0)
        local config = {
          cmd = opts.full_cmd(opts),
          root_dir = opts.root_dir(fname),
          init_options = {
            bundles = bundles,
          },
          settings = opts.settings,
          capabilities = require("blink.cmp").get_lsp_capabilities()
        }

        config = vim.tbl_deep_extend("force", config, opts.jdtls or {})

        require("jdtls").start_or_attach(config)
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = attach_jdtls,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "jdtls" then
            require("jdtls").setup_dap(opts.dap)
            if opts.dap_main then
              require("jdtls.dap").setup_dap_main_class_configs(opts.dap_main)
            end
            if opts.on_attach then
              opts.on_attach(args)
            end
          end
        end,
      })
      attach_jdtls()
    end,
  }
}
