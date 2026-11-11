local M = {}

local util = require("skeleton.util")

--- skeleton.nvim
--- Usage
---
--- Integrations
--- create.nvim
--- :Create foo.lua:module:init

M.config = {
	templates = {
		dir = vim.fn.stdpath("config") .. "/templates",
		ft = {
			lua = {
				default = "",
				module = {
					body = "local M = {}\n\n$0\n\nreturn M",
					init = {
						body = "M.config = {}\n\nfunction M.setup(opts)\n\topts = opts or {}\n\tM.config = vim.tbl_deep_extend('force', M.config, opts)\nend",
					},
				},
			},
			java = {
				default = "class",
				class = {
					inherit = true,
					public = {
						body = "public class §1 {\n\t$0\n}",
						inject = function(ctx)
							return { ctx.filename }
						end,
					},
				},
				body = "§1\n\n$0",
				inject = function(ctx, buf)
					return { util.java.package(buf) }
				end,
			},
		},
	},
}

function M.setup(opts)
	opts = opts or {}
	M.config = vim.tbl_deep_extend("force", M.config, opts)
end

return M
