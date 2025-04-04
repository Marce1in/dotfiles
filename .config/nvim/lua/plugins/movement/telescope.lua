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

	config = function()
		require("telescope").setup({

			defaults = {
				layout_strategy = "vertical",

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

			extensions = {

				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})
		require("telescope").load_extension("ui-select")
	end,

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
		{ "<leader>ca", mode = { "n", "v" }, vim.lsp.buf.code_action },
	},
}
