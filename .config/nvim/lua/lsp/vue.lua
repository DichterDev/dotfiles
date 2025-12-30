---@type vim.lsp.Config
return {
  cmd = { "vue-language-server", "--stdio" },
  filetypes = { "vue" },
  root_markers = {
    "package.json",
    "vue.config.js",
    "vite.config.ts",
    "vite.config.js",
    "nuxt.config.ts",
    "nuxt.config.js",
    ".git",
  },
  init_options = {
    vue = {
      hybridMode = false,
    },
    typescript = {}
  },
}
