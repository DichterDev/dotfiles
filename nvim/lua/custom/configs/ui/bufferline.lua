vim.opt.termguicolors = true
require('bufferline').setup {
  options = {
    offsets = {
      {
        filetype = 'neo-tree',
        text = 'File Explorer',
        text_align = 'left',
        separator = true,
      },
    },
    separator_style = 'slope',
  },
}
