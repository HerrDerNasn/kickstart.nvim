return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_after_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          lsp_format = 'fallback',
        }
      end
    end,
    formatters = {
      palantir = {
        command = '/root/.sdkman/candidates/java/current/bin/java',
        args = {
          '-jar',
          vim.fn.expand '~/.local/share/java/palantir.jar',
          '--palantir',
          '-',
        },
      },
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      html = { 'prettier' },
      htmlangular = { 'prettier' },
      css = { 'prettier' },
      scss = { 'prettier' },
      sass = { 'prettier' },
      json = { 'prettier' },
      markdown = { 'prettier' },
      yamlfmt = { 'prettier' },
      java = { 'palantir' },
      python = { 'ruff' },
      sql = { 'sqruff' },
    },
  },
}
