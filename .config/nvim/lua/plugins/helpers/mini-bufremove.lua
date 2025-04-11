return {
	"echasnovski/mini.bufremove",

	opts = {},

	keys = {
		{
			"<C-d>",
			function()
				vim.cmd("lua MiniBufremove.delete()")
			end,
		},
	},
}
