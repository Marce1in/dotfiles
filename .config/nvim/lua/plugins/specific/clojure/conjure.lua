return {
    "Olical/conjure",
    ft = { "clojure" }, -- etc
    lazy = true,
    init = function()
        vim.g["conjure#eval#result_register"] = "*"
    end,
}
