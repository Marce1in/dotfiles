return {
	"saghen/blink.cmp",

	dependencies = {
		"rafamadriz/friendly-snippets",
		"iguanacucumber/magazine.nvim",
		"xzbdmw/colorful-menu.nvim",
	},

	version = "1.*",

	event = "VeryLazy",

	opts = {
		keymap = {
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },

			-- ["<Tab>"] = { "snippet_forward", "fallback" },
			-- ["<S-Tab>"] = { "snippet_backward", "fallback" },
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
				draw = {
					columns = { { "kind_icon" }, { "label", gap = 1 } },
					components = {
						label = {
							text = function(ctx)
								return require("colorful-menu").blink_components_text(ctx)
							end,
							highlight = function(ctx)
								return require("colorful-menu").blink_components_highlight(ctx)
							end,
						},
					},
				},
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
		},
	},
}
