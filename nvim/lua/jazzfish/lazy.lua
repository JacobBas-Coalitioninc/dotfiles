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
    {
        'tpope/vim-rhubarb'
        -- config = function()
        --     -- ensures that :GBrowse is working
        --     vim.api.nvim_create_user_command('Browse', function(opts)
        --         vim.fn.system {'xdg-open', opts.fargs[1]}
        --     end, {nargs = 1})
        -- end
    }, --
    {'airblade/vim-gitgutter'}, --
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
    {"L3MON4D3/LuaSnip", dependencies = {"rafamadriz/friendly-snippets"}}, -- 
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- required for easy installation of LSP servers and other tools...
            {"williamboman/mason.nvim"}, {"williamboman/mason-lspconfig.nvim"}, --
            -- required for getting auto complete working...
            {"hrsh7th/nvim-cmp"}, {"hrsh7th/cmp-nvim-lsp"}, --
            -- required for getting snippets to work...
            {"L3MON4D3/LuaSnip"}, {'saadparwaiz1/cmp_luasnip'} --
        },
        config = function()
            -- loading the lsp config and default_capabilities
            local lspconfig = require('lspconfig')
            local lsp_capabilities =
                require('cmp_nvim_lsp').default_capabilities()

            -- setting the lsp motions so that I can easily access functionality
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = {buffer = event.buf}
                    -- these are the key maps that I use regularly
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- hover option
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- go to definition
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) -- go to reference
                    vim.keymap.set("n", "ga", vim.lsp.buf.rename, opts) -- rename

                    -- don't really ever use these ones
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
                    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
                    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
                end
            })

            -- setting the default setup; not really sure what this does but it must
            -- do something for the setup...
            local default_setup = function(server)
                lspconfig[server].setup({capabilities = lsp_capabilities})
            end

            -- setting up mason for easy downloading of my clients to my machine
            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {default_setup}
            })

            -- setting up cmp for easy use of autocomplete functionality
            local cmp = require('cmp')
            require("luasnip.loaders.from_vscode").lazy_load()

            -- defining the configuration options for cmp so that autocomplete works
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
        'Tummetott/reticle.nvim',
        config = function()
            require('reticle').setup {
                -- add options here if you want to overwrite defaults
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
            -- this was originally mapped to netrw  but since I now use oil it is unneeded
            vim.keymap.set("n", "<leader>t", require("oil").open,
                           {silent = true, noremap = true})
        end
    }, --
    {"rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap"}}, --
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = {"mfussenegger/nvim-dap"}
    }, --
    {
        "chrisgrieser/nvim-scissors",
        dependencies = "nvim-telescope/telescope.nvim" -- optional
    }, --
    {
        "LunarVim/bigfile.nvim",
        config = function()
            -- default config
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
