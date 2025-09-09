return {
  "saghen/blink.cmp",
  build = "cargo build --release",
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "1.*",
  opts = {
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "normal"
    },
    keymap = {
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { function(cmp) return cmp.select_next() end, "snippet_forward", "fallback", },
      ["<S-Tab>"] = { function(cmp) return cmp.select_prev() end, "snippet_backward", "fallback", },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-up>"] = { "scroll_documentation_up", "fallback" },
      ["<C-down>"] = { "scroll_documentation_down", "fallback" },
    },
    completion = {
      accept = { auto_brackets = { enabled = true } },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 250,
        update_delay_ms = 50,
        treesitter_highlighting = true,
        window = { border = "rounded" },
      },
      list = { selection = { preselect = false, auto_insert = false, }, },
      menu = {
        border = "rounded",
        draw = { columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" }, }, treesitter = { "lsp" }, },
      }
    },
    signature = {enabled = true, window = { border = "rounded" },},
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", },
        lsp = { min_keyword_length = 0, },
        path = { min_keyword_length = 0, },
        snippets = { min_keyword_length = 2, },
        buffer = { min_keyword_length = 4, max_items = 5, },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
