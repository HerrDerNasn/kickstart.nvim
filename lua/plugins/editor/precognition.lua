return {
  'tris203/precognition.nvim',
  event = 'VeryLazy',
  opts = {
    startVisible = false,
  },
  keys = {
    {
      '<leader>tp',
      function()
        if require('precognition').toggle() then
          vim.notify 'Precognition ON'
        else
          vim.notify 'Precognition OFF'
        end
      end,
      desc = '[T]oggle [P]recognition',
    },
  },
}
