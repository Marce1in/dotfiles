return {
	"mistricky/codesnap.nvim",

	lazy = true,

	cmd = "CodeSnap",

	version = 'v1.6.3',

	build = "make",
	opts = {
		bg_color = "#535c68",
		mac_window_bar = false,
		watermark = "",
		has_line_number = true,
		has_breadcrumbs = true,
		code_font_family = "Hack Nerd Font",
		save_path = "~/Pictures",
	},
}
