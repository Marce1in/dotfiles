-- blade-php-fix.nvim
-- Provides proper treesitter injection queries for PHP in blade files
return {
  dir = "~/.config/nvim/lua/plugins/specific/laravel/blade-php-fix.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = {'blade', 'php'},
  opts = {},
}
