return {
	"rachartier/tiny-code-action.nvim",
	lazy = true,

	opts = {
		picker = {
			"buffer",
			opts = {
				auto_preview = false, -- Enable or disable automatic preview
				auto_accept = false, -- Automatically accept the selected action
				position = "cursor", -- Position of the picker window
				winborder = "single", -- Border style for picker and preview windows
			},
		},
	},

	keys = {
		{
			"<leader>ca",
			mode = { "n", "v" },
			function()
				require("tiny-code-action").code_action()
			end,
		},
	},
}
