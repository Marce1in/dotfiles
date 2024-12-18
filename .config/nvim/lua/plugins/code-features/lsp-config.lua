return {
    'neovim/nvim-lspconfig',
    event = "VeryLazy",

    config = function()
        local cap = require('blink.cmp').get_lsp_capabilities()
        local lsp = require('lspconfig')

        lsp.lua_ls.setup { capabilities = cap }
        lsp.clangd.setup { capabilities = cap }
        lsp.html.setup { capabilities = cap }
        lsp.cssls.setup { capabilities = cap }
        lsp.tailwindcss.setup { capabilities = cap }
        lsp.ts_ls.setup { capabilities = cap }
        lsp.dockerls.setup { capabilities = cap }
        lsp.pyright.setup { capabilities = cap }
        lsp.clojure_lsp.setup { capabilities = cap }
        lsp.sqls.setup { capabilities = cap }
        lsp.jdtls.setup { capabilities = cap }
        lsp.prismals.setup { capabilities = cap }
        lsp.bashls.setup { capabilities = cap }
        lsp.eslint.setup { capabilities = cap }
        lsp.elixirls.setup { capabilities = cap, cmd = { "elixir-ls" } }
        lsp.solargraph.setup { capabilities = cap }
        lsp.cobol_ls.setup { capabilities = cap }
        lsp.zls.setup { capabilities = cap }
        lsp.asm_lsp.setup { capabilities = cap }
        lsp.phpactor.setup { capabilities = cap }
        lsp.elp.setup { capabilities = cap }
        lsp.rust_analyzer.setup { capabilities = cap }
        lsp.arduino_language_server.setup { capabilities = cap }

        vim.keymap.set('n', 'ge', vim.lsp.buf.declaration, {})
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
        vim.keymap.set('n', 'gf', vim.lsp.buf.format, {})
        vim.keymap.set('n', 'H', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, {})
        vim.keymap.set('n', 'ç', vim.lsp.buf.hover, {})
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {})
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, {})
    end
}
