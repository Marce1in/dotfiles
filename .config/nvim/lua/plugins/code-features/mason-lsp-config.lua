return {
    "mason-org/mason-lspconfig.nvim",
	event = "VeryLazy",

    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
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
		{ "ç", vim.lsp.buf.hover },
		{ "<leader>rn", vim.lsp.buf.rename },
	},
}
