return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    delay = 0,
    preset = 'modern',
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = vim.g.have_nerd_font,
      -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
      -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
      keys = vim.g.have_nerd_font and {},
    },

    -- Document existing key chains
    spec = {
      { '<leader>s', group = '[S]earch' },
      { '<leader>e', group = 'Nvim Tr[e]e' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>g', group = '[G]it', mode = { 'n' } },
      { '<leader>d', group = '[D]ebug' },
      { '<leader>q', group = 'Diagnostics' },
      { '<leader>l', group = '[L]sp' },
    },
  },
}
