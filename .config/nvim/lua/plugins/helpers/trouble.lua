return {
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
			},
		},
	},
	{
		"artemave/workspace-diagnostics.nvim",

		keys = {
			{
				"<leader>XX",
				function()
					vim.notify("Bomb has been planted")
					for _, client in ipairs(vim.lsp.get_clients()) do
						require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
					end
				end,
			},
		},
	},
}
