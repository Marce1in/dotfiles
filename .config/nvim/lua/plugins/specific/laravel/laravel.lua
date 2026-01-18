return {
  "adalessa/laravel.nvim",
  ft = "php",
  dependencies = {
    "tpope/vim-dotenv",
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-neotest/nvim-nio",
  },
  cmd = { "Laravel" },
  keys = {
    {
      "gi",
      function()
        local ok, res = pcall(function()
          if Laravel.app("gf").cursorOnResource() then
            return "<cmd>lua Laravel.commands.run('gf')<cr>"
          end
        end)
        if not ok or not res then
          return "gf"
        end
        return res
      end,
      expr = true,
      noremap = true,
    },
  },
  opts = {
    lsp_server = "intelephense", -- "phpactor | intelephense"
    features = {
      pickers = {
        provider = "telescope", -- "snacks | telescope | fzf-lua | ui-select"
      },
    },
  },
}
