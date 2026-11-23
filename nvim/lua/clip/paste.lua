-- lua/clip/paste.lua
local M = {}

---@alias clip.Space "local" | "global" | "host"
---@alias clip.PathMode "inherit" | "buf" | "cwd" | "abs"
---@alias clip.FallbackMode "path" | "content" | "copy" | "prompt"

---@class clip.Entry
---@field text string
---@field regtype string "v" | "V" | "\22"
---@field timestamp? number

-- Lazy getters to avoid circular requires with clip.init and clip.registry
local function get_config()
	return require("clip").config
end

local function get_registry()
	local ok, reg = pcall(require, "clip.registry")
	if ok then
		return reg
	end
	return nil
end

--- Resolve "inherit" against the parent file_paste.path setting
---@param mode clip.PathMode?
---@param fallback "buf" | "cwd" | "abs"
---@return "buf" | "cwd" | "abs"
local function resolve_mode(mode, fallback)
	if not mode or mode == "inherit" then
		return fallback or "cwd"
	end
	return mode
end

--- Resolve base directory for "buf" or "cwd"
---@param mode "buf" | "cwd" | "abs"
---@param bufnr integer
---@return string
local function get_base_dir(mode, bufnr)
	if mode == "buf" then
		local bufname = vim.api.nvim_buf_get_name(bufnr)
		if bufname ~= "" then
			return vim.fn.fnamemodify(bufname, ":p:h")
		end
	end
	return vim.uv.cwd() or vim.fn.getcwd()
end

--- Format a filepath according to "buf" | "cwd" | "abs"
---@param filepath string
---@param mode "buf" | "cwd" | "abs"
---@param bufnr integer
---@return string
local function format_insert_path(filepath, mode, bufnr)
	local abs = vim.fn.fnamemodify(filepath, ":p")
	if mode == "abs" then
		return abs
	end
	local base = get_base_dir(mode, bufnr)
	local rel = vim.fs.relpath(base, abs)
	return rel or abs
end

--- Find matching category config (e.g. media, docs) in file_paste by file extension
---@param ext string
---@param file_cfg table
---@return table? cat_cfg, string? cat_name
local function match_category(ext, file_cfg)
	if not ext or ext == "" then
		return nil, nil
	end
	ext = ext:lower()

	for key, val in pairs(file_cfg) do
		if type(val) == "table" and type(val.exts) == "table" then
			if vim.tbl_contains(val.exts, ext) then
				return val, key
			end
		end
	end
	return nil, nil
end

--- Render filetype template ("%p" = formatted path, "%s" = file stem)
---@param filepath string
---@param insert_path string
---@param cat_cfg table?
---@param bufnr integer
---@return string
local function render_template(filepath, insert_path, cat_cfg, bufnr)
	local ft = vim.bo[bufnr].filetype
	local tmpl = cat_cfg and cat_cfg.templates and cat_cfg.templates[ft]
	if not tmpl then
		return insert_path
	end

	local stem = vim.fn.fnamemodify(filepath, ":t:r")
	local out = tmpl:gsub("%%p", function()
		return insert_path
	end)
	out = out:gsub("%%s", function()
		return stem
	end)
	return out
end

--- Normalize a raw string into an existing file path on disk (handles file:// URIs)
---@param raw string?
---@return string?
local function resolve_existing_file(raw)
	if not raw or raw == "" then
		return nil
	end
	local trimmed = vim.trim(raw)
	if trimmed:find("\n") then
		return nil
	end

	if trimmed:match("^file://") then
		trimmed = trimmed:gsub("^file://", ""):gsub("%%(%x%x)", function(hex)
			return string.char(tonumber(hex, 16))
		end)
	end

	local expanded = vim.fn.expand(trimmed)
	local stat = vim.uv.fs_stat(expanded)
	if stat and stat.type == "file" then
		return vim.fn.fnamemodify(expanded, ":p")
	end
	return nil
end

--- Insert text into the target buffer, supporting smart_indent and before/after cursor
---@param text string
---@param regtype string
---@param opts? { before?: boolean, bufnr?: integer, winid?: integer, smart_indent?: boolean }
local function insert_text(text, regtype, opts)
	opts = opts or {}
	local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
	local winid = opts.winid or vim.api.nvim_get_current_win()
	local cfg = get_config()
	local smart_indent = opts.smart_indent ~= nil and opts.smart_indent or cfg.smart_indent

	if not vim.api.nvim_buf_is_valid(bufnr) then
		return
	end

	-- Ensure target window is active if still valid
	if vim.api.nvim_win_is_valid(winid) and vim.api.nvim_get_current_win() ~= winid then
		vim.api.nvim_set_current_win(winid)
	end

	-- If visual mode is active, send replaced selection to void register first
	local mode = vim.api.nvim_get_mode().mode
	if mode:match("^[vV\22]") then
		vim.cmd('normal! "_d')
	end

	local lines = vim.split(text, "\n", { plain = true })
	if #lines > 1 and lines[#lines] == "" and regtype == "V" then
		table.remove(lines)
	end

	-- Use temporary unnamed register via nvim_put so Neovim records a dot-repeatable change
	local saved_reg = vim.fn.getreg('"')
	local saved_type = vim.fn.getregtype('"')

	vim.fn.setreg('"', lines, regtype or "v")
	local after = not opts.before
	vim.api.nvim_put(lines, regtype or "v", after, true)

	if smart_indent and (regtype == "V" or #lines > 1) then
		vim.cmd("silent! normal! '[=']")
	end

	vim.fn.setreg('"', saved_reg, saved_type)
end

--- Check if the OS host clipboard currently contains binary image/png data
---@param cb fun(has_image: boolean)
local function host_has_png(cb)
	if vim.env.WAYLAND_DISPLAY then
		vim.system({ "wl-paste", "--list-types" }, { text = true }, function(res)
			vim.schedule(function()
				cb(res.code == 0 and res.stdout ~= nil and res.stdout:find("image/png", 1, true) ~= nil)
			end)
		end)
	elseif vim.fn.has("mac") == 1 then
		vim.system({ "osascript", "-e", "clipboard info" }, { text = true }, function(res)
			vim.schedule(function()
				cb(
					res.code == 0
						and res.stdout ~= nil
						and (res.stdout:find("PNGf", 1, true) ~= nil or res.stdout:find("TIFF", 1, true) ~= nil)
				)
			end)
		end)
	elseif vim.fn.has("win32") == 1 then
		vim.system(
			{ "powershell", "-NoProfile", "-Command", "[System.Windows.Forms.Clipboard]::ContainsImage()" },
			{ text = true },
			function(res)
				vim.schedule(function()
					cb(res.code == 0 and res.stdout ~= nil and vim.trim(res.stdout):lower() == "true")
				end)
			end
		)
	else
		vim.system({ "xclip", "-selection", "clipboard", "-t", "TARGETS", "-o" }, { text = true }, function(res)
			vim.schedule(function()
				cb(res.code == 0 and res.stdout ~= nil and res.stdout:find("image/png", 1, true) ~= nil)
			end)
		end)
	end
end

--- Extract PNG bytes from OS host clipboard and save to dest_path
---@param dest_path string
---@param cb fun(ok: boolean)
local function extract_host_png(dest_path, cb)
	local cmd
	if vim.env.WAYLAND_DISPLAY then
		cmd = { "wl-paste", "--no-newline", "--type", "image/png" }
	elseif vim.fn.has("mac") == 1 then
		cmd = { "pngpaste", dest_path }
	elseif vim.fn.has("win32") == 1 then
		cmd = {
			"powershell",
			"-NoProfile",
			"-Command",
			string.format("(Get-Clipboard -Format Image).Save('%s', 'Png')", dest_path:gsub("'", "''")),
		}
	else
		cmd = { "xclip", "-selection", "clipboard", "-t", "image/png", "-o" }
	end

	vim.system(cmd, { text = false }, function(res)
		vim.schedule(function()
			if res.code ~= 0 then
				cb(false)
				return
			end

			if cmd[1] == "wl-paste" or cmd[1] == "xclip" then
				if not res.stdout or #res.stdout == 0 then
					cb(false)
					return
				end
				local fd = vim.uv.fs_open(dest_path, "w", 438) -- 0666
				if not fd then
					cb(false)
					return
				end
				vim.uv.fs_write(fd, res.stdout)
				vim.uv.fs_close(fd)
			end

			local stat = vim.uv.fs_stat(dest_path)
			cb(stat ~= nil and stat.size > 0)
		end)
	end)
end

--- Resolve filename generator (supports fun(): string or "inherit")
---@param cat_cfg table?
---@return string
local function generate_filename(cat_cfg)
	if cat_cfg and type(cat_cfg.filename) == "function" then
		return tostring(cat_cfg.filename())
	end
	return tostring(os.date("%Y-%m-%d_%H-%M-%S"))
end

--- Handle pasting an existing file path according to file_paste rules
---@param src_path string
---@param opts? { before?: boolean, bufnr?: integer, winid?: integer }
local function handle_file_paste(src_path, opts)
	opts = opts or {}
	local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
	local cfg = get_config()
	local file_cfg = cfg.file_paste or {}
	local ext = vim.fn.fnamemodify(src_path, ":e")
	local cat_cfg = match_category(ext, file_cfg)
	local mode = resolve_mode(cat_cfg and cat_cfg.path, file_cfg.path)

	-- Matched category (media, docs, or user-defined category)
	if cat_cfg then
		local final_path = src_path
		if cat_cfg.target then
			local base_dir = get_base_dir(mode, bufnr)
			local target_dir = vim.fs.joinpath(base_dir, cat_cfg.target)
			vim.fn.mkdir(target_dir, "p")

			local dest_path = vim.fs.joinpath(target_dir, vim.fn.fnamemodify(src_path, ":t"))
			if dest_path ~= src_path then
				vim.uv.fs_copyfile(src_path, dest_path)
			end
			final_path = dest_path
		end

		local insert_path = format_insert_path(final_path, mode, bufnr)
		local rendered = render_template(final_path, insert_path, cat_cfg, bufnr)
		insert_text(rendered, "v", opts)
		return
	end

	-- General file not matched by media/docs -> use file_paste.fallback
	local fallback = file_cfg.fallback or "path"

	local function apply_fallback(action)
		if action == "content" then
			local lines = vim.fn.readfile(src_path)
			insert_text(table.concat(lines, "\n"), "V", opts)
		elseif action == "copy" then
			local base_dir = get_base_dir(mode, bufnr)
			local dest_path = vim.fs.joinpath(base_dir, vim.fn.fnamemodify(src_path, ":t"))
			if dest_path ~= src_path then
				vim.uv.fs_copyfile(src_path, dest_path)
			end
			local insert_path = format_insert_path(dest_path, mode, bufnr)
			insert_text(insert_path, "v", opts)
		else -- "path"
			local insert_path = format_insert_path(src_path, mode, bufnr)
			insert_text(insert_path, "v", opts)
		end
	end

	if fallback == "prompt" then
		vim.ui.select({ "path", "content", "copy" }, {
			prompt = string.format("Paste file (%s):", vim.fn.fnamemodify(src_path, ":t")),
			format_item = function(item)
				if item == "path" then
					return "Insert formatted path"
				elseif item == "content" then
					return "Insert file contents"
				elseif item == "copy" then
					return "Copy file to target directory & insert path"
				end
				return item
			end,
		}, function(choice)
			if choice then
				apply_fallback(choice)
			end
		end)
	else
		apply_fallback(fallback)
	end
end

--- Paste binary image blob from OS clipboard into media.target and insert template/path
---@param opts? { before?: boolean, bufnr?: integer, winid?: integer, prompt?: boolean }
function M.blob(opts)
	opts = opts or {}
	local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
	local winid = opts.winid or vim.api.nvim_get_current_win()
	local cfg = get_config()
	local file_cfg = cfg.file_paste or {}
	local media_cfg = file_cfg.media or {}

	local default_stem = generate_filename(media_cfg)
	local should_prompt = opts.prompt ~= nil and opts.prompt or (media_cfg.prompt_name ~= false)

	local function finalize(stem)
		if not stem or vim.trim(stem) == "" then
			return
		end
		stem = vim.trim(stem)
		-- Strip .png if user typed it in the prompt
		stem = stem:gsub("%.png$", "")

		local mode = resolve_mode(media_cfg.path, file_cfg.path)
		local base_dir = get_base_dir(mode, bufnr)
		local target_dir = media_cfg.target and vim.fs.joinpath(base_dir, media_cfg.target) or base_dir
		vim.fn.mkdir(target_dir, "p")

		local dest_path = vim.fs.joinpath(target_dir, stem .. ".png")

		extract_host_png(dest_path, function(ok)
			if not ok then
				vim.notify("clip.nvim: failed to extract image from host clipboard", vim.log.levels.WARN)
				return
			end

			local insert_path = format_insert_path(dest_path, mode, bufnr)
			local rendered = render_template(dest_path, insert_path, media_cfg, bufnr)
			insert_text(rendered, "v", {
				before = opts.before,
				bufnr = bufnr,
				winid = winid,
				smart_indent = false,
			})
		end)
	end

	if should_prompt then
		vim.ui.input({ prompt = "Image name (png): ", default = default_stem }, finalize)
	else
		finalize(default_stem)
	end
end

--- Paste a resolved clipboard entry (or detect file/blob)
---@param entry clip.Entry?
---@param opts? { before?: boolean, raw?: boolean, bufnr?: integer, winid?: integer }
local function paste_entry(entry, opts)
	opts = opts or {}
	if not entry or not entry.text or entry.text == "" then
		return
	end

	if not opts.raw then
		local file_path = resolve_existing_file(entry.text)
		if file_path then
			handle_file_paste(file_path, opts)
			return
		end
	end

	insert_text(entry.text, entry.regtype or "v", opts)
end

--- Paste from `local` space
---@param opts? { before?: boolean, raw?: boolean }
function M.from_local(opts)
	local reg = get_registry()
	local entry = reg and reg.get("local") or nil
	if not entry then
		vim.notify("clip.nvim: local clipboard is empty", vim.log.levels.INFO)
		return
	end
	paste_entry(entry, opts)
end

--- Paste from `global` space
---@param opts? { before?: boolean, raw?: boolean }
function M.from_global(opts)
	local reg = get_registry()
	local entry = reg and reg.get("global") or nil
	if not entry then
		vim.notify("clip.nvim: global clipboard is empty", vim.log.levels.INFO)
		return
	end
	paste_entry(entry, opts)
end

function M.from_host(opts)
	opts = opts or {}
	opts.bufnr = vim.api.nvim_get_current_buf()
	opts.winid = vim.api.nvim_get_current_win()

	local function paste_host_text()
		local text = vim.fn.getreg("+")
		local regtype = vim.fn.getregtype("+")
		if not text or text == "" then
			vim.notify("clip.nvim: host clipboard is empty", vim.log.levels.INFO)
			return
		end
		paste_entry({ text = text, regtype = regtype }, opts)
	end

	if opts.raw then
		paste_host_text()
		return
	end

	host_has_png(function(has_img)
		if has_img then
			M.blob(opts)
		else
			paste_host_text()
		end
	end)
end

--- Paste from whichever space was updated most recently (`local`, `global`, or `host`)
---@param opts? { before?: boolean, raw?: boolean }
function M.latest(opts)
	local reg = get_registry()
	local latest_space = reg and reg.latest_space() or "local"

	if latest_space == "host" then
		M.from_host(opts)
	elseif latest_space == "global" then
		M.from_global(opts)
	else
		M.from_local(opts)
	end
end

--- Interactive picker (`:Paste` with no args) across local, global, and host spaces
---@param opts? { before?: boolean, raw?: boolean }
function M.select(opts)
	local reg = get_registry()
	local items = {}

	local local_entry = reg and reg.get("local")
	if local_entry and local_entry.text ~= "" then
		table.insert(items, { space = "local", entry = local_entry })
	end

	local global_entry = reg and reg.get("global")
	if global_entry and global_entry.text ~= "" then
		table.insert(items, { space = "global", entry = global_entry })
	end

	local host_text = vim.fn.getreg("+")
	if host_text and host_text ~= "" then
		table.insert(items, {
			space = "host",
			entry = { text = host_text, regtype = vim.fn.getregtype("+") },
		})
	end

	if #items == 0 then
		-- Fall back to checking if host has a binary image blob
		host_has_png(function(has_img)
			if has_img then
				M.blob(opts)
			else
				vim.notify("clip.nvim: all clipboard spaces are empty", vim.log.levels.INFO)
			end
		end)
		return
	end

	vim.ui.select(items, {
		prompt = "Paste from clipboard space:",
		format_item = function(item)
			local preview = item.entry.text:gsub("\n", " ↵ ")
			if #preview > 60 then
				preview = preview:sub(1, 57) .. "..."
			end
			return string.format("[%s] %s", item.space, preview)
		end,
	}, function(choice)
		if not choice then
			return
		end
		if choice.space == "host" then
			M.from_host(opts)
		elseif choice.space == "global" then
			M.from_global(opts)
		else
			M.from_local(opts)
		end
	end)
end

return M
