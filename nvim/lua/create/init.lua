local M = {}
local ui = require("create.ui")

M.config = {}

function M.setup(opts)
	opts = opts or {}
	M.config = vim.tbl_deep_extend("force", M.config, opts)

	vim.api.nvim_create_user_command("Create", function()
		M.open()
	end, {})
end

function M.open()
	ui.open(function(items)
		for _, item in ipairs(items) do
			local path = item.path
			local dir = vim.fn.fnamemodify(path, ":h")

			if dir ~= "." and vim.fn.isdirectory(dir) == 0 then
				vim.fn.mkdir(dir, "p")
			end

			if not path:match("/$") then
				local file = io.open(path, "w")
				if file then
					file:write("")
					file:close()
				end
			end
		end

		vim.notify(string.format("[create.nvim] Successfully created %d item(s).", #items))
	end)
end

return M
