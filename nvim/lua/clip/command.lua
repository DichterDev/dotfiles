-- lua/clip/command.lua
local M = {}

local PASTE_TARGETS = { "local", "global", "host", "latest", "blob" }
local PASTE_FLAGS = { "--before", "--raw" }

--- Parse :Paste command arguments into target space and option flags
---@param args table vim.api.create_user_command callback table
---@return string? target, table opts
local function parse_paste_args(args)
	local opts = {
		raw = args.bang or false,
		before = false,
	}
	local target = nil

	for _, token in ipairs(args.fargs) do
		if token == "--before" then
			opts.before = true
		elseif token == "--raw" then
			opts.raw = true
		elseif not target then
			target = token
		else
			vim.notify(string.format("clip.nvim: unexpected argument %q", token), vim.log.levels.WARN)
		end
	end

	return target, opts
end

---@param arg_lead string
---@param cmd_line string
---@return string[]
local function complete_paste(arg_lead, cmd_line)
	local parts = vim.split(cmd_line, "%s+", { trimempty = true })
	table.remove(parts, 1)

	if not cmd_line:match("%s$") and #parts > 0 then
		table.remove(parts)
	end

	local has_target = false
	local used_flags = {}

	for _, part in ipairs(parts) do
		if vim.tbl_contains(PASTE_TARGETS, part) then
			has_target = true
		elseif vim.tbl_contains(PASTE_FLAGS, part) then
			used_flags[part] = true
		end
	end

	local candidates = {}

	if not has_target then
		vim.list_extend(candidates, PASTE_TARGETS)
	end

	for _, flag in ipairs(PASTE_FLAGS) do
		if not used_flags[flag] then
			table.insert(candidates, flag)
		end
	end

	return vim.tbl_filter(function(item)
		return vim.startswith(item, arg_lead)
	end, candidates)
end

---@param target string?
---@param opts table
local function run_paste(target, opts)
	local paste = require("clip.paste")

	if not target then
		paste.select(opts)
	elseif target == "local" then
		paste.from_local(opts)
	elseif target == "global" then
		paste.from_global(opts)
	elseif target == "host" then
		paste.from_host(opts)
	elseif target == "latest" then
		paste.latest(opts)
	elseif target == "blob" then
		paste.blob(opts)
	else
		vim.notify(
			string.format("clip.nvim: unknown paste target %q (expected: local, global, host, latest, blob)", target),
			vim.log.levels.ERROR
		)
		return
	end

	if target then
		_G.__clip_last_paste = function()
			run_paste(target, opts)
		end
		vim.go.operatorfunc = "v:lua.__clip_last_paste"
		pcall(vim.fn["repeat#set"], string.format(":Paste%s %s\r", opts.raw and "!" or "", target))
	end
end

function M.setup_yank()
	vim.api.nvim_create_user_command("Yank", function(args) end, {})
end

function M.setup_paste()
	vim.api.nvim_create_user_command("Paste", function(args)
		local target, opts = parse_paste_args(args)
		run_paste(target, opts)
	end, {
		nargs = "*",
		bang = true,
		range = true,
		desc = "Paste from clip.nvim spaces (local, global, host, latest, blob)",
		complete = complete_paste,
	})
end

return M
