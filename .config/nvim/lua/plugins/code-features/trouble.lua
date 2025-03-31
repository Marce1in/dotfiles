return {
	"folke/trouble.nvim",

	lazy = true,

	opts = {},

	cmd = "Trouble",

	keys = {
		{
		  "<leader>xx",
		  "<cmd>Trouble diagnostics toggle<cr>",
		  desc = "Diagnostics (Trouble)",
		},
		},
	}
}
