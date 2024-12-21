return {
  'lewis6991/gitsigns.nvim',

  lazy = true,

  event = function ()
    return vim.fs.root(0, '.git') and { "BufReadPost" } or {}
  end,

  dependencies = {"tpope/vim-fugitive"},

  opts = {}
}
