return {
	"saghen/blink.cmp",

	dependencies = {
		"rafamadriz/friendly-snippets",
		"saghen/blink.compat",
	},

	version = "1.*",

	event = "VeryLazy",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		sources = {
			default = {"blade", "laravel", "lazydev", "lsp", "buffer", "path" },

			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
				blade = {
					name = 'blade',
					module = "blade-nav.blink",
					opts = {
						close_tag_on_complete = true,
					},
					score_offset = 95,
				},
				laravel = {
					name = "laravel",
					module = "blink.compat.source",
					score_offset = 95,
				},
			},
		},

		keymap = {
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },

			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
			["<C-j>"] = { "snippet_forward", "fallback" },
			["<C-k>"] = { "snippet_backward", "fallback" },

			["<C-p>"] = { "select_prev", "fallback" },
			["<C-o>"] = { "select_next", "fallback" },

			["<Up>"] = { "scroll_documentation_up", "fallback" },
			["<Down>"] = { "scroll_documentation_down", "fallback" },
		},

		cmdline = {
			keymap = {
				["<C-e>"] = { "hide", "fallback" },
				["<CR>"] = { "accept", "fallback" },

				["<C-p>"] = { "select_prev", "fallback" },
				["<C-o>"] = { "select_next", "fallback" },
			},
		},

		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "normal",
		},

		completion = {
			menu = {
				border = "single",
			},

			documentation = {
				auto_show = true,
				auto_show_delay_ms = 0,

				window = {
					border = "single",
				},
			},

			trigger = {
				show_on_x_blocked_trigger_characters = { "'", '"', "(", "{", "`", "[" },
			},
		},

		signature = {
			enabled = true,

			window = {
				border = "single",
			},
		},
	},
}
