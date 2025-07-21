return {
	{
		"nvimtools/none-ls.nvim",
		event = "VeryLazy",

		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.code_actions.gitsigns,
				},
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = "VeryLazy",

		opts = {
			handlers = {},
		},
	},
}
