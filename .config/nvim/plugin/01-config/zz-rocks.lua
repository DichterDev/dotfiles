local rocks_location = vim.fn.stdpath("data") .. "/rocks"
local rocks_path = rocks_location .. "/share/lua/5.1/?.lua;" .. rocks_location .. "/share/lua/5.1/?/init.lua"
local rocks_cpath = rocks_location .. "/lib/lua/5.1/?.so"

package.path = package.path .. ";" .. rocks_path
package.cpath = package.cpath .. ";" .. rocks_cpath

local install_location = vim.fn.stdpath("data") .. "/site/pack/rocks/start/rocks.nvim"

if not vim.uv.fs_stat(install_location) then
	print("Bootstrapping rocks.nvim...")
	vim.fn.system({
		"git",
		"clone",
		"--depth=1",
		"https://github.com/nvim-neorocks/rocks.nvim.git",
		install_location,
	})
	vim.cmd("packadd rocks.nvim")

	vim.api.nvim_create_autocmd("User", {
		pattern = "RocksSetupFinished",
		callback = function()
			vim.cmd("Rocks sync")
		end,
	})
end
