return { -- Autocompletion
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    -- Snippet Engine
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
      opts = {},
    },
    'folke/lazydev.nvim',
  },
  opts = {
    keymap = {
      preset = 'enter',
    },

    appearance = {
      nerd_font_variant = 'mono',
    },

    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lsp = {
          transform_items = function(ctx, items)
            local filetype = vim.bo[ctx.buf].filetype
            for _, item in ipairs(items) do
              local label = item.label or ''
              local detail = item.detail or ''
              local doc = (type(item.documentation) == 'table' and item.documentation.value) or item.documentation or ''
              local label_desc = item.labelDetails and (item.labelDetails.description or item.labelDetails.detail) or ''

              -- Combine all text fields for classification
              local context_text = detail .. ' ' .. doc .. ' ' .. label_desc

              if filetype == 'java' then
                -- Prioritize java.util.List over java.awt.List
                if label == 'List' then
                  if context_text:find 'java%.util' then
                    item.score_offset = (item.score_offset or 0) + 100
                  elseif context_text:find 'java%.awt' then
                    item.score_offset = (item.score_offset or 0) - 100
                  end
                end
              end
            end
            return items
          end,
        },
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },

    snippets = { preset = 'luasnip' },

    fuzzy = { implementation = 'prefer_rust_with_warning' },

    signature = { enabled = true },
  },
}
