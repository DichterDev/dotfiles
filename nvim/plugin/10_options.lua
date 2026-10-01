vim.o.exrc = true

vim.o.mouse = "a"
vim.o.switchbuf = "usetab"
vim.o.undofile = true
vim.o.sh = "/bin/fish"

vim.o.breakindent = true
vim.o.breakindentopt = "list:-1"
vim.o.colorcolumn = "+1"
vim.o.cursorline = true
vim.o.linebreak = true
vim.o.list = true
vim.o.number = true
vim.o.pumheight = 10
vim.o.ruler = false
vim.o.shortmess = "CFOSWaco"
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.splitbelow = true
vim.o.splitkeep = "screen"
vim.o.splitright = true
vim.o.wrap = false
vim.o.background = "dark"
vim.o.termguicolors = true

vim.o.foldcolumn = "1"
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldmethod = "expr"

vim.o.cursorlineopt = "screenline,number"

vim.o.fillchars = "eob: ,fold: ,foldopen:󰅀,foldsep: ,foldinner: ,foldclose:"
vim.o.list = false
vim.o.listchars = "trail:·,tab:»·,nbsp:+"

if vim.fn.has("nvim-0.12") == 1 then
	require("vim._core.ui2").enable({ enable = true })
end

vim.o.autoindent = true
vim.o.expandtab = true
vim.o.formatoptions = "rqnl1j"
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.infercase = true
vim.o.shiftwidth = 2
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.spelllang = "en,de"
vim.o.spelloptions = "camel"
vim.o.tabstop = 2
vim.o.virtualedit = "block"

local mappings = {
	"ö\\[",
	"Ö\\{",
	"ä\\]",
	"Ä\\}",
	"ü\\`",
	"Ü\\@",
	"ß\\\\",
}

vim.o.langmap = table.concat(mappings, ",")
