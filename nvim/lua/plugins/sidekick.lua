-- Next Edit Suggestions need a Copilot subscription and copilot-language-server
require('sidekick').setup({
    nes = { enabled = false },
    cli = {
        tools = {
            -- Own terminal per Neovim. The built-in `opencode` tool attaches to any
            -- running opencode server (including the shared daemon) instead.
            oc = {
                cmd = { 'opencode' },
                env = { OPENCODE_THEME = 'system' },
                native_scroll = true,
            },
        },
    },
})

local cli = function() return require('sidekick.cli') end

vim.keymap.set('n', '<Leader>aa', function() cli().toggle({ name = 'oc', focus = true }) end, { desc = 'Sidekick toggle OpenCode' })
vim.keymap.set('n', '<Leader>as', function() cli().select() end, { desc = 'Sidekick select CLI' })
vim.keymap.set('n', '<Leader>ad', function() cli().close() end, { desc = 'Sidekick detach CLI' })
vim.keymap.set({ 'n', 'x' }, '<Leader>at', function() cli().send({ msg = '{this}' }) end, { desc = 'Sidekick send this' })
vim.keymap.set('n', '<Leader>af', function() cli().send({ msg = '{file}' }) end, { desc = 'Sidekick send file' })
vim.keymap.set('x', '<Leader>av', function() cli().send({ msg = '{selection}' }) end, { desc = 'Sidekick send selection' })
vim.keymap.set({ 'n', 'x' }, '<Leader>ap', function() cli().prompt() end, { desc = 'Sidekick select prompt' })
