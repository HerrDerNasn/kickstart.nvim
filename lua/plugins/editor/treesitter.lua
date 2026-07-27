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

    -- Cache of available parsers (this list does not change during the session)
    local available_parsers = {}
    for _, p in ipairs(require('nvim-treesitter').get_available()) do
      available_parsers[p] = true
    end

    -- 2. Automatically enable Treesitter features for installed parsers
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter_setup', { clear = true }),
      callback = function(args)
        -- Check if a treesitter parser is registered/available for this filetype
        local lang = vim.treesitter.language.get_lang(args.match)
        if lang then
          -- Auto-install parser if supported but not installed
          local installed_parsers = require('nvim-treesitter').get_installed()
          local is_installed = vim.list_contains(installed_parsers, lang)

          if not is_installed and available_parsers[lang] then
            pcall(require('nvim-treesitter').install, lang)
          end

          -- Enable syntax highlighting
          pcall(vim.treesitter.start, args.buf, lang)

          -- Enable folds
          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo[0][0].foldmethod = 'expr'

          -- Start with all folds open
          vim.wo[0][0].foldlevel = 99

          -- Enable indentation
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
