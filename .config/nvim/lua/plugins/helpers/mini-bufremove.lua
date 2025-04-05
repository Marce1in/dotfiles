return {
    'echasnovski/mini.bufremove',

    opts = {},

    keys = {
        {"<C-w>D", function () vim.cmd("lua MiniBufremove.unshow()") end},
    },
}
