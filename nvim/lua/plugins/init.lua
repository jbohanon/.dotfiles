local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.vim/plugged')

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

Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' })

Plug('nvim-telescope/telescope-live-grep-args.nvim')

Plug 'nvim-telescope/telescope.nvim'

Plug 'airblade/vim-gitgutter'

Plug 'liuchengxu/vista.vim'

-- Completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

-- For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

-- Go plugins
Plug 'fatih/vim-go'
Plug 'Shougo/neocomplete.vim'

Plug 'majutsushi/tagbar'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug('ellisonleao/glow.nvim', { branch = 'main' })
Plug 'tpope/vim-dispatch'

Plug 'jamestthompson3/nvim-remote-containers'

Plug 'epwalsh/obsidian.nvim'

Plug 'ziglang/zig.vim'

vim.call('plug#end')

require("plugins/airline")
require("plugins/floaterm")
require("plugins/harpoon")
require("plugins/telescope")
require("plugins/treesitter")
require("plugins/nvim-cmp")
require("plugins/vim-go")
require("plugins/obsidian")
