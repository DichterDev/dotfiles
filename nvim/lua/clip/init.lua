local M = {}

--- *clip.nvim* A Neovim Clipboard Manager
--- Usage:
--- :Paste -> opens vim.ui.select
--- :Paste local -> paste from local
--- :Paste global -> paste from global
--- :Paste host -> paste from host
--- :Paste latest -> paste from latest
---
--- :Yank -> yank into local
--- :Yank! ... -> yank without updating latest
--- :Yank local -> yank into local
--- :Yank global -> yank into global
--- :Yank host -> yank into host
--- :Yank void -> yank into void

local paste = require("clip.paste")
local yank = require("clip.yank")

M.config = {
	file_paste = {
		---@type "buf" | "cwd" | "abs"
		path = "cwd",
		---@type "path" | "content" | "copy" | "prompt"
		fallback = "path",
		-- pasting behaviour for media
		-- see :h clip-paste-media
		media = {
			---@type "inherit" | "buf" | "cwd" | "abs"
			path = "inherit",
			target = "assets",
			exts = { "png", "jpeg", "jpg", "gif", "mp4", "mkv", "mp3" },
			---@type "inherit" | fun(): string
			filename = function()
				return tostring(os.date("%Y-%m-%d_%H-%M-%S"))
			end,
			templates = {
				["typst"] = '#image("/%p")',
				["markdown"] = "![%s](%p)",
			},
		},
		-- pasting behaviour for docs
		-- see :h clip-paste-docs
		docs = {
			---@type "inherit" | "buf" | "cwd" | "abs"
			path = "inherit",
			target = "docs",
			exts = { "pdf", "txt" },
		},
	},
	-- handle indentation see
	-- :h clip-smart-indent
	smart_indent = true,
	-- see :h clip-remap
	remap = {
		-- remaps y, yy, Y -> :Yank local
		-- see :h clip-remap-yank
		yank = false,
		-- remaps p, P -> :Paste local
		-- see :h clip-remap-paste
		paste = false,
		-- d, dd, c, x -> :Yank void
		-- see :h clip-remap-void
		void = false,
		-- Maps <C-S-v> -> :Paste host (handles text, file paths, and Firefox image blobs)
		host = true,
	},
}

function M.setup(opts)
	opts = opts or {}
	M.config = vim.tbl_deep_extend("force", M.config, opts)

	local cmd = require("clip.command")
	cmd.setup_paste()
	cmd.setup_yank()

	if M.config.remap.host then
		vim.keymap.set({ "n", "x" }, "<C-S-v>", "<Cmd>Paste host<CR>", {
			desc = "Paste from host clipboard (supports images & files)",
		})
		vim.keymap.set("i", "<C-S-v>", "<C-o><Cmd>Paste host<CR>", {
			desc = "Paste from host clipboard in insert mode",
		})
	end
end

function M.paste(opts) end

function M.yank(opts) end

return M
