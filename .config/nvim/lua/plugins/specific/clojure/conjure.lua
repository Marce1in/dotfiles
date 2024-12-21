return {
    "Olical/conjure",
    ft = { "clojure" },

    lazy = true,

    dependencies = {
        'PaterJason/cmp-conjure',
        'radenling/vim-dispatch-neovim',
        'clojure-vim/vim-jack-in'
    },

    init = function()
        vim.g["conjure#eval#result_register"] = "*"
    end,
}
