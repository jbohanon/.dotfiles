local gh = function(repo)
    return 'https://github.com/' .. repo
end

vim.pack.add({
    gh('voldikss/vim-floaterm'),
    gh('mbbill/undotree'),
    gh('wellle/context.vim'),

    gh('tpope/vim-fugitive'),
    gh('tpope/vim-commentary'),
    gh('tpope/vim-surround'),
    gh('tpope/vim-dispatch'),

    gh('f-person/git-blame.nvim'),
    gh('lewis6991/gitsigns.nvim'),
    gh('sindrets/diffview.nvim'),
    gh('pwntester/octo.nvim'),

    gh('gruvbox-community/gruvbox'),

    gh('nvim-lua/plenary.nvim'),
    gh('ThePrimeagen/harpoon'),

    gh('nvim-treesitter/nvim-treesitter'),

    gh('nvim-telescope/telescope.nvim'),
    gh('nvim-telescope/telescope-live-grep-args.nvim'),

    -- Completion
    gh('neovim/nvim-lspconfig'),
    gh('hrsh7th/nvim-cmp'),
    gh('hrsh7th/cmp-nvim-lsp'),
    gh('hrsh7th/cmp-buffer'),
    gh('hrsh7th/cmp-path'),
    gh('hrsh7th/cmp-cmdline'),
    gh('hrsh7th/cmp-vsnip'),
    gh('hrsh7th/vim-vsnip'),

    gh('fatih/vim-go'),
    gh('stevearc/conform.nvim'),

    gh('vim-airline/vim-airline'),
    gh('vim-airline/vim-airline-themes'),
    gh('nvim-tree/nvim-web-devicons'),
    gh('nvim-tree/nvim-tree.lua'),
    { src = gh('ellisonleao/glow.nvim'), version = 'main' },

    gh('jamestthompson3/nvim-remote-containers'),
    gh('folke/sidekick.nvim'),
    gh('github/copilot.vim'),
})

require("plugins/airline")
require("plugins/floaterm")
require("plugins/harpoon")
require("plugins/telescope")
require("plugins/treesitter")
require("plugins/nvim-cmp")
require("plugins/vim-go")
require("plugins/sidekick")
require("plugins/conform")
require("plugins/review")
