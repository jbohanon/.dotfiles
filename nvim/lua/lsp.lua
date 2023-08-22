-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<space>dd', require'telescope.builtin'.diagnostics, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>dl', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  --vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gD', require'telescope.builtin'.lsp_type_definitions, bufopts)
  --vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gd', require'telescope.builtin'.lsp_definitions, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', require'telescope.builtin'.lsp_implementations, bufopts)
  vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  --vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gr', require'telescope.builtin'.lsp_references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
end
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig')['gopls'].setup{
    settings = {
        gopls = {
            templateExtensions = {'gotmpl', 'gohtml'},
        }
    },
    filetypes = { "go", "gomod", "gowork", "gotmpl", "gohtml", "gohtmltmpl" },
    on_attach = on_attach,
    capabilities = capabilities,
}
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
require('lspconfig')['clangd'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
require('lspconfig')['bashls'].setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
