local themegroup = vim.api.nvim_create_augroup('themegroup', { clear = true })

vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = "*",
    group = themegroup,
    command = "hi Normal guibg=none ctermbg=none",
})
vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = "*",
    group = themegroup,
    command = "hi NonText guibg=none ctermbg=none",
})
vim.api.nvim_set_option('laststatus', 2)
vim.cmd('colorscheme gruvbox')
