vim.api.nvim_set_option_value('number', true, {win=0})
vim.api.nvim_set_option_value('relativenumber', true, {win=0})
vim.api.nvim_set_option_value('wrap', false, {win=0})

vim.api.nvim_set_option_value('tabstop', 4, {})
vim.api.nvim_set_option_value('softtabstop', 4, {})
vim.api.nvim_set_option_value('shiftwidth', 4, {})
vim.api.nvim_set_option_value('expandtab', true, {})
vim.api.nvim_set_option_value('smartindent', true, {})
vim.api.nvim_set_option_value('termguicolors', true, {})
vim.api.nvim_set_option_value('scrolloff', 8, {})
vim.api.nvim_set_option_value('colorcolumn', "80,120", {})
vim.api.nvim_set_option_value('signcolumn', 'yes', {})
vim.api.nvim_set_option_value('cmdheight', 2, {})
vim.api.nvim_set_option_value('title', false, {})

vim.api.nvim_set_option_value('hlsearch', false, {})
vim.api.nvim_set_option_value('incsearch', true, {})
vim.api.nvim_set_option_value('hidden', true, {})
vim.api.nvim_set_option_value('errorbells', false, {})
vim.api.nvim_set_option_value('updatetime', 50, {})

vim.api.nvim_set_option_value('swapfile', false, {})
vim.api.nvim_set_option_value('backup', false, {})
vim.api.nvim_set_option_value('undofile', true, {})
vim.api.nvim_set_option_value('undodir', vim.fn.expand('~')..'/.vim/undodir', {})

-- Completion config
vim.api.nvim_set_option_value('completeopt', 'menu,menuone,noselect,noinsert,preview', {})

-- Required for obsidian.nvim
vim.api.nvim_set_option_value('conceallevel', 1, {})
