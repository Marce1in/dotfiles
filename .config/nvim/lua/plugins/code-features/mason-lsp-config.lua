return {
  "williamboman/mason-lspconfig.nvim",

  event = { "BufReadPre", "BufNewFile" },

  cmd = "Mason",

  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },

  config = function ()
    require("mason").setup()

    local mason_lsp = require("mason-lspconfig")
    local lsp_conf = require("lspconfig")
    local blink_cmp = require('blink.cmp').get_lsp_capabilities()

    mason_lsp.setup()

    mason_lsp.setup_handlers {

      -- Default handler
      function (server)
        lsp_conf[server].setup { capabilities = blink_cmp }
      end,

      -- Example of dedicated handlers for specific servers.
      -- ["rust_analyzer"] = function ()
      --     require("rust-tools").setup {}
      -- end
      --
      -- ["lua_ls"] = function ()
      --   local lspconfig = require("lspconfig")
      --   lspconfig.lua_ls.setup {
      --     settings = {
      --       Lua = {
      --         diagnostics = {
      --           globals = { "vim" }
      --         }
      --       }
      --     }
      --   }
    }


  end,

  keys = {
    { "ge", vim.lsp.buf.declaration },
    { "gd", vim.lsp.buf.definition },
    { "gi", vim.lsp.buf.implementation },
    { "gf", vim.lsp.buf.format },
    { "H", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end },
    { "ç", vim.lsp.buf.hover },
    { "<leader>rn", vim.lsp.buf.rename },
  },
}
