-- checking to make sure that we have lazy.nvim installed into the correct place
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none", "--single-branch",
        "https://github.com/folke/lazy.nvim.git", lazypath
    })
end
vim.opt.runtimepath:prepend(lazypath)

-- running the setup function to install all of the required plugins
require("lazy").setup({
    -- GENERAL ---------------------------------------------------------------------------
    {'nvim-lua/plenary.nvim'}, --
    -- FILES AND INFORMATION -------------------------------------------------------------
    {
        'scrooloose/NERDTree',
        config = function()
            vim.keymap.set("n", "<leader>t", "<cmd>NERDTreeToggle<cr>",
                           {silent = true, noremap = true})
            vim.cmd("let NERDTreeIgnore=[\'\\~$\', \'__pycache__\']")
        end
    }, --
    {'Xuyuanp/nerdtree-git-plugin'}, --
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
    -------------------------------------------------------------------------------------- 
    -- GIT INTEGRATIONS ------------------------------------------------------------------
    -------------------------------------------------------------------------------------- 
    {'tpope/vim-fugitive'}, --
    {'tpope/vim-rhubarb'}, --
    {'airblade/vim-gitgutter'}, --
    {'sindrets/diffview.nvim'}, --
    -------------------------------------------------------------------------------------- 
    -- LANGUAGE SUPPORT ------------------------------------------------------------------
    -------------------------------------------------------------------------------------- 
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
    -------------------------------------------------------------------------------------- 
    -- LSP -------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------- 
    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSP Support
            'neovim/nvim-lspconfig', -- 
            'williamboman/mason.nvim', --
            'williamboman/mason-lspconfig.nvim', --
            -- Autocompletion
            'hrsh7th/nvim-cmp', -- 
            'hrsh7th/cmp-buffer', -- 
            'hrsh7th/cmp-path', --
            'saadparwaiz1/cmp_luasnip', -- 
            'hrsh7th/cmp-nvim-lsp', --
            'hrsh7th/cmp-nvim-lua', --
            -- Snippets
            'L3MON4D3/LuaSnip', -- 
            'rafamadriz/friendly-snippets' --
        },
        config = function()
            local lsp = require('lsp-zero')
            lsp.preset('recommended')
            lsp.ensure_installed({'gopls', 'pyright', 'rust_analyzer'})
            lsp.nvim_workspace()
            lsp.setup()

            local cmp = require('cmp')
            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },

                mapping = cmp.mapping.preset.insert({
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true
                    },
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, {'i', 's'}),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, {'i', 's'})
                })
            }

            lsp.set_preferences({sign_icons = {}})

            vim.diagnostic.config({virtual_text = true})

            lsp.on_attach(function(client, bufnr)
                local opts = {buffer = bufnr, remap = false}

                if client.name == "eslint" then
                    vim.cmd.LspStop('eslint')
                    return
                end

                -- not really sure about the movements defined here so might want to update
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol,
                               opts)
                vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float,
                               opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
                vim.keymap
                    .set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
                vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
            end)

            lsp.setup()

        end
    }, --
    -------------------------------------------------------------------------------------- 
    -- FUZZY FINDER ----------------------------------------------------------------------
    -------------------------------------------------------------------------------------- 
    {
        'nvim-telescope/telescope.nvim',
        config = function()
            vim.keymap.set("n", "<leader>ff",
                           require('telescope.builtin').find_files, {})
            vim.keymap.set("n", "<leader>fb",
                           require('telescope.builtin').buffers, {})
            vim.keymap.set("n", "<leader>fg",
                           require('telescope.builtin').live_grep, {})
            vim.keymap.set("n", "<leader>fh",
                           require('telescope.builtin').help_tags, {})
        end
    }, --
    {'nvim-telescope/telescope-fzy-native.nvim'}, --
    {'sharkdp/fd'}, --
    {'nvim-lua/popup.nvim'}, --
    -------------------------------------------------------------------------------------- 
    -- TREE-SITTER -----------------------------------------------------------------------
    -------------------------------------------------------------------------------------- 
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    "go", "javascript", "lua", "python", "rust", "vim"
                },
                highlight = {enable = true, disable = {"vim"}}
            }

        end
    }, --
    {'nvim-treesitter/playground'}, --
    {'nvim-treesitter/nvim-treesitter-context'}, --
    -------------------------------------------------------------------------------------- 
    -- DIAGNOSTICS -----------------------------------------------------------------------
    -------------------------------------------------------------------------------------- 
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
    -------------------------------------------------------------------------------------- 
    -- NICE TO HAVES ---------------------------------------------------------------------
    -------------------------------------------------------------------------------------- 
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
            vim.keymap.set("", "<Leader><leader>d", require('neogen').generate,
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

            -- quick access to loaded files
            vim.keymap.set("n", "<leader>1", function()
                ui.nav_file(1)
            end)
            vim.keymap.set("n", "<leader>2", function()
                ui.nav_file(2)
            end)
            vim.keymap.set("n", "<leader>3", function()
                ui.nav_file(3)
            end)
            vim.keymap.set("n", "<leader>4", function()
                ui.nav_file(4)
            end)
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
    -------------------------------------------------------------------------------------- 
    -- THEMES ----------------------------------------------------------------------------
    -------------------------------------------------------------------------------------- 
    {'ellisonleao/gruvbox.nvim'}, --
    {
        "jesseleite/nvim-noirbuddy",
        dependencies = {"tjdevries/colorbuddy.nvim", branch = "dev"}
    }, --
    {'rebelot/kanagawa.nvim'}, --
    {
        "folke/lsp-colors.nvim",
        config = function()
            require("lsp-colors").setup({
                Error = "#db4b4b",
                Warning = "#e0af68",
                Information = "#0db9d7",
                Hint = "#10B981"
            })
        end
    }, --
    -------------------------------------------------------------------------------------- 
    -- LEGENDARY -------------------------------------------------------------------------
    -------------------------------------------------------------------------------------- 
    {'mrjones2014/legendary.nvim'} --
})
