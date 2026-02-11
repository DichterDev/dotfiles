---@type vim.lsp.Config
return {
  enabled = true,
  cmd = { "tsgo", "--lsp", "--stdio" },
  filetypes = {
    "html",
    -- "javascript",
    -- "javascriptreact",
    -- "javascript.jsx",
    -- "typescript",
    -- "typescriptreact",
    -- "typescript.tsx"
  },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json" },
}
