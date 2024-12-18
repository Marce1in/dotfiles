return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',

    event = "VeryLazy",

    dependencies = {
        'nvim-telescope/telescope-ui-select.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
        },

    },


    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

        require("telescope").setup {

            defaults = {
                layout_strategy = "vertical",

                layout_config = {
                    height = 0.95,
                    prompt_position = "bottom",
                    vertical = {
                        preview_cutoff = 0,
                    }
                },

                mappings = {
                    n = {
                        [" "] = "toggle_selection",
                    }
                },

            },

            extensions = {

                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {}
                },
            }
        }
            require('telescope').load_extension('ui-select')

    end
}
