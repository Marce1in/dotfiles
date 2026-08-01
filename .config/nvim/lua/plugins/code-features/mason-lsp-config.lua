return {
	"mason-org/mason-lspconfig.nvim",
	event = { "BufReadPre", "BufNewFile" },

	opts = {
		ensure_installed = { "vtsls", "vue_ls" },
		automatic_enable = {
			exclude = { "ts_ls" },
		},
	},
	config = function(_, opts)
		local vue_language_server_path = vim.fn.stdpath("data")
			.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
		local vue_plugin = {
			name = "@vue/typescript-plugin",
			location = vue_language_server_path,
			languages = { "vue" },
			configNamespace = "typescript",
		}

		vim.lsp.config("vtsls", {
			settings = {
				vtsls = {
					tsserver = {
						globalPlugins = {
							vue_plugin,
						},
					},
				},
			},
			filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
		})

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
