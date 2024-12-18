return {
  'saghen/blink.cmp',
  lazy = false,

  dependencies = {
    'rafamadriz/friendly-snippets',
    'iguanacucumber/magazine.nvim',
  },

  version = 'v0.*',

  event = "VeryLazy",

  opts = {
    keymap = {
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },

      ['<Tab>'] = { 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      ['<C-j>'] = { 'snippet_forward', 'fallback' },
      ['<C-k>'] = { 'snippet_backward', 'fallback' },

      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-o>'] = { 'select_next', 'fallback' },

      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "normal"
    },

    windows = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
        update_delay_ms = 50,

      },
    },

    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
      },

      trigger = {
        show_on_x_blocked_trigger_characters = { "'", '"', "(", "{", "`", "[" },
      },
    },

    signature = {
      enabled = true,
    },

  }
}
