return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  config = function()
    local fzf = require("fzf-lua")
    local map = vim.keymap.set

    fzf.setup({})

    fzf.register_ui_select()

    map("n", "<leader>ff", fzf.files, { desc = "[f]ind [f]iles" })
    map("n", "<leader>fg", fzf.git_files, { desc = "[f] [g]it files" })
    map("n", "<leader>fr", fzf.live_grep, { desc = "[f]ind [r]ipgrep" })
    map("n", "<leader>fb", fzf.buffers, { desc = "[f]ind [b]uffers" })
    map("n", "<leader>fo", fzf.oldfiles, { desc = "[f]ind [o]ldfiles" })
    map("n", "<leader>fq", fzf.lgrep_quickfix, { desc = "[f]ind [q]ickfix" })
  end
}
