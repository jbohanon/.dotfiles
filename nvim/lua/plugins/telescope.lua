local map = vim.api.nvim_set_keymap

require("telescope").load_extension("live_grep_args")

local tele = require('telescope.builtin')
local tele_ext = require('telescope').extensions

local telemap = function(cmd, cb)
    map('n', cmd, '', {
        noremap = true,
        silent = true,
        callback = cb,
    })
end

telemap('<Leader>ff', function() tele.find_files({ hidden = true, file_ignore_patterns = {'^.git'} }) end)

telemap('<Leader>fg', tele_ext.live_grep_args.live_grep_args)

telemap('<Leader>fb', tele.buffers)

telemap('<Leader>ft', tele.grep_string)

telemap('<Leader>tr', tele.treesitter)
