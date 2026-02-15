Autocmd = vim.api.nvim_create_autocmd

function Augroup(name)
  return vim.api.nvim_create_augroup("dichter_" .. name, { clear = true })
end

-- Highlight on yank
Autocmd("TextYankPost", {
  group = Augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- resize splits if window got resized
Autocmd({ "VimResized" }, {
  group = Augroup("resize_split"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})
