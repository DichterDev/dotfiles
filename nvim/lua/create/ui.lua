local parser = require("create.parser")

local M = {}

local state = {
	input_buf = nil,
	input_win = nil,
	preview_buf = nil,
	preview_win = nil,
	parsed_items = {},
}

--- Build an ASCII tree representation from a list of relative paths
--- @param paths string[]
--- @return string[] tree_lines
local function build_tree(paths)
	if #paths == 0 then
		return { " (empty)" }
	end

	-- Construct nested table hierarchy
	local root = {}
	for _, path in ipairs(paths) do
		local current = root
		for segment in path:gmatch("[^/]+") do
			current[segment] = current[segment] or {}
			current = current[segment]
		end
	end

	-- Recursive tree line builder
	local lines = {}
	local function render_node(node, prefix)
		-- Gather and sort keys (directories/files)
		local keys = {}
		for k in pairs(node) do
			table.insert(keys, k)
		end
		table.sort(keys, function(a, b)
			local a_is_dir = next(node[a]) ~= nil
			local b_is_dir = next(node[b]) ~= nil
			if a_is_dir ~= b_is_dir then
				return a_is_dir -- Directories first
			end
			return a < b
		end)

		local count = #keys
		for idx, key in ipairs(keys) do
			local is_last = (idx == count)
			local connector = is_last and "└── " or "├── "
			local child_prefix = prefix .. (is_last and "    " or "│   ")
			local is_dir = next(node[key]) ~= nil

			local display_name = is_dir and (key .. "/") or key
			table.insert(lines, prefix .. connector .. display_name)

			if is_dir then
				render_node(node[key], child_prefix)
			end
		end
	end

	render_node(root, "")
	return lines
end

--- Re-evaluates input buffer lines top-to-bottom and updates preview window
local function update_preview()
	if not vim.api.nvim_buf_is_valid(state.input_buf) or not vim.api.nvim_buf_is_valid(state.preview_buf) then
		return
	end

	local lines = vim.api.nvim_buf_get_lines(state.input_buf, 0, -1, false)
	local all_paths = {}
	local parsed_results = {}

	for _, line in ipairs(lines) do
		local trimmed = line:match("^%s*(.-)%s*$")
		if trimmed ~= "" and not trimmed:match("^#") then
			local parsed = parser.parse(trimmed)
			for _, item in ipairs(parsed) do
				table.insert(all_paths, item.path)
				table.insert(parsed_results, item)
			end
		end
	end

	state.parsed_items = parsed_results

	-- Render tree to preview buffer
	local tree_lines = build_tree(all_paths)
	vim.bo[state.preview_buf].modifiable = true
	vim.api.nvim_buf_set_lines(state.preview_buf, 0, -1, false, tree_lines)
	vim.bo[state.preview_buf].modifiable = false
end

--- Opens confirmation floating window before writing files
local function confirm_creation(on_confirm)
	local buf = vim.api.nvim_create_buf(false, true)
	local width = 46
	local height = 4

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = math.floor((vim.o.lines - height) / 2),
		col = math.floor((vim.o.columns - width) / 2),
		style = "minimal",
		border = "rounded",
		title = " Create Files? ",
		title_pos = "center",
	})

	local count = #state.parsed_items
	local content = {
		"",
		string.format("  Create %d file(s) / dir(s)?", count),
		"  [y] Yes    [n/Esc] Cancel",
	}

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
	vim.bo[buf].modifiable = false

	local close = function()
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end

	vim.keymap.set("n", "y", function()
		close()
		on_confirm()
	end, { buffer = buf, nowait = true })

	vim.keymap.set("n", "n", close, { buffer = buf, nowait = true })
	vim.keymap.set("n", "<Esc>", close, { buffer = buf, nowait = true })
end

--- Opens the dual-window interface
--- @param on_write function Callback executed when user confirms file creation
function M.open(on_write)
	-- 1. Create preview buffer & window (Right)
	vim.cmd("vnew")
	state.preview_win = vim.api.nvim_get_current_win()
	state.preview_buf = vim.api.nvim_get_current_buf()

	vim.bo[state.preview_buf].buftype = "nofile"
	vim.bo[state.preview_buf].bufhidden = "wipe"
	vim.bo[state.preview_buf].filetype = "create_preview"
	vim.wo[state.preview_win].number = false
	vim.wo[state.preview_win].relativenumber = false

	-- 2. Create input buffer & window (Left)
	vim.cmd("wincmd h")
	state.input_win = vim.api.nvim_get_current_win()
	state.input_buf = vim.api.nvim_create_buf(true, false)
	vim.api.nvim_win_set_buf(state.input_win, state.input_buf)

	vim.bo[state.input_buf].buftype = "acwrite"
	vim.bo[state.input_buf].filetype = "create_input"
	vim.api.nvim_buf_set_name(state.input_buf, "[Create Workspace]")

	-- 3. Attach reactive event listeners
	local augroup = vim.api.nvim_create_augroup("CreateNvimLive", { clear = true })

	vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
		group = augroup,
		buffer = state.input_buf,
		callback = update_preview,
	})

	-- Intercept buffer write (:w)
	vim.api.nvim_create_autocmd("BufWriteCmd", {
		group = augroup,
		buffer = state.input_buf,
		callback = function()
			if #state.parsed_items == 0 then
				vim.notify("[create.nvim] No paths to create.", vim.log.levels.WARN)
				return
			end

			confirm_creation(function()
				on_write(state.parsed_items)
				-- Close input & preview windows on success
				if vim.api.nvim_win_is_valid(state.input_win) then
					vim.api.nvim_win_close(state.input_win, true)
				end
				if vim.api.nvim_win_is_valid(state.preview_win) then
					vim.api.nvim_win_close(state.preview_win, true)
				end
			end)
		end,
	})

	update_preview()
end

return M
