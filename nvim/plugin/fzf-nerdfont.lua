Autocmd("PackChanged", "fzf-nerdfont-update", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind

		if name == "fzf-nerdfont" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("fzf-nerdfont")
			end
			vim.cmd("FzfNerdfont generate")
		end
	end,
})

require("fzf-nerdfont").setup({})
