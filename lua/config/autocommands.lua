vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'Bufread' }, {
  pattern = '*.java',
  callback = function()
    local filepath = vim.fn.expand '%:p'
    local class_name = vim.fn.expand('%:t'):gsub('%.java$', '')

    -- Only proceed if the buffer is empty
    if vim.fn.line '$' > 1 or vim.fn.getline(1) ~= '' then
      return
    end

    local lines = {}

    -- Match Maven-style paths
    local package_path = nil

    for _, base in ipairs { '/src/main/java/', '/src/test/java/' } do
      local index = filepath:find(base, 1, true)
      if index then
        package_path = filepath:sub(index + #base)
        package_path = package_path:match '(.*/)' or ''
        package_path = package_path:gsub('/', '.'):gsub('%.$', '')
        break
      end
    end

    -- Insert package line if detected
    if package_path then
      table.insert(lines, 'package ' .. package_path .. ';')
      table.insert(lines, '') -- blank line
    end

    -- Insert public class stub
    table.insert(lines, 'public class ' .. class_name .. ' {')
    table.insert(lines, '')
    table.insert(lines, '}')

    vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)

    -- Move cursor inside class
    vim.api.nvim_win_set_cursor(0, { #lines - 1, 0 })
  end,
})
