return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    indent = { enabled = true },
    input = { enabled = true },
    statuscolumn = { enabled = true, folds = { open = true } },
    lazygit = { enabled = true },
    git = { enabled = true },
    words = { enabled = true, debounce = 10 },
    scroll = { enabled = true },
    scope = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
  },
  config = function(_, opts)
    require('snacks').setup(opts)

    -- LSP Progress Notifications
    ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
    local progress = vim.defaulttable()
    vim.api.nvim_create_autocmd('LspProgress', {
      ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= 'table' then
          return
        end
        local p = progress[client.id]

        -- Filter out JDTLS validation and publish diagnostic spam from progress
        local title = value.title or ''
        local message = value.message or ''
        if title:find 'Publish diagnostics' or title:find 'Validate documents' or message:find 'Publish diagnostics' or message:find 'Validate documents' then
          return
        end

        for i = 1, #p + 1 do
          if i == #p + 1 or p[i].token == ev.data.params.token then
            p[i] = {
              token = ev.data.params.token,
              msg = ('[%3d%%] %s%s'):format(
                value.kind == 'end' and 100 or value.percentage or 100,
                value.title or '',
                value.message and (' **%s**'):format(value.message) or ''
              ),
              done = value.kind == 'end',
            }
            break
          end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
          return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
        vim.notify(table.concat(msg, '\n'), 'info', {
          id = 'lsp_progress',
          title = client.name,
          opts = function(notif)
            notif.icon = #progress[client.id] == 0 and ' ' or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          end,
        })
      end,
    })
  end,
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
    {
      ']]',
      function()
        Snacks.words.jump(1, true)
      end,
      desc = 'Next Reference',
      mode = { 'n', 't' },
    },
    {
      '[[',
      function()
        Snacks.words.jump(-1, true)
      end,
      desc = 'Prev Reference',
      mode = { 'n', 't' },
    },
    {
      '<leader>el',
      function()
        Snacks.notifier.show_history()
      end,
      desc = 'Open event [l]og',
    },
    {
      '<leader>ee',
      function()
        Snacks.notifier.show_history()
      end,
      desc = 'Open [e]rror log',
    },
    {
      '<leader>un',
      function()
        Snacks.notifier.hide()
      end,
      desc = 'Dismiss [N]otifications',
    },
  },
}
