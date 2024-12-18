return {
    "mistricky/codesnap.nvim",

    event = "VeryLazy",

    build = "make build_generator",
    opts = {
        bg_color = "#535c68",
        mac_window_bar = false,
        watermark = "",
        has_line_number = true,
        has_breadcrumps = true,
        show_workspace = true,
        code_font_family = "Hack Nerd Font",
        save_path = "~/Pictures"
    }
}
