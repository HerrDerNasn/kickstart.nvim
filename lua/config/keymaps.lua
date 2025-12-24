vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-Left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-Right>', '<C-w><C-l>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-Down>', '<C-w><C-j>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-Up>', '<C-w><C-k>', { desc = 'Move focus to the left window' })

vim.keymap.set('n', '<A-Left>', '<C-o>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Right>', '<C-i>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Up>', '{', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Down>', '}', { noremap = true, silent = true })

-- Remap uppercase commands to lowercase in command-line mode
vim.keymap.set('c', 'W', 'w', { remap = true })
vim.keymap.set('c', 'Q', 'q', { remap = true })
