imap jj <Esc>

set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nohlsearch
set hidden
set noerrorbells
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set colorcolumn=80,120
set signcolumn=yes
set cmdheight=2
set notitle
set updatetime=50
au ColorScheme * hi Normal guibg=none ctermbg=none
au ColorScheme * hi NonText guibg=none ctermbg=none

call plug#begin('~/.vim/plugged')

Plug 'voldikss/vim-floaterm'
Plug 'mbbill/undotree'
Plug 'wellle/context.vim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

Plug 'f-person/git-blame.nvim'

Plug 'gruvbox-community/gruvbox'

Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon'

Plug 'BurntSushi/ripgrep'

Plug 'sharkdp/fd'

Plug 'nvim-treesitter/nvim-treesitter'

Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

Plug 'nvim-telescope/telescope.nvim'

Plug 'airblade/vim-gitgutter'

Plug 'liuchengxu/vista.vim'

" Completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Go plugins
Plug 'fatih/vim-go'
Plug 'Shougo/neocomplete.vim'

Plug 'majutsushi/tagbar'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'ellisonleao/glow.nvim', {'branch': 'main'}
Plug 'tpope/vim-dispatch'
call plug#end()

let $GINKGO_EDITOR_INTEGRATION = "true"

lua require('nvim-tree').setup()

" Find files using Telescope command-line sugar.
let mapleader = " "
nnoremap <Leader>ff <cmd>lua require('telescope.builtin').find_files({hidden = true, file_ignore_patterns = {"^.git"}})<cr>
nnoremap <Leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <Leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <Leader>fh <cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>

nnoremap <Leader>err oif err != nil {<CR>return nil, err<CR>}<CR><esc>kkI<esc>
nnoremap <buffer> <silent> <C-[> :GoReferrers<cr>

nnoremap <Leader>q :bp\|bd #<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>n :bn<CR>
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>1 <cmd>lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <Leader>2 <cmd>lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <Leader>3 <cmd>lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <Leader>4 <cmd>lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <Leader>5 <cmd>lua require("harpoon.ui").nav_file(5)<CR>
nnoremap <Leader>6 <cmd>lua require("harpoon.ui").nav_file(6)<CR>
nnoremap <Leader>7 <cmd>lua require("harpoon.ui").nav_file(7)<CR>
nnoremap <Leader>8 <cmd>lua require("harpoon.ui").nav_file(8)<CR>
nnoremap <Leader>9 <cmd>lua require("harpoon.ui").nav_file(9)<CR>
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-h> <c-w><c-h>
nnoremap <c-l> <c-w><c-l>
tnoremap <c-j> <c-\><c-n><c-w><c-j>
tnoremap <c-k> <c-\><c-n><c-w><c-k>
tnoremap <c-h> <c-\><c-n><c-w><c-h>
tnoremap <c-l> <c-\><c-n><c-w><c-l>
tnoremap <Esc> <C-\><C-n>
nnoremap <Leader>ee :NvimTreeFindFileToggle<cr>
nnoremap <Leader>h <cmd>lua require("harpoon.mark").add_file()<cr>
nnoremap <Leader>/ :Commentary<cr>
vnoremap <Leader>/ :Commentary<cr>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

let g:floaterm_wintype='split'
let g:floaterm_height=0.2
nnoremap   <silent>   <F7>    :FloatermNew<CR>
tnoremap   <silent>   <F7>    <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <F8>    :FloatermPrev<CR>
tnoremap   <silent>   <F8>    <C-\><C-n>:FloatermPrev<CR>
nnoremap   <silent>   <F9>    :FloatermNext<CR>
tnoremap   <silent>   <F9>    <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   <F12>   :FloatermToggle<CR>
tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>

let mapleader = '\'
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader><Leader> :e ~/.config/nvim/init.vim<CR>

augroup jbohanon
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
augroup END

set laststatus=2
"set statusline=%{FugitiveStatusline()}
"set statusline+=\ %f
colorscheme gruvbox

" Go specific commands
filetype plugin indent on
set autowrite
" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
" Status line types/signatures
let g:go_auto_type_info = 1

" Airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Completion config
set completeopt=menu,menuone,noselect

lua << EOF
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
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
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
end
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig')['gopls'].setup{
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
EOF

lua <<EOF
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
EOF

lua << EOF
EOF
