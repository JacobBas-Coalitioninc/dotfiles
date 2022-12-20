-- checking to make sure that we have lazy.nvim installed into the correct place
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "--single-branch",
            "https://github.com/folke/lazy.nvim.git",
            lazypath,
        })
end
vim.opt.runtimepath:prepend(lazypath)

-- running the setup function to install all of the required plugins
require("lazy").setup({
        -- GENERAL ---------------------------------------------------------------------------
        { 'nvim-lua/plenary.nvim' },

        -- FILES AND INFORMATION -------------------------------------------------------------
        {
            'scrooloose/NERDTree',
            config = function()
                vim.cmd("let NERDTreeIgnore=[\'\\~$\', \'__pycache__\']")
            end,
        }, -- [x] file explorer
        { 'Xuyuanp/nerdtree-git-plugin' }, -- [x] git status within nerdtree
        { 'nvim-lualine/lualine.nvim' }, -- [x] for a nice status line

        -- GIT INTEGRATIONS ------------------------------------------------------------------
        { 'tpope/vim-fugitive' }, -- [x] for working with Git
        { 'airblade/vim-gitgutter' }, -- [x] git gutter
        { 'sindrets/diffview.nvim' }, -- [x] for showing git diffs

        -- LANGUAGE SUPPORT ------------------------------------------------------------------
        { 'sheerun/vim-polyglot' }, -- [x] syntax support
        {
            'ray-x/go.nvim',
            config = function()
                require('go').setup()

                -- Run gofmt + goimport on save
                vim.api.nvim_exec(
                    [[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]],
                    false
                    )
            end,
        },
        { 'ray-x/guihua.lua' },
        { 'rust-lang/rust.vim' }, -- [x] rust support

        -- LSP -------------------------------------------------------------------------------
        {
            'VonHeikemen/lsp-zero.nvim',
            dependencies = {
                -- LSP Support
                'neovim/nvim-lspconfig',
                'williamboman/mason.nvim',
                'williamboman/mason-lspconfig.nvim',

                -- Autocompletion
                'hrsh7th/nvim-cmp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'saadparwaiz1/cmp_luasnip',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-nvim-lua',

                -- Snippets
                'L3MON4D3/LuaSnip',
                'rafamadriz/friendly-snippets',
            },
        },

        -- FUZZY FINDER ----------------------------------------------------------------------
        { 'nvim-telescope/telescope.nvim' }, -- [x] for fuzzy finder
        { 'nvim-telescope/telescope-fzy-native.nvim' },
        { 'sharkdp/fd' },  -- [x] optional: finder
        { 'nvim-lua/popup.nvim' },

        -- TREE-SITTER -----------------------------------------------------------------------
        { 'nvim-treesitter/nvim-treesitter' }, -- [x] optional: finder/preview
        { 'nvim-treesitter/playground' }, -- [x] for looking through tree-sitter output
        { 'nvim-treesitter/nvim-treesitter-context' },

        -- DIAGNOSTICS -----------------------------------------------------------------------
        -- { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' }, -- [x] better formatted lsp warnings
        { 'petertriho/nvim-scrollbar' },

        -- NICE TO HAVES ---------------------------------------------------------------------
        { 'tpope/vim-commentary' }, -- [x] for easy comments within files
        { 'tpope/vim-surround' }, -- [x] for surrounding code
        { 'sbdchd/neoformat' }, -- [x] for autoformating code
        {
            'folke/which-key.nvim',
            config = function()
                require("which-key").setup{}
            end,
        }, -- [x] completion for available keystrokes
        { 'folke/trouble.nvim' }, -- [x] workspace diagnostics
        { 'ggandor/lightspeed.nvim' }, -- [x[ for easy vim movements
        { 'danymat/neogen' }, -- [x] automatic docgenerator

        -- THEMES ----------------------------------------------------------------------------
        { 'ellisonleao/gruvbox.nvim' },

        -- LEGENDARY -------------------------------------------------------------------------
        -- this should help in defining all of the different keymaps that are available within
        -- my current neovim setup
        {
            'mrjones2014/legendary.nvim',
            -- config = function()
            --     require("jazzfish.remap")()
            -- end,
        },
    })
