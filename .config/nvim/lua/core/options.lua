-- Basic UI
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.showmode = false
vim.o.cmdheight = 1
vim.o.signcolumn = "yes"
vim.o.termguicolors = true
vim.o.syntax = "on"

-- Wrapping
vim.o.wrap = false
vim.o.linebreak = true
vim.o.breakindent = true
-- vim.o.showbreak = "↳"

-- Indentation
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true

-- Searching
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true

-- Hidden characters
vim.o.list = true
vim.o.listchars = "trail:·,tab:»·,nbsp:+"

-- Folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldenable = true

-- Scrolloff
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- Neovim specific
vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.conceallevel = 0
-- vim.o.clipboard = "unnamedplus"
vim.o.undofile = true
vim.o.wildmode = "longest:full,full"
vim.o.virtualedit = "block"

-- Performance
vim.o.lazyredraw = false
vim.o.syntax = "on"

-- Advanced UI
vim.o.winborder = "rounded"

-- SHELL
vim.o.sh = "/bin/fish"
