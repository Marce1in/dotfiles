---@type LazySpec
return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	dependencies = { "folke/snacks.nvim", lazy = true },
	keys = {
		{
			"_",
			mode = { "n", "v" },
			"<cmd>Yazi<cr>",
			desc = "Open yazi at the current file",
		},
		{
			"<leader>_",
			"<cmd>Yazi cwd<cr>",
			desc = "Open the file manager in nvim's working directory",
		},
		{
			"-",
			"<cmd>Yazi toggle<cr>",
			desc = "Resume the last yazi session",
		},
	},

	---@type YaziConfig | {}
	opts = {
		open_for_directories = true,
		yazi_floating_window_border = "single",
		keymaps = {
			show_help = "<f1>",
			grep_in_directory = "<c-x>",
			open_file_in_horizontal_split = "<c-s>",
		},
	},

	init = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
}
