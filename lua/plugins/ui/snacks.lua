return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    indent = { enabled = true },
    input = { enabled = true, only_scope = true },
    statuscolumn = { enabled = true, folds = { open = true } },
    lazygit = { enabled = true },
    git = { enabled = true },
    words = { enabled = true, debounce = 10 },
    scroll = { enabled = true },
    scope = { enabled = true },
  },
  keys = {
    {
      '<leader>go',
      function()
        Snacks.lazygit.open()
      end,
      desc = '[O]pen lazy [G]it',
    },
    {
      '<leader>gb',
      function()
        Snacks.git.blame_line()
      end,
      desc = '[G]it log for line',
    },
    {
      ']]',
      function()
        Snacks.words.jump(1, true)
      end,
      desc = 'Next Reference',
      mode = { 'n', 't' },
    },
    {
      '[[',
      function()
        Snacks.words.jump(-1, true)
      end,
      desc = 'Prev Reference',
      mode = { 'n', 't' },
    },
  },
}
