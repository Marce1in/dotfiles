return {
    'echasnovski/mini.files',

    lazy = true,

    opts = {
        mappings = {
            close = '-'
        }
    },
    keys = {
        { "-", mode = {"n", "v"}, function() require("mini.files").open() end},
    },
}
