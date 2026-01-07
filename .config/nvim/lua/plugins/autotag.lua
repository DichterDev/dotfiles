---@class LazyPlugin
return {
  "windwp/nvim-ts-autotag",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "handlebars",
    "html",
    "vue",
  },
  ---@module "nvim-ts-autotag"
  ---@class nvim-ts-autotag.PluginSetup
  opts = {
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = false
    },
  }
}
