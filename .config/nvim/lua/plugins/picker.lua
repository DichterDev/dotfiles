local add = { source = "ibhagwan/fzf-lua", name = "fzf", depends = { "echasnovski/mini.icons" } }

local setup = function()

  local fzf = require("fzf-lua")
  local map = vim.keymap.set

  fzf.setup({})

  map("n", "<leader>ff", fzf.files, { desc = "[f]ind [f]iles" })
  map("n", "<leader>fg", fzf.git_files, { desc = "[f] [g]it files" })
  map("n", "<leader>fr", fzf.live_grep, { desc = "[f]ind [r]ipgrep" })
  map("n", "<leader>fb", fzf.buffers, { desc = "[f]ind [b]uffers" })
end

return { add = add, setup = setup }
