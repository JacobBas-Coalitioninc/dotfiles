local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- running the setup function to install all of the required plugins
require("lazy").setup({
    ---------------------------------------------------------------------------------------- 
    ---- GENERAL ---------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------- 
    {'nvim-lua/plenary.nvim'}, --
    ---------------------------------------------------------------------------------------- 
    ---- FILES AND INFORMATION -------------------------------------------------------------
    ---------------------------------------------------------------------------------------- 
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = {left = '', right = ''},
                    section_separators = {left = '', right = ''},
                    disabled_filetypes = {},
                    always_divide_middle = true,
                    globalstatus = true
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                extensions = {}
            }
            vim.opt.laststatus = 3
            vim.cmd('highlight WinSeparator guibg=None')
        end
    }, -- 
    -- {
    --     'sidebar-nvim/sidebar.nvim',
    --     config = function()
    --         local sidebar = require("sidebar-nvim")
    --         sidebar.setup({
    --             disable_default_keybindings = 0,
    --             bindings = nil,
    --             open = true,
    --             side = "left",
    --             initial_width = 35,
    --             hide_statusline = false,
    --             update_interval = 1000,
    --             sections = {
    --                 "datetime", "git", "diagnostics", "containers", "todos"
    --             },
    --             section_separator = {"", "-----", ""},
    --             section_title_separator = {""},
    --             containers = {
    --                 attach_shell = "/bin/sh",
    --                 show_all = true,
    --                 interval = 5000
    --             },
    --             datetime = {
    --                 format = "%a %b %d, %H:%M",
    --                 clocks = {{name = "local"}}
    --             },
    --             todos = {ignored_paths = {"~"}}
    --         })
    --     end
    -- }, --
    ---------------------------------------------------------------------------------------- 
    ---- GIT INTEGRATIONS ------------------------------------------------------------------
    ---------------------------------------------------------------------------------------- 
    {'tpope/vim-fugitive'}, --
    {'tpope/vim-rhubarb'}, --
    {'airblade/vim-gitgutter'}, --
    {'sindrets/diffview.nvim'}, --
    {
        'pwntester/octo.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim',
            'kyazdani42/nvim-web-devicons'
        },
        config = function() require("octo").setup() end
    }, --
    ---------------------------------------------------------------------------------------- 
    ---- LANGUAGE SUPPORT ------------------------------------------------------------------
    ---------------------------------------------------------------------------------------- 
    {'sheerun/vim-polyglot'}, -- [x] syntax support
    {
        'ray-x/go.nvim',
        config = function()
            require('go').setup()
            -- Run gofmt + goimport on save
            vim.api.nvim_exec(
                [[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]],
                false)
        end
    }, --
    {'ray-x/guihua.lua'}, -- 
    {'rust-lang/rust.vim'}, --
    ---------------------------------------------------------------------------------------- 
    ---- LSP -------------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------- 
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            -- NOTE: something really strange happens with the order of loading LuaSnip when
            -- you do not clearly define that it is dependent on the LSP packages which is 
            -- why LusSnip is defined out here with it's required dependencies or else 
            -- everything will break randomly.
            -- This seems to not only affect LuaSnip either, but also treesitter since 
            -- by this breaking, other things seem to break as well.
            {'neovim/nvim-lspconfig'}, {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'}, {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'}, {'saadparwaiz1/cmp_luasnip'}
        }
    }, {
        'VonHeikemen/lsp-zero.nvim',
        -- branch = 'v1.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'}, -- Required
            {'williamboman/mason.nvim'}, -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional
            -- Autocompletion
            {'hrsh7th/nvim-cmp'}, -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'hrsh7th/cmp-buffer'}, -- Optional
            {'hrsh7th/cmp-path'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'}, -- Optional
            -- Snippets
            {'L3MON4D3/LuaSnip'}, -- Required
            {'rafamadriz/friendly-snippets'} -- Optional
        },
        config = function()
            -- LSP Zero specific configuration
            local lsp = require('lsp-zero')
            lsp.preset('recommended')
            lsp.ensure_installed({
                'gopls', -- golang
                'pyright', -- python
                'rust_analyzer' -- rust
            })
            lsp.nvim_workspace()
            lsp.setup()
            -- setting up the LSP diagnostic settings
            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                update_in_insert = true,
                underline = true,
                severity_sort = true,
                float = true
            })
            -- key mappings that I like to use for LSP
            lsp.on_attach(function(client, bufnr)
                local opts = {buffer = bufnr, remap = false}
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- hover option
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- go to definition
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) -- go to reference
                vim.keymap.set("n", "ga", vim.lsp.buf.rename, opts) -- rename
                vim.keymap.set("n", "gq", vim.lsp.buf.workspace_symbol, opts) -- query a symbol within the workspace
            end)
        end
    }, --
    ---------------------------------------------------------------------------------------- 
    ---- FUZZY FINDER ----------------------------------------------------------------------
    ---------------------------------------------------------------------------------------- 
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {'nvim-lua/plenary.nvim'},
        config = function()
            vim.keymap.set("n", "<leader>ff",
                           require('telescope.builtin').find_files, {})
            vim.keymap.set("n", "<leader>fb",
                           require('telescope.builtin').buffers, {})
            vim.keymap.set("n", "<leader>fg",
                           require('telescope.builtin').live_grep, {})
            vim.keymap.set("n", "<leader>fd",
                           require('telescope.builtin').diagnostics, {})
            vim.keymap.set("n", "<leader>fr",
                           require('telescope.builtin').lsp_references, {})
            vim.keymap.set("n", "<leader>fh",
                           require('telescope.builtin').help_tags, {})
        end
    }, --
    {'nvim-telescope/telescope-fzy-native.nvim'}, --
    {'sharkdp/fd'}, --
    {'nvim-lua/popup.nvim'}, --
    ---------------------------------------------------------------------------------------- 
    ---- TREE-SITTER -----------------------------------------------------------------------
    ---------------------------------------------------------------------------------------- 
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-context' -- 
        },
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    "go", "javascript", "lua", "python", "rust", "vim"
                },
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats =
                            pcall(vim.loop.fs_stat,
                                  vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end
                }
            }

        end
    }, --
    -- {'nvim-treesitter/playground'}, --
    ---------------------------------------------------------------------------------------- 
    ---- DIAGNOSTICS -----------------------------------------------------------------------
    ---------------------------------------------------------------------------------------- 
    {
        url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        config = function()
            require("lsp_lines").setup()
            vim.diagnostic.config({
                virtual_lines = true,
                update_in_insert = true
            })
            require("lsp_lines").toggle()
            local function toggle_lsp_lines()
                vim.diagnostic.config({
                    virtual_text = not vim.diagnostic.config()["virtual_text"]
                })
                require("lsp_lines").toggle()
            end
            vim.keymap.set("", "<Leader>d", toggle_lsp_lines,
                           {desc = "Toggle lsp_lines"})
        end
    }, --
    {
        'petertriho/nvim-scrollbar',
        config = function() require("scrollbar").setup() end
    }, --
    ---------------------------------------------------------------------------------------- 
    ---- NICE TO HAVES ---------------------------------------------------------------------
    ---------------------------------------------------------------------------------------- 
    {'tpope/vim-commentary'}, --
    {'tpope/vim-surround'}, --
    {'sbdchd/neoformat'}, --
    {
        'folke/which-key.nvim',
        config = function() require("which-key").setup {} end
    }, --
    {
        'folke/trouble.nvim',
        config = function()
            require("trouble").setup {
                position = "bottom", -- position of the list can be: bottom, top, left, right
                height = 20 -- height of the trouble list when position is top or bottom
            }
            vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
                           {silent = true, noremap = true})
            vim.keymap.set("n", "<leader>xw",
                           "<cmd>TroubleToggle workspace_diagnostics<cr>",
                           {silent = true, noremap = true})
            vim.keymap.set("n", "<leader>xd",
                           "<cmd>TroubleToggle document_diagnostics<cr>",
                           {silent = true, noremap = true})
            vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
                           {silent = true, noremap = true})
            vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
                           {silent = true, noremap = true})
        end
    }, --
    {'ggandor/lightspeed.nvim'}, --
    {
        'danymat/neogen',
        config = function()
            require('neogen').setup {}
            vim.keymap.set("", "<leader><leader>d", require('neogen').generate,
                           {desc = "add in docstring to a function"})
        end
    }, --
    {
        "folke/todo-comments.nvim",
        config = function() require("todo-comments").setup {} end
    }, --
    {
        'ThePrimeagen/harpoon',
        dependencies = {'nvim-lua/plenary.nvim'},
        config = function()
            require("harpoon").setup({menu = {width = 85}})
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")
            -- access to the menu
            vim.keymap.set("n", "<leader>ha", mark.add_file)
            vim.keymap.set("n", "<leader>hh", ui.toggle_quick_menu)
            -- quick access to loaded files; this maps the files to the numbers 1 through 9
            for i = 1, 9 do
                vim.keymap.set("n", "<leader>" .. tostring(i),
                               function() ui.nav_file(i) end)
            end
        end
    }, --
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
    }, --
    {
        "folke/zen-mode.nvim",
        config = function() require("zen-mode").setup {} end
    }, --
    {
        'Tummetott/reticle.nvim',
        config = function()
            require('reticle').setup {
                -- add options here if you want to overwrite defaults
            }
            vim.opt.cursorline = true
            vim.opt.cursorcolumn = true
        end
    }, -- {'Exafunction/codeium.vim'}, --
    ---------------------------------------------------------------------------------------- 
    ---- THEMES ----------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------- 
    {'ellisonleao/gruvbox.nvim'}, --
    {'navarasu/onedark.nvim'} --
    ---- {
    ----     "jesseleite/nvim-noirbuddy",
    ----     dependencies = {"tjdevries/colorbuddy.nvim", branch = "dev"}
    ---- }, --
    ---- {'rebelot/kanagawa.nvim'}, --
    ---- {'folke/tokyonight.nvim'}, --
    ---- {'shaunsingh/nord.nvim'}, --
    ---- {'folke/lsp-colors.nvim'} -- better LSP colors for themes
    ---- {'bluz71/vim-moonfly-colors'}, --
    ---- {'projekt0n/github-nvim-theme'}, --
})
