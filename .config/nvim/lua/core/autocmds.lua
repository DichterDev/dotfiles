Autocmd = vim.api.nvim_create_autocmd

function Augroup(name)
	return vim.api.nvim_create_augroup("dichter_" .. name, { clear = true })
end

-- Highlight on yank
Autocmd("TextYankPost", {
	group = Augroup("highlight_yank"),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

-- resize splits if window got resized
Autocmd({ "VimResized" }, {
	group = Augroup("resize_split"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- close lsp servers on vim close
-- this should not be required
-- but some java lsps stay open
Autocmd({ "VimLeave" }, {
	group = Augroup("lsp_close"),
	callback = function()
		for _, client in ipairs(vim.lsp.get_clients()) do
			client.stop(client, true)
		end
	end,
})

Autocmd({ "BufEnter" }, {
	group = Augroup("text_wrapping"),
	pattern = { "typst", "markdown", "text" },
	callback = function()
		vim.o.wrap = true
	end,
})

Autocmd({ "LspProgress" }, {
	group = Augroup("lsp_progress"),
	callback = function(ev)
		local value = ev.data.params.value
		vim.api.nvim_echo({ { value.message or "done" } }, false, {
			id = "lsp." .. ev.data.client_id,
			kind = "progress",
			source = "vim.lsp",
			title = value.title,
			status = value.kind ~= "end" and "running" or "success",
			percent = value.percentage,
		})
	end,
})
