return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        component_separators = '',
        section_separators = { left = '', right = '' },
        ignore_focus = { 'neo-tree' },
        globalstatus = true,
      },
      sections = {
        lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'location' },
        lualine_x = {},
        lualine_y = { 'encoding', 'fileformat', 'filetype' },
        lualine_z = { { 'filename', separator = { right = '' }, left_padding = 2 } },
      },
    }
  end,
}
