local M = {}

local timer = vim.uv.new_timer()

local function update_scrolloff()
	local height = vim.api.nvim_win_get_height(0)
	vim.opt_local.scrolloff = math.floor(height * 0.25)
end

function M.setup()
	Autocmd({ "VimResized", "WinResized", "BufEnter", "WinEnter" }, "scrolloff", {
		callback = function()
			if timer then
				timer:stop()
				timer:start(50, 0, vim.schedule_wrap(update_scrolloff))
			end
		end,
	})
end

return M
