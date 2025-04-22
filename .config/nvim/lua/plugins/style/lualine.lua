return {
	"nvim-lualine/lualine.nvim",

	event = "VeryLazy",

	opts = {
		sections = {
			lualine_c = {
				{
					"filename",
					status = true,
					path = 1,
				},
			},
			lualine_x = {
				"none",
			},
			lualine_y = {
				"none",
			},
			lualine_z = {
				"none",
			},
		},

		options = {
			theme = function()
				local t = require("lualine.themes.gruvbox")
				t.normal.c.bg = "#101010"
				t.normal.b.bg = "#101010"

				t.visual.b.bg = "#101010"
				t.visual.c.bg = "#101010"

				t.visual.b.fg = "#fbf1c7"
				t.visual.c.fg = "#fbf1c7"

				t.command.b.bg = "#101010"
				t.command.c.bg = "#101010"

				t.command.b.fg = "#fbf1c7"
				t.command.c.fg = "#fbf1c7"

				t.replace.c.bg = "#101010"
				t.replace.b.bg = "#101010"

				t.insert.b.bg = "#101010"
				t.insert.c.bg = "#101010"

				t.inactive.b.bg = "#101010"
				return t
			end,
		},
	},
}
