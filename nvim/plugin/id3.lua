PackAdd("gl:itaranto/id3.nvim")

-- Requires:
-- python-mutagen
-- flac

require("id3").setup({
	mp3_tool = "mid3v2",
	flac_tool = "metaflac",
})
