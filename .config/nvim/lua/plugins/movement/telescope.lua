return {
	"nvim-telescope/telescope.nvim",

	lazy = true,

	dependencies = {
		"nvim-telescope/telescope-ui-select.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		},
	},

	opts = {
		defaults = {
			layout_strategy = "vertical",

			borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },

			mappings = {
				n = {
					[" "] = "toggle_selection",
					["<C-d>"] = "delete_buffer",
					["<C-s>"] = "file_split",
					["<C-x>"] = false,
				},
				i = {
					["<C-d>"] = "delete_buffer",
					["<C-s>"] = "file_split",
					["<C-x>"] = false,
				},
			},
		},
	},

	cmd = "Telescope",

	keys = {
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files()
			end,
		},
		{
			"<leader>fg",
			function()
				require("telescope.builtin").live_grep()
			end,
		},
		{
			"<leader>fb",
			function()
				require("telescope.builtin").buffers()
			end,
		},
		{
			"<leader>fh",
			function()
				require("telescope.builtin").help_tags()
			end,
		},
		{
			"<leader>fr",
			function()
				require("telescope.builtin").lsp_references()
			end,
		},
	},
}
