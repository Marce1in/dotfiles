return {
	"mason-org/mason-lspconfig.nvim",
	event = "VeryLazy",

	opts = {},
	config = function(_, opts)
		require("mason-lspconfig").setup(opts)
		-- Extend intelephense to support blade files
		vim.lsp.config("intelephense", {
			filetypes = { "php", "blade" },
			-- Tell intelephense that blade files are PHP
			get_language_id = function(_, filetype)
				if filetype == "blade" then
					return "php"
				end
				return filetype
			end,
			settings = {
				intelephense = {
					files = {
						associations = { "*.php", "*.blade.php" },
					},
				},
			},
		})
	end,
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {
				ui = {
					border = "single",
				},
			},
		},
		"neovim/nvim-lspconfig",
	},

	keys = {
		{ "ge", vim.lsp.buf.declaration },
		{ "gd", vim.lsp.buf.definition },
		{ "gi", vim.lsp.buf.implementation },
		{ "gf", vim.lsp.buf.format },
		{ "gr", vim.lsp.buf.references },
		{
			"H",
			function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end,
		},
		{
			"ç",
			function()
				vim.lsp.buf.hover({ border = "single" })
			end,
		},
		{ "<leader>rn", vim.lsp.buf.rename },
	},
}
