return { -- Autocompletion
  'saghen/blink.cmp',
  dependencies = {
    'saghen/blink.lib',
    'rafamadriz/friendly-snippets',
  },
  build = function()
    require('blink.cmp').build():pwait()
  end,
  opts = {
    keymap = {
      preset = 'enter',
    },

    appearance = {
      nerd_font_variant = 'mono',
    },

    completion = {
      menu = { border = 'shadow' },
      documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = 'shadow' } },
      ghost_text = { enabled = true },
      keyword = {
        range = 'full',
      },
    },

    fuzzy = { implementation = 'rust' },

    signature = {
      enabled = true,
      window = { border = 'shadow' },
    },
  },
}
