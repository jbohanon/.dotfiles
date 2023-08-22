local map = vim.api.nvim_set_keymap

local noremap = function(ctx, keys, cmd, opts)
    opts = opts or {}
    opts['noremap'] = true
    opts['silent'] = true
    map(ctx, keys, cmd, opts)
end

local nnoremap = function(keys, cmd)
    noremap('n', keys, cmd, nil)
end
local tnoremap = function(keys, cmd)
    noremap('t', keys, cmd, nil)
end

vim.g.floaterm_wintype = 'split'
vim.g.floaterm_height  = 0.2
nnoremap('<F7>', ':FloatermNew<CR>')
tnoremap('<F7>', '<C-\\><C-n>:FloatermNew<CR>')
nnoremap('<F8>', ':FloatermPrev<CR>')
tnoremap('<F8>', '<C-\\><C-n>:FloatermPrev<CR>')
nnoremap('<F9>', ':FloatermNext<CR>')
tnoremap('<F9>', '<C-\\><C-n>:FloatermNext<CR>')
nnoremap('<F12>', ':FloatermToggle<CR>')
tnoremap('<F12>', '<C-\\><C-n>:FloatermToggle<CR>')
