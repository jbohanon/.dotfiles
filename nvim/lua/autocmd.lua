vim.api.nvim_create_augroup('jbohanon', {clear=true})
-- vim.api.nvim_create_autocmd('BufWritePre', {
--     pattern = '*',
--     group = 'jbohanon',
--     command = '%s/\\s\\+$//e',
-- })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'yaml','cpp'},
    group = 'jbohanon',
    command = 'setlocal tabstop=2 softtabstop=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>',
})
