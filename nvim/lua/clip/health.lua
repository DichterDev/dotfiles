-- lua/clip/health.lua
local M = {}

local health = vim.health

local function has_bin(bin)
	return vim.fn.executable(bin) == 1
end

local function check_neovim()
	health.start("Neovim Version")
	if vim.fn.has("nvim-0.10.0") == 1 then
		health.ok("Neovim >= 0.10.0 detected")
	else
		health.error("Neovim >= 0.10.0 is required (for vim.system, vim.uv, and vim.fs.relpath)")
	end
end

local function check_config()
	health.start("Configuration")
	local ok, clip = pcall(require, "clip")
	if not ok then
		health.error("Failed to require('clip'): " .. tostring(clip))
		return
	end

	local cfg = clip.config
	if type(cfg) ~= "table" then
		health.error("clip.config is missing or invalid")
		return
	end

	health.ok("clip.nvim module loaded")

	local valid_paths = { buf = true, cwd = true, abs = true }
	local fp = cfg.file_paste or {}
	if valid_paths[fp.path] then
		health.ok(string.format("file_paste.path = %q", fp.path))
	else
		health.warn(string.format("Invalid file_paste.path %q (expected 'buf', 'cwd', or 'abs')", tostring(fp.path)))
	end

	local valid_sub_paths = { inherit = true, buf = true, cwd = true, abs = true }
	for _, category in ipairs({ "media", "docs" }) do
		local sub = fp[category]
		if type(sub) == "table" then
			if valid_sub_paths[sub.path] then
				health.ok(string.format("file_paste.%s.path = %q", category, sub.path))
			else
				health.warn(
					string.format(
						"Invalid file_paste.%s.path %q (expected 'inherit', 'buf', 'cwd', or 'abs')",
						category,
						tostring(sub.path)
					)
				)
			end
		end
	end
end

local function check_host_clipboard()
	health.start("Host Clipboard & Image Blob Support")

	if vim.fn.has("clipboard") == 1 then
		health.ok("Neovim +clipboard feature is enabled")
	else
		health.warn("Neovim +clipboard feature is disabled; :Yank host and :Paste host text sync may fail")
	end

	if vim.env.WAYLAND_DISPLAY then
		health.info("Display server: Wayland")
		if has_bin("wl-paste") and has_bin("wl-copy") then
			health.ok("wl-clipboard (wl-copy / wl-paste) found — text and PNG blob pasting supported")
		else
			health.warn(
				"wl-copy / wl-paste not found on PATH",
				{ "Install 'wl-clipboard' to enable host clipboard sync and raw image pasting on Wayland" }
			)
		end
	elseif vim.fn.has("mac") == 1 then
		health.info("Platform: macOS")
		if has_bin("pbcopy") and has_bin("pbpaste") then
			health.ok("pbcopy / pbpaste found for text clipboard")
		else
			health.warn("pbcopy / pbpaste not found on PATH")
		end

		if has_bin("pngpaste") then
			health.ok("pngpaste found — raw image blob pasting supported")
		else
			health.warn("pngpaste not found on PATH", {
				"Install via 'brew install pngpaste' to enable pasting raw clipboard images (e.g., Firefox Copy Image)",
			})
		end
	elseif vim.fn.has("win32") == 1 then
		health.info("Platform: Windows")
		if has_bin("powershell") or has_bin("pwsh") then
			health.ok("PowerShell found — text and image blob pasting supported")
		else
			health.warn("PowerShell not found on PATH; raw image pasting will not work")
		end
	else
		health.info("Display server: X11 (or headless)")
		if has_bin("xclip") then
			health.ok("xclip found — text and PNG blob pasting supported")
		elseif has_bin("xsel") then
			health.warn(
				"xsel found (supports text, but lacks binary MIME target extraction)",
				{ "Install 'xclip' to enable pasting raw clipboard images on X11" }
			)
		else
			health.warn(
				"Neither xclip nor xsel found on PATH",
				{ "Install 'xclip' to enable host clipboard sync and raw image pasting on X11" }
			)
		end
	end
end

local function check_global_storage()
	health.start("Global Space Storage")
	local state_dir = vim.fn.stdpath("state")
	local stat = vim.uv.fs_stat(state_dir)

	if stat and stat.type == "directory" then
		if vim.fn.filewritable(state_dir) == 2 then
			health.ok(string.format("State directory is writable (%s)", state_dir))
		else
			health.error(string.format("State directory is not writable (%s)", state_dir))
		end
	else
		health.warn(string.format("State directory does not exist yet (%s)", state_dir))
	end
end

function M.check()
	check_neovim()
	check_config()
	check_host_clipboard()
	check_global_storage()
end

return M
