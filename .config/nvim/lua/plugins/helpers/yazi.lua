return {
  "mikavilpas/yazi.nvim",

  event = "VeryLazy",

  keys = {
    { "-", "<cmd>Yazi<cr>", },
  },

  opts = {
    open_for_directories = true,
    keymaps = {
      show_help = '<f1>',
    },
  },
}
