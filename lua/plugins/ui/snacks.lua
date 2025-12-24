return {
  'folke/snacks.nvim',
  opts = {
    indent = { enabled = true },
    input = { enabled = true },
    statuscolumn = { enabled = true },
    lazygit = { enabled = true },
    git = { enabled = true },
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
  },
}
