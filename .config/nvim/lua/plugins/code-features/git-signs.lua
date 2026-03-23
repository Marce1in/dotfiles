return {
	"lewis6991/gitsigns.nvim",

	event = function()
		return vim.fs.root(0, ".git") and { "BufReadPost" } or {}
	end,

	opts = {},
}
