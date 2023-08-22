vim.api.nvim_win_set_option(0, 'number', true)
vim.api.nvim_win_set_option(0, 'relativenumber', true)
vim.api.nvim_win_set_option(0, 'wrap', false)

vim.api.nvim_set_option('tabstop', 4)
vim.api.nvim_set_option('softtabstop', 4)
vim.api.nvim_set_option('shiftwidth', 4)
vim.api.nvim_set_option('expandtab', true)
vim.api.nvim_set_option('smartindent', true)
vim.api.nvim_set_option('termguicolors', true)
vim.api.nvim_set_option('scrolloff', 8)
vim.api.nvim_set_option('colorcolumn', "80,120")
vim.api.nvim_set_option('signcolumn', 'yes')
vim.api.nvim_set_option('cmdheight', 2)
vim.api.nvim_set_option('title', false)

vim.api.nvim_set_option('hlsearch', false)
vim.api.nvim_set_option('incsearch', true)
vim.api.nvim_set_option('hidden', true)
vim.api.nvim_set_option('errorbells', false)
vim.api.nvim_set_option('updatetime', 50)

vim.api.nvim_set_option('swapfile', false)
vim.api.nvim_set_option('backup', false)
vim.api.nvim_set_option('undofile', true)
vim.api.nvim_set_option('undodir', vim.fn.expand('~')..'/.vim/undodir')

-- Completion config
vim.api.nvim_set_option('completeopt', 'menu,menuone,noselect,noinsert,preview')
