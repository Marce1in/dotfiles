return {
	"echasnovski/mini.move",

	lazy = true,

	opts = {
		mappings = {
			-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
			left = "H",
			right = "L",
			down = "J",
			up = "K",

			-- Move current line in Normal mode
			line_left = "H",
			line_right = "L",
			line_down = "",
			line_up = "",
		},
	},

	keys = {
		{ "H" },
		{ "L" },

		{ "H", mode = "v" },
		{ "L", mode = "v" },
		{ "J", mode = "v" },
		{ "K", mode = "v" },
	},
}
