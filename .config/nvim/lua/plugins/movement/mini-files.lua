return {
    'echasnovski/mini.files',

    version = false,

    lazy = false,

    opts = {
        mappings = {
            close = '-'
        }
    },
    keys = {
        { "-", mode = { "n", "v"}, function() require("mini.files").open() end, desc = "File Manager" },
    },
}
