---@diagnostic disable: missing-fields, inject-field, assign-type-mismatch
local heirline = require("heirline")
local components = require("heirline-components.all")
local lib = require("heirline-components.all").component
local condition = require("heirline-components.all").condition

vim.o.showtabline = 2

require("heirline-components").setup({
	colors = {
		darkestgrey = "#16161e",
	},
})

components.init.subscribe_to_events()
heirline.load_colors(components.hl.get_colors())

local StatusLine = {
	hl = { fg = "fg", bg = "bg" },
	lib.mode({ mode_text = { "center" } }),
	lib.git_branch(),
	lib.diagnostics(),
	{
		provider = function(self)
			local full_path = vim.api.nvim_buf_get_name(self.bufnr or 0)
			if full_path == "" then
				return ""
			end

			local dir = vim.fn.fnamemodify(full_path, ":~:.:h")
			return dir == "." and "" or (dir .. "/")
		end,
		lib.file_info({
			file_icon = false,
			filename = {},
			filetype = false,
			file_modified = { padding = { left = 1, right = 1 }, condition = condition.is_file },
			hl = {
				fg = "lightgreen",
				bold = true,
			},
		}),
		hl = {
			fg = "lightgreen",
			bold = true,
		},
	},
	lib.fill(),
	lib.file_info(),
	lib.lsp({ lsp_progress = false }),
	lib.nav({ surround = { separator = "right" } }),
}

local StatusColumn = {
	init = function(self)
		self.bufnr = vim.api.nvim_get_current_buf()
	end,
	lib.foldcolumn({ foldcolumn = { padding = { left = 1, right = 1 } } }),
	lib.numbercolumn(),
	lib.signcolumn(),
	{
		provider = "▏",
	},
}

local WinBar = {
	init = function(self)
		self.bufnr = vim.api.nvim_get_current_buf()
	end,
	lib.breadcrumbs({
		hl = { bg = "tab_active_bg" },
	}),
	lib.fill({
		hl = { bg = "tab_active_bg" },
	}),
	{ provider = " " },
	lib.neotree({ hl = { fg = "tab_active_fg", bg = "tab_bg" } }),
	{ provider = " " },
	lib.aerial({ hl = { fg = "tab_active_fg", bg = "tab_bg" } }),
	{ provider = " " },
}

local TabLine = {
	{ provider = " " },
	lib.tabline_buffers({
		hl = function(self)
			local state = self.is_active and "active_" or ""
			return {
				fg = "tab_" .. state .. "fg",
				bg = "tab_" .. state .. "bg",
			}
		end,
	}),
	lib.fill({ hl = { fg = "tab_fg", bg = "tab_bg" } }),
	lib.tabline_tabpages({
		hl = function(self)
			local state = self.is_active and "active_" or ""
			return {
				fg = "tab_" .. state .. "fg",
				bg = "tab_" .. state .. "bg",
			}
		end,
	}),
}

heirline.setup({
	statusline = StatusLine,
	statuscolumn = StatusColumn,
	winbar = WinBar,
	tabline = TabLine,
	opts = {
		disable_winbar_cb = function(args)
			return not require("heirline-components.buffer").is_valid(args.buf)
				or condition.buffer_matches({
					buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
					filetype = {
						"NvimTree",
						"neo%-tree",
						"dashboard",
						"alpha",
						"snacks_dashboard",
						"Outline",
						"aerial",
					},
				}, args.buf)
		end,
	},
})
