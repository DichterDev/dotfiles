local animate = require("mini.animate")

animate.setup({
	scroll = {
		enable = false,

		timing = animate.gen_timing.cubic({
			easing = "out",
			duration = 80,
			unit = "total",
		}),

		subscroll = animate.gen_subscroll.equal({
			max_output_steps = 60,
			predicate = function(total_scroll)
				local max_animated_lines = vim.api.nvim_win_get_height(0) * 1.5
				local abs_scroll = math.abs(total_scroll)
				if abs_scroll > max_animated_lines then
					return false
				end

				return abs_scroll > 3
			end,
		}),
	},
	resize = { enable = false },
	open = { enable = false },
	close = { enable = false },
})
