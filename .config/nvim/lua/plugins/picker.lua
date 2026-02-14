---@type LazySpec
return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  config = function()
    local fzf = require("fzf-lua")

    fzf.setup({})

    fzf.register_ui_select()

    Map("n", "<leader>ff", fzf.files, { desc = "[f]ind [f]iles" })
    Map("n", "<leader>fg", fzf.git_files, { desc = "[f] [g]it files" })
    Map("n", "<leader>fr", fzf.live_grep, { desc = "[f]ind [r]ipgrep" })
    Map("n", "<leader>fb", fzf.buffers, { desc = "[f]ind [b]uffers" })
    Map("n", "<leader>fo", fzf.oldfiles, { desc = "[f]ind [o]ldfiles" })
    Map("n", "<leader>fq", fzf.lgrep_quickfix, { desc = "[f]ind [q]ickfix" })
    Map("n", "<leader>fh", fzf.quickfix_stack, { desc = "[f]ind [h]istory" })

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        local buffer = vim.api.nvim_get_current_buf()
        local name = vim.api.nvim_buf_get_name(buffer)
        if vim.fn.isdirectory(name) == 1 then
          vim.api.nvim_buf_delete(buffer, { force = true })
          vim.api.nvim_set_current_dir(name)
          vim.schedule(function()
            require("fzf-lua").files()
          end)
        end
      end,
    })
  end
}
