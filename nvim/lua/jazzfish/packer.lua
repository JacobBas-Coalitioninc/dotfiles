local cmd = vim.cmd -- to exectue vim commands
cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

    -- TODO Maybe tryout undotree
    -- TODO Maybe tryout harpoon

    -- FILES AND INFORMATION -----------------------------------------------------------------
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-tree/nvim-tree.lua'
    use 'nvim-lualine/lualine.nvim' -- [x] for a nice status line

    -- GIT INTEGRATIONS ----------------------------------------------------------------------
    use 'tpope/vim-fugitive' -- [x] for working with Git
    use 'airblade/vim-gitgutter' -- [x] git gutter
    use 'sindrets/diffview.nvim' -- [x] for showing git diffs

    -- LANGUAGE SUPPORT ----------------------------------------------------------------------
    use 'sheerun/vim-polyglot' -- [x] syntax support
    use 'ray-x/go.nvim'
    use 'ray-x/guihua.lua'
    use 'rust-lang/rust.vim' -- [x] rust support

    -- LSP -----------------------------------------------------------------------------------
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }

    -- FUZZY FINDER --------------------------------------------------------------------------
    use 'nvim-lua/plenary.nvim' -- [x] for fuzzy finder
    use 'nvim-telescope/telescope.nvim' -- [x] for fuzzy finder
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use 'sharkdp/fd' -- [x] optional: finder
    use 'nvim-treesitter/nvim-treesitter' -- [x] optional: finder/preview
    use 'nvim-treesitter/playground' -- [x] for looking through tree-sitter output
    use 'nvim-lua/popup.nvim'
    use 'nvim-treesitter/nvim-treesitter-context'

    -- DIAGNOSTICS ---------------------------------------------------------------------------
    use 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' -- [x] better formatted lsp warnings
    use 'petertriho/nvim-scrollbar'

    -- NICE TO HAVES -------------------------------------------------------------------------
    use 'tpope/vim-commentary' -- [x] for easy comments within files
    use 'tpope/vim-surround' -- [x] for surrounding code
    use 'sbdchd/neoformat' -- [x] for autoformating code
    use 'folke/which-key.nvim' -- [x] completion for available keystrokes
    use 'folke/trouble.nvim' -- [x] workspace diagnostics
    use 'ggandor/lightspeed.nvim' -- [x[ for easy vim movements
    use 'danymat/neogen' -- [x] automatic docgenerator

    -- THEMES --------------------------------------------------------------------------------
    use "rebelot/kanagawa.nvim" -- [x] kanagawa
    use 'projekt0n/github-nvim-theme' -- [x] github theme
    use 'ellisonleao/gruvbox.nvim'
    use 'sainnhe/everforest' -- [x] everforest theme
    use 'folke/tokyonight.nvim'
    use 'catppuccin/nvim'

end)
