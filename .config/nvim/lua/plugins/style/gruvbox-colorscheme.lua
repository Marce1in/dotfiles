return {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    priority = 1000,

    lazy = false,

    opts = {
        palette_overrides = {
            dark0 = "#000000", -- #282828
            dark1 = "#000000", -- #3c3836
            dark2 = "#101010", -- #504945
            -- dark3 = "#202020", -- #665c54
            -- dark4 = "#101010", -- #7c6f64
        },

        overrides = {
            ["@tag"] = {fg = "#fb4934"},
        }
    },
}
