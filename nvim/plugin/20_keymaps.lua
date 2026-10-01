local keymap = require("core.keymap")

keymap.setup({ opts = { silent = true } })

local map = keymap.set
local multi = keymap.multi
local combo = keymap.combo

map("n", "<leader>u", ":Undotree<CR>", { desc = "[u]ndotree" })

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "n", "nzzzv", { silent = true })
map("n", "N", "Nzzzv")

map("n", "<C-S>", "<Cmd>silent! update | redraw<CR>", { desc = "Save" })
map({ "i", "x" }, "<C-S>", "<Esc><Cmd>silent! update | redraw<CR>", { desc = "Save and go to Normal mode" })

map("n", "<leader>a", "ggVG", { desc = "Visual select all" })

map("n", "<leader>Q", ":qa<CR>", { desc = "[Q]it all" })
map("n", "<leader>R", "<CMD>restart<CR>", { desc = "[R]estart" })

-- src: https://www.reddit.com/r/neovim/comments/1scauyd/comment/oecobq8/
map({ "x", "o" }, "v", function()
	if vim.treesitter.get_parser(nil, nil, { error = false }) then
		require("vim.treesitter._select").select_parent(vim.v.count1)
	else
		vim.lsp.buf.selection_range(vim.v.count1)
	end
end, { desc = "[v]isual increment" })

map({ "x", "o" }, "V", function()
	if vim.treesitter.get_parser(nil, nil, { error = false }) then
		require("vim.treesitter._select").select_child(vim.v.count1)
	else
		vim.lsp.buf.selection_range(-vim.v.count1)
	end
end, { desc = "[V]isual decrement" })

map({ "n", "v" }, "<leader>y", '"+y', { desc = "[y]ank to clipboard" })
map("n", "<leader>yy", '"+yy', { desc = "[yy]ank to clipboard" })
map("n", "<leader>Y", '"+y_', { desc = "[Y]ank to clipboard" })

map({ "n", "v" }, "<leader>p", '"+p', { desc = "[p]aste from clipboard" })
map({ "n", "v" }, "<leader>P", '"+P"', { desc = "[P]aste from clipboard" })

map("n", "<leader>d", vim.diagnostic.open_float, { desc = "[d]iagnostic float" })

combo("i", "jk", "<BS><BS><ESC>")
combo("i", "kj", "<BS><BS><ESC>")
combo("t", "jk", "<BS><BS><C-\\><C-n>")
combo("t", "kj", "<BS><BS><C-\\><C-n>")

local mode = { "i", "c" }

multi(mode, "<Tab>", {
	"blink_next",
	"minisnippets_next",
	"increase_indent",
	"jump_after_close",
})

multi(mode, "<S-Tab>", {
	"blink_prev",
	"minisnippets_prev",
	"decrease_indent",
	"jump_before_open",
})

multi(mode, "<CR>", {
	"blink_accept",
	"minipairs_cr",
})

multi("i", "<BS>", {
	"minipairs_bs",
	"hungry_bs",
})

multi(mode, "<C-n>", {
	"blink_next",
})

multi(mode, "<C-p>", {
	"blink_prev",
})

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

combo({ "n", "i", "x", "c" }, "<Esc><Esc>", function()
	vim.cmd("nohlsearch")
end)

--#region FLASH

map({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end)

map({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end)

map({ "n", "x", "o" }, "r", function()
	require("flash").remote()
end)

map({ "n", "x", "o" }, "R", function()
	require("flash").treesitter_search()
end)

--#endregion

map("n", "<leader>x", ":Oil<CR>", { desc = "e[x]plore" })
map("n", "<leader>X", function()
	require("oil").open(vim.fn.getcwd())
end, { desc = "e[X]plore cwd" })

map("n", "<leader>E", "<CMD>Neotree toggle show right<CR>", { desc = "toggle neotree" })

map("n", "<leader>o", "<CMD>AerialToggle!<CR>", { desc = "toggle aerial [o]utline" })
map({ "n" }, "<leader>gg", "<CMD>Neogit<CR>", { desc = "Show Neogit UI" })

--#region FZF
map("n", "<leader>F", "<CMD>FzfLua global<CR>", { desc = "[F]ind" })
map("n", "<leader>ff", "<CMD>FzfLua files<CR>", { desc = "[f]ind [f]iles" })
map("n", "<leader>fg", "<CMD>FzfLua git_files<CR>", { desc = "[f] [g]it files" })
map("n", "<leader>fr", "<CMD>FzfLua live_grep resume=true<CR>", { desc = "[f]ind [r]ipgrep" })
map("n", "<leader><Tab>", "<CMD>FzfLua buffers<CR>", { desc = "[f]ind [b]uffers" })
map("n", "<leader>fo", "<CMD>FzfLua oldfiles<CR>", { desc = "[f]ind [o]ldfiles" })
map("n", "<leader>fq", "<CMD>FzfLua quickfix<CR>", { desc = "[f]ind [q]ickfix" })
map("n", "<leader>fh", "<CMD>FzfLua highlights<CR>", { desc = "[f]ind [h]istory" })
map("n", "<leader>fm", "<CMD> FzfLua marks<CR>", { desc = "[f]ind [m]arks" })
map("n", "<leader>fk", "<CMD>FzfLua keymaps<CR>", { desc = "[f]ind [k]eymaps" })
map("n", "<leader>fb", "<CMD>FzfLua blines<CR>", { desc = "[f]ind [b]uffer lines" })
map("n", "<leader>ft", "<CMD>FzfLua tags_live_grep<CR>", { desc = "[f]ind [t]ags" })
map("n", "<leader>fd", "<CMD>FzfLua lsp_workspace_diagnostics<CR>", { desc = "[f]ind [d]iagnostics" })
map("n", "<leader>fx", "<CMD>FzfLua lsp_document_diagnostics<CR>", { desc = "[f]ind buffer diagnostics" })
map("n", "<leader>fz", "<CMD>FzfLua zoxide<CR>", { desc = "[f]ind [z]oxide" })
map("n", "<leader>fi", "<CMD>FzfNerdfont<CR>", { desc = "[f]ind [i]con" })
map("n", "<leader>fs", require("mini.sessions").select, { desc = "[f]ind [s]ession" })
--#endregion

Autocmd("LspAttach", "fzf-lua-lsp", {
	callback = function(args)
		local function opts(desc)
			return { desc = desc, noremap = true, silent = true, buffer = args.buf }
		end

		map("n", "gd", "<CMD>FzfLua lsp_definitions<CR>", opts("[g]o [d]efinition"))
		map("n", "gr", "<CMD>FzfLua lsp_references<CR>", opts("[g]o [r]efrences"))
		map("n", "gD", "<CMD>FzfLua lsp_declarations<CR>", opts("[g]o [D]eclaration"))
		map("n", "gi", "<CMD>FzfLua lsp_implementations<CR>", opts("[g]o [i]mplementation"))
		map("n", "<leader>ca", "<CMD>FzfLua lsp_code_actions<CR>", opts("[c]ode [a]ctions"))

		map("n", "<leader>rn", vim.lsp.buf.rename, opts("[r]e[n]ame"))

		map("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded", max_width = 120, max_height = 40 })
		end, opts("Hover Documentation"))
	end,
})

map("n", "<leader>q", require("quicker").toggle, { desc = "toggle [q]uickfix" })

map("n", "<leader>l", function()
	require("quicker").toggle({ loclist = true })
end, {
	desc = "toggle [l]oclist",
})

local has_dap, dap = pcall(require, "dap")
local has_dap_view, dap_view = pcall(require, "dap-view")

if has_dap then
	local function set_debug_keymaps()
		map("n", "<Down>", function()
			dap.step_over()
		end, { desc = "Debug: Step Over" })
		map("n", "<Right>", function()
			dap.step_into()
		end, { desc = "Debug: Step Into" })
		map("n", "<Left>", function()
			dap.step_out()
		end, { desc = "Debug: Step Out" })
		map("n", "<Up>", function()
			dap.restart_frame()
		end, { desc = "Debug: Restart Frame" })
	end

	local function remove_debug_keymaps()
		local arrow_keys = { "<Down>", "<Right>", "<Left>", "<Up>" }
		for _, key in ipairs(arrow_keys) do
			pcall(vim.keymap.del, "n", key)
		end
	end

	dap.listeners.after.event_initialized["dap_arrow_keymaps"] = function()
		set_debug_keymaps()
	end

	dap.listeners.before.event_terminated["dap_arrow_keymaps"] = function()
		remove_debug_keymaps()
	end

	dap.listeners.before.event_exited["dap_arrow_keymaps"] = function()
		remove_debug_keymaps()
	end

	map("n", "<F5>", function()
		dap.continue()
	end, { desc = "Debug: Start / Continue" })

	map("n", "<S-F5>", function()
		dap.terminate()
	end, { desc = "Debug: Stop / Terminate" })

	map("n", "<C-S-F5>", function()
		dap.restart()
	end, { desc = "Debug: Restart Session" })

	map("n", "<leader>db", "<CMD>DapToggleBreakpoint<CR>", { desc = "Debug: Toggle [B]reakpoint" })
	map("n", "<leader>dB", function()
		dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
	end, { desc = "Debug: Set Conditional [B]reakpoint" })

	map("n", "<leader>dlp", function()
		dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
	end, { desc = "Debug: Set [L]og [P]oint" })

	map("n", "<leader>dr", function()
		dap.repl.open()
	end, { desc = "Debug: Open [R]EPL" })
	map("n", "<leader>dl", function()
		dap.run_last()
	end, { desc = "Debug: Run [L]ast" })

	if has_dap_view then
		map("n", "<leader>dv", function()
			dap_view.toggle()
		end, { desc = "Debug: Toggle [V]iew" })

		dap.listeners.after.event_initialized["dap_view_auto"] = function()
			dap_view.open()
		end

		dap.listeners.before.event_terminated["dap_view_auto"] = function()
			dap_view.close()
		end

		dap.listeners.before.event_exited["dap_view_auto"] = function()
			dap_view.close()
		end
	end
end
