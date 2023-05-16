local map = vim.api.nvim_set_keymap

local tele = require('telescope.builtin')

local telemap = function(cmd, cb)
    map('n', cmd, '', {
        noremap = true,
        silent = true,
        callback = cb,
    })
end

telemap('<Leader>ff', function() tele.find_files({ hidden = true, file_ignore_patterns = {'^.git'} }) end)

telemap('<Leader>fg', tele.live_grep)

telemap('<Leader>fb', tele.buffers)

telemap('<Leader>ft', tele.grep_string)

telemap('<Leader>tr', tele.treesitter)
