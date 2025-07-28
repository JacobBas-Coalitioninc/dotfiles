local vim = vim
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
                    component_separators = {left = '', right = ''},
                    section_separators = {left = '', right = ''},
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
    {"nvim-pack/nvim-spectre"}, --
    ---------------------------------------------------------------------------------------- 
    ---- GIT INTEGRATIONS ------------------------------------------------------------------
    ---------------------------------------------------------------------------------------- 
    {'tpope/vim-fugitive'}, --
    {'tpope/vim-rhubarb'}, --
    {'airblade/vim-gitgutter'}, --
    ---------------------------------------------------------------------------------------- 
    ---- LANGUAGE SUPPORT ------------------------------------------------------------------
    ---------------------------------------------------------------------------------------- 
    {'sheerun/vim-polyglot'}, --
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
    {"L3MON4D3/LuaSnip", dependencies = {"rafamadriz/friendly-snippets"}}, -- 
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {"williamboman/mason.nvim"}, {"williamboman/mason-lspconfig.nvim"}, --
            {"hrsh7th/nvim-cmp"}, {"hrsh7th/cmp-nvim-lsp"}, --
            {"L3MON4D3/LuaSnip"}, {'saadparwaiz1/cmp_luasnip'} --
        },
        config = function()
            -- loading the lsp config and default_capabilities
            local lspconfig = require('lspconfig')
            local lsp_capabilities =
                require('cmp_nvim_lsp').default_capabilities()

            -- Default LSP setup function
            local default_setup = function(server)
                lspconfig[server].setup({capabilities = lsp_capabilities})
            end

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {default_setup}
            })

            -- CMP configuration
            local cmp = require('cmp')
            require("luasnip.loaders.from_vscode").lazy_load()

            -- CMP setup
            cmp.setup({
                sources = {
                    {name = "nvim_lsp"},
                    {name = "luasnip", option = {show_autosnippets = true}}
                },
                mapping = cmp.mapping.preset.insert({
                    -- Enter key confirms completion item
                    ['<CR>'] = cmp.mapping.confirm({select = false}),

                    -- Ctrl + space triggers completion menu
                    ['<C-Space>'] = cmp.mapping.complete()
                }),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end
                }
            })
            cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

        end
    }, --
    ---------------------------------------------------------------------------------------- 
    ---- FUZZY FINDER ----------------------------------------------------------------------
    ---------------------------------------------------------------------------------------- 
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {'nvim-lua/plenary.nvim'}
    }, --
    {'nvim-telescope/telescope-fzy-native.nvim'}, --
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
        end
    }, --
    {
        'petertriho/nvim-scrollbar',
        config = function() require("scrollbar").setup() end
    }, --
    ---------------------------------------------------------------------------------------- 
    ---- NICE TO HAVES ---------------------------------------------------------------------
    ---------------------------------------------------------------------------------------- 
    {"sindrets/diffview.nvim"}, --
    {'tpope/vim-commentary'}, --
    {'tpope/vim-surround'}, --
    {'sbdchd/neoformat'}, --
    {'ggandor/lightspeed.nvim'}, --
    {
        "folke/todo-comments.nvim",
        config = function() require("todo-comments").setup {} end
    }, --
    {
        'ThePrimeagen/harpoon',
        dependencies = {'nvim-lua/plenary.nvim'},
        config = function()
            require("harpoon").setup({menu = {width = 85}})
        end
    }, --
    {'mbbill/undotree'}, --
    {
        'Tummetott/reticle.nvim',
        config = function()
            require('reticle').setup {
                on_startup = {cursorline = true, cursorcolumn = true}
            }
            vim.api.nvim_set_hl(0, 'CursorLine', {underline = true})
        end
    }, -- 
    {
        "HampusHauffman/block.nvim",
        config = function() require("block").setup({}) end
    }, --
    {
        "stevearc/oil.nvim",
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function()
            require("oil").setup({
                view_options = {
                    default_file_explorer = true,
                    -- Show files and directories that start with "."
                    show_hidden = true,
                    -- This function defines what is considered a "hidden" file
                    is_hidden_file = function(_, _)
                        return false
                    end,
                    -- This function defines what will never be shown, even when `show_hidden` is set
                    is_always_hidden = function(name, _)
                        local patterns = {"pycache", "DS_Store"}
                        for _, pattern in ipairs(patterns) do
                            if string.match(name, pattern) then
                                return true
                            end
                        end
                        return false
                    end
                }
            })
        end
    }, --
    {
        "chrisgrieser/nvim-scissors",
        dependencies = "nvim-telescope/telescope.nvim"
    }, --
    {
        "LunarVim/bigfile.nvim",
        config = function()
            require("bigfile").setup {
                filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
                pattern = {"*"}, -- autocmd pattern or function see <### Overriding the detection of big files>
                features = { -- features to disable
                    "indent_blankline", "illuminate", "lsp", "treesitter",
                    "syntax", "matchparen", "vimopts", "filetype"
                }
            }
        end
    }, --
    {'RRethy/vim-illuminate'}, -- 
    ---------------------------------------------------------------------------------------- 
    ---- THEMES ----------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------- 
    {'ellisonleao/gruvbox.nvim'}, --
    ---------------------------------------------------------------------------------------- 
    ---- AI STUFF --------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------- 
})
