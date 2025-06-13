vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('n', '<leader>w', '<C-w>w')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>d', ':term mongosh<CR>i')
vim.keymap.set('n', '<leader>i', ':edit /home/theo/dev/devbase-components/src/utils/iconUtils.ts<CR>');
