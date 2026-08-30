return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim', 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('neo-tree').setup {
        clipboard = {
          sync = 'global',
        },
        use_popups_for_input = false,
        filesystem = {
          follow_current_file = {
            enabled = true,
          },
          group_empty_dirs = true,
          scan_mode = 'deep',
          window = {
            mappings = {
              ['o'] = function(state)
                local node = state.tree:get_node()
                local path = node:get_id()
                if node.type ~= 'directory' then
                  path = vim.fs.dirname(path)
                end
                vim.fn.system(string.format('tmux new-window -c %s', vim.fn.shellescape(path)))
              end,
            },
          },
        },
      }
      vim.keymap.set('n', '<leader>tt', ':Neotree filesystem toggle focus reveal right<CR>', { desc = 'Toggle file tree' })
      vim.keymap.set('n', '<leader>tf', ':Neotree filesystem focus reveal right<CR>', { desc = 'Focus file tree' })
    end,
  },
  {
    'antosha417/nvim-lsp-file-operations',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neo-tree/neo-tree.nvim', -- makes sure that this loads after Neo-tree.
    },
    config = function()
      require('lsp-file-operations').setup()
    end,
  },
  {
    's1n7ax/nvim-window-picker',
    version = '2.*',
    config = function()
      require('window-picker').setup {
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
            -- if the buffer type is one of following, the window will be ignored
            buftype = { 'terminal', 'quickfix' },
          },
        },
      }
    end,
  },
}
