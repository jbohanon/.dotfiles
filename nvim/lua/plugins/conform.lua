local prettier = { 'prettier' }

require('conform').setup({
    formatters_by_ft = {
        typescript = prettier,
        typescriptreact = prettier,
        javascript = prettier,
        javascriptreact = prettier,
        json = prettier,
        rust = { 'rustfmt', lsp_format = 'fallback' },
    },
})
