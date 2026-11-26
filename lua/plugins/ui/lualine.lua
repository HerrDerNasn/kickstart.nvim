return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local function unsaved_buffers()
      local count = 0
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and vim.bo[buf].buftype == '' and vim.bo[buf].modified then
          count = count + 1
        end
      end
      if count == 0 then
        return ''
      end
      return '● ' .. count .. ' unsaved'
    end

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
        lualine_x = { { unsaved_buffers, color = 'DiagnosticWarn' } },
        lualine_y = { 'encoding', 'fileformat', 'filetype' },
        lualine_z = { { 'filename', separator = { right = '' }, left_padding = 2 } },
      },
    }
  end,
}
