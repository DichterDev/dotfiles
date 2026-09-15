local M = {}

---@alias core.keymap.Mode "n" | "x" | "i" | "c" | "t" | "v" | "o"

---@class core.keymap.Config
---@field opts vim.keymap.set.Opts

M.config = {
	opts = {},
}

---@param config core.keymap.Config
function M.setup(config)
	M.config = vim.tbl_deep_extend("force", M.config, config or {})
end

---@param modes core.keymap.Mode | core.keymap.Mode[]
---@param lhs string
---@param rhs string | (fun(): string) | (fun())
---@param opts? vim.keymap.set.Opts
function M.set(modes, lhs, rhs, opts)
	opts = vim.tbl_deep_extend("force", M.config.opts, opts or {})
	vim.keymap.set(modes, lhs, rhs, opts)
end

---@param modes core.keymap.Mode | core.keymap.Mode[]
---@param lhs string
---@param action string | (fun(): string) | (fun())
---@param opts? vim.keymap.set.Opts
function M.combo(modes, lhs, action, opts)
	opts = vim.tbl_deep_extend("force", M.config.opts, opts or {})
	require("mini.keymap").map_combo(modes, lhs, action, opts)
end

---@class core.keymap.step.Table
---@field condition fun(): boolean
---@field action fun()

---@alias core.keymap.step.pre.Pmenu "pmenu_next" | "pmenu_prev" | "pmenu_accept"
---@alias core.keymap.step.pre.MiniSnippets "minisnippets_next" | "minisnippets_prev" | "minisnippets_expand"
---@alias core.keymap.step.pre.MiniPairs "minipairs_cr" | "minipairs_bs"
---@alias core.keymap.step.pre.Jump "jump_after_tsnode" | "jump_before_tsnode" | "jump_after_close" | "jump_before_open"
---@alias core.keymap.step.pre.Whitespace "increase_indent" | "decrease_indent" | "hungry_bs"
---@alias core.keymap.step.pre.VimSnippet "vimsnippet_next" | "vimsnippet_prev"
---@alias core.keymap.step.pre.Blink "blink_next" | "blink_prev" | "blink_accept"
---@alias core.keymap.step.pre.LuaSnip "luasnip_next" | "luasnip_prev" | "luasnip_expand"
---@alias core.keymap.step.pre.NvimAutopairs "nvimautopairs_bs" | "nvimautopairs_cr"

---@alias core.keymap.step.Predefined core.keymap.step.pre.Pmenu
---| core.keymap.step.pre.MiniSnippets
---| core.keymap.step.pre.MiniPairs
---| core.keymap.step.pre.Jump
---| core.keymap.step.pre.Whitespace
---| core.keymap.step.pre.VimSnippet
---| core.keymap.step.pre.Blink
---| core.keymap.step.pre.LuaSnip
---| core.keymap.step.pre.NvimAutopairs

---@alias core.keymap.Step (string | core.keymap.step.Table | core.keymap.step.Predefined)[]

---@param modes core.keymap.Mode | core.keymap.Mode[]
---@param lhs string
---@param steps core.keymap.Step
---@param opts? vim.keymap.set.Opts
function M.multi(modes, lhs, steps, opts)
	opts = vim.tbl_deep_extend("force", M.config.opts, opts or {})

	local s = vim.list_extend({}, steps)

	-- table.insert(s, {
	-- 	condition = function()
	-- 		return true
	-- 	end,
	-- 	action = function()
	-- 		local key = vim.api.nvim_replace_termcodes(lhs, true, true, true)
	-- 		vim.api.nvim_feedkeys(key, "n", false)
	-- 	end,
	-- })

	require("mini.keymap").map_multistep(modes, lhs, s, opts)
end

return M
