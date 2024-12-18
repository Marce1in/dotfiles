return {
    'nanotee/sqls.nvim',
    ft = { "sql" },
    lazy = true,

    config = function ()
        require('lspconfig').sqls.setup {
            on_attach = function(client, bufnr)
                require('sqls').on_attach(client, bufnr)
            end
        }
    end
}
