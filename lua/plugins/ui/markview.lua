return {
  'OXY2DEV/markview.nvim',
  lazy = false, -- Recommended by author to prevent slow initial loads
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  init = function()
    -- Disable line wrapping for previewed filetypes to prevent tables from breaking/wrapping weirdly
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'markdown', 'asciidoc', 'typst', 'latex', 'tex', 'rmd' },
      callback = function()
        vim.opt_local.wrap = false
      end,
    })
  end,
  keys = {
    { '<leader>mt', '<cmd>Markview Toggle<cr>', desc = '[T]oggle Markview (Global)' },
    { '<leader>mb', '<cmd>Markview toggle<cr>', desc = 'Toggle [B]uffer Markview' },
    { '<leader>me', '<cmd>Markview Enable<cr>', desc = '[E]nable Markview' },
    { '<leader>md', '<cmd>Markview Disable<cr>', desc = '[D]isable Markview' },
    { '<leader>ms', '<cmd>Markview splitToggle<cr>', desc = 'Toggle [S]plitview' },
    { '<leader>mh', '<cmd>Markview HybridToggle<cr>', desc = 'Toggle [H]ybrid mode' },
  },
  opts = {
    preview = {
      filetypes = { 'markdown', 'quarto', 'rmd', 'typst', 'asciidoc' },
      ignore_buftypes = {},
    },
    markdown = {
      tables = {
        strict = true, -- Render borders exactly where pipes (|) are, bypassing empty cell parsing bugs
      },
    },
  },
}
