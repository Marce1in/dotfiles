return {
	"epwalsh/obsidian.nvim",

	opts = {
        ui = { enable = false },
		workspaces = {
			{
				name = "vault",
				path = "~/.vault",
			},
		},
	},

	ft = { "markdown" },
}
