return {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    priority = 1000,

    lazy = false,

    opts = {
        palette_overrides = {
            dark0 = "#000000",
            dark1 = "#000000",
            dark2 = "#101010",
            dark3 = "#101010",
            dark4 = "#101010",
        },

        overrides = {
            ["@tag"] = {fg = "#fb4934"}
        }
    },
}

