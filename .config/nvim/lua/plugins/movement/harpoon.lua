return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",

	lazy = true,

	dependencies = { "nvim-lua/plenary.nvim" },

	opts = {
		settings = {
			save_on_toggle = true,
			mark_branch = true,
		},
	},

	keys = {
		{
			"<C-a>",
			function()
				require("harpoon"):list():add()
			end,
		},
		{
			"<leader>h",
			function()
				require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
			end,
		},

		{
			"<C-h>",
			function()
				require("harpoon"):list():select(1)
			end,
		},
		{
			"<C-j>",
			function()
				require("harpoon"):list():select(2)
			end,
		},
		{
			"<C-k>",
			function()
				require("harpoon"):list():select(3)
			end,
		},
		{
			"<C-l>",
			function()
				require("harpoon"):list():select(4)
			end,
		},
	},
}
