return {
	"echasnovski/mini.starter",

	config = function()
		starter = require("mini.starter")

		starter.setup({
			header = "\n ____________\n< Neovim btw >\n ------------\n        \\   ^__^\n         \\  (oo)\\_______\n            (__)\\       )\\/\\\n                ||----w |\n                ||     ||\n",
			items = {
				starter.sections.sessions(5, true),
				function()
					return {
						{ name = "Yazi", action = "Yazi", section = "File explorer" },
						{ name = "Grep Telescope", action = "Telescope live_grep", section = "File explorer" },
						{ name = "Find Telescope", action = "Telescope fd", section = "File explorer" },
					}
				end,
				starter.sections.recent_files(5, false, false),
				starter.sections.builtin_actions(),
			},
			footer = "",
		})
	end,
}
