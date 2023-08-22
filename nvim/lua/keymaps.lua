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
local vnoremap = function(keys, cmd)
    noremap('v', keys, cmd, nil)
end

-- For plugin-specific keymaps, see that plugin's file in lua/plugins/

map('i', 'jj', '<Esc>', {})

nnoremap('<Leader>q', ':bp|bd #<CR>')
nnoremap('<Leader>w', ':w<CR>')
nnoremap('<Leader>n', ':bn<CR>')
nnoremap('<Leader>b', ':bp<CR>')

nnoremap('<c-j>', '<c-w><c-j>')
nnoremap('<c-k>', '<c-w><c-k>')
nnoremap('<c-h>', '<c-w><c-h>')
nnoremap('<c-l>', '<c-w><c-l>')

tnoremap('<c-j>', '<c-\\><c-n><c-w><c-j>')
tnoremap('<c-k>', '<c-\\><c-n><c-w><c-k>')
tnoremap('<c-h>', '<c-\\><c-n><c-w><c-h>')
tnoremap('<c-l>', '<c-\\><c-n><c-w><c-l>')
tnoremap('<Esc>', '<c-\\><c-n>')

vnoremap('J', ':m \'>+1<CR>gv=gv')
vnoremap('K', ':m \'<-2<CR>gv=gv')

nnoremap('<Leader>ee', ':NvimTreeFindFileToggle<cr>')
vnoremap('<Leader>/', ':Commentary<cr>')

-- golang error handling
nnoremap('<Leader>err', 'oif err != nil {<CR>return nil, err<CR>}<CR><esc>kkI<esc>')
