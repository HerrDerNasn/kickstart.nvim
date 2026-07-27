return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ts = require 'nvim-treesitter'

    -- 1. Define and install your preferred parsers
    local parsers = {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
    }
    ts.install(parsers)

    -- 2. Automatically enable Treesitter features for installed parsers
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter_setup', { clear = true }),
      callback = function(args)
        -- Check if a treesitter parser is registered/available for this filetype
        local lang = vim.treesitter.language.get_lang(args.match)
        if lang then
          -- Enable syntax highlighting
          vim.treesitter.start()

          -- Enable folds
          vim.wo[0][0].folexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo[0][0].foldmethod = 'expr'

          -- Enable indentation
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
