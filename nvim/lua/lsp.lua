local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<space>dd', require 'telescope.builtin'.diagnostics, opts)
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
vim.keymap.set('n', '<space>dl', vim.diagnostic.setloclist, opts)

local on_attach = function(_, bufnr)
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', require 'telescope.builtin'.lsp_type_definitions, bufopts)
    vim.keymap.set('n', 'gd', require 'telescope.builtin'.lsp_definitions, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', require 'telescope.builtin'.lsp_implementations, bufopts)
    vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', require 'telescope.builtin'.lsp_references, bufopts)
    vim.keymap.set('n', '<space>f', function()
        require('conform').format({ bufnr = bufnr, lsp_format = 'fallback' })
    end, bufopts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

vim.lsp.config('*', {
    on_attach = on_attach,
    capabilities = capabilities,
})

vim.lsp.config('gopls', {
    settings = {
        gopls = {
            templateExtensions = { 'gotmpl', 'gohtml' },
        }
    },
    filetypes = { "go", "gomod", "gowork", "gotmpl", "gohtml", "gohtmltmpl" },
})

vim.lsp.config('rust_analyzer', {
    settings = {
        ['rust-analyzer'] = {
            check = { command = 'clippy' },
            checkOnSave = true,
        }
    },
})

vim.lsp.config('lua_ls', {
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if (vim.uv or vim.loop).fs_stat(path .. '/.luarc.json') or (vim.uv or vim.loop).fs_stat(path .. '/.luarc.jsonc') then
            return
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                version = 'LuaJIT'
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                }
            }
        })
    end,
    settings = {
        Lua = {}
    }
})

vim.lsp.enable({
    'gopls',
    'rust_analyzer',
    'ts_ls',
    'bashls',
    'lua_ls',
    'protols',
    'copilot',
})
