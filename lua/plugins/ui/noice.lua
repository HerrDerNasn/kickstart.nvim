return {
  -- lazy.nvim
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      views = {
        cmdline_popup = {
          position = {
            row = -2,
            col = '50%',
          },
        },
        cmdline_popupmenu = {
          position = {
            row = -5,
            col = '50%',
          },
        },
      },
      routes = {
        {
          filter = {
            event = 'notify',
            kind = 'info',
            any = {
              { find = 'hidden' },
            },
          },
          opts = { skip = true },
        },
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- { 'rcarriga/nvim-notify', opts = { top_down = false } },
    },
  },
}
