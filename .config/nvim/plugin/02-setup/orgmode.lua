local gh = require("util").pack.gh

vim.pack.add({
	gh("nvim-orgmode/orgmode"),
	gh("nvim-orgmode/org-bullets.nvim"),
})

require("orgmode").setup({
	org_agenda_files = "~/notes/**/*",
	org_default_notes_file = "~/notes/refile.org",
})

require("org-bullets").setup({})
