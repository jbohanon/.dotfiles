local map = vim.api.nvim_set_keymap

local harp = require('harpoon.ui')

local harpmap = function(cmd, cb)
    map('n', cmd, '', {
        noremap = true,
        silent = true,
        callback = cb,
    })
end

local nav_file = function(n)
    return function()
        harp.nav_file(n)
    end
end

harpmap('<Leader>h', require('harpoon.mark').add_file)
harpmap('<Leader>fh', harp.toggle_quick_menu)
harpmap('<Leader>1', nav_file(1))
harpmap('<Leader>2', nav_file(2))
harpmap('<Leader>3', nav_file(3))
harpmap('<Leader>4', nav_file(4))
harpmap('<Leader>5', nav_file(5))
harpmap('<Leader>6', nav_file(6))
harpmap('<Leader>7', nav_file(7))
harpmap('<Leader>8', nav_file(8))
harpmap('<Leader>9', nav_file(9))
