-- blade-php-fix.nvim
-- Provides proper treesitter injection queries for PHP in blade files
return {
  dir = "~/.config/nvim/lua/plugins/specific/laravel/blade-php-fix.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  -- Load early so queries are available before opening blade files
  lazy = false,
  priority = 100,
  opts = {},
}
