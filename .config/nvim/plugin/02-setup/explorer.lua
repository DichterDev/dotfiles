local gh = require("util").pack.gh

vim.pack.add({ gh("stevearc/oil.nvim") })

require("oil").setup({
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, _)
      return name == ".." or name == ".git"
    end,
  },
	win_options = {
		winbar = "%{v:lua.require('oil').get_current_dir()}",
	},
})

vim.keymap.set("n", "<leader>x", ":Oil<CR>", { desc = "e[x]plore" })
vim.keymap.set("n", "<leader>X", function()
  require("oil").open(vim.fn.getcwd())
end, { desc = "e[X]plore cwd" })

vim.pack.add({
  { src = gh("nvim-neo-tree/neo-tree.nvim"), version = vim.version.range("3") },
  gh("nvim-lua/plenary.nvim"),
  gh("MunifTanjim/nui.nvim"),
})

require("neo-tree").setup({
  filesystem = {
    use_libuv_file_watcher = true,
    follow_current_file = {
      enabled = true,
      leave_dirs_open = false,
    },
  },
  window = {
    mappings = {
      ["a"] = "none",
      ["d"] = "none",
      ["r"] = "none",
      ["m"] = "none",
      ["x"] = "none",
    },
  },
})

vim.keymap.set("n", "<leader>e", ":Neotree toggle show right<CR>", { desc = "toggle neotree" })
