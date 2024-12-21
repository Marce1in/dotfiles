return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",

        event = "VeryLazy",

        dependencies = { 'windwp/nvim-ts-autotag' },

        opts = {
            auto_install = true,

            highlight = {
                enable = true,
            },

            indent = {
                enable = true,
            },

            incremental_selection = {
                enable = false
            },

        }
    },
}
