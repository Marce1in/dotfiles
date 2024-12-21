return {
    "echasnovski/mini.trailspace",

    event = "VeryLazy",

    opts = {},

    keys = {
        {"<leader>c<leader>", function () vim.cmd("lua MiniTrailspace.trim()") end}
    }
}
