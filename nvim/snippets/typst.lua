return {
	{
		function()
			return {
				prefix = "bold",
				body = "*$0*",
			}
		end,
	},
	{
		function()
			return {
				prefix = "italic",
				body = "_$0_",
			}
		end,
	},
	{
		function()
			return {
				prefix = "link",
				body = '#link("$1")[$0]',
			}
		end,
	},
	{
		function()
			return {
				prefix = "code",
				body = "```$1\n$0\n```",
			}
		end,
	},
	{
		function()
			return {
				prefix = "inline",
				body = "`$0`",
			}
		end,
	},
	{
		function()
			return {
				prefix = "icode",
				body = "```$1 $0```",
			}
		end,
	},
}
