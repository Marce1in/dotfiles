return {
	"williamboman/mason-lspconfig.nvim",

	event = { "BufReadPre", "BufNewFile" },

	cmd = "Mason",

	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
	},

	config = function()
		require("mason").setup()

		local mason_lsp = require("mason-lspconfig")
		local lsp_conf = require("lspconfig")

		mason_lsp.setup()
	end,

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
