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
    {"nvim-pack/nvim-spectre"}, --
    ---------------------------------------------------------------------------------------- 
    ---- GIT INTEGRATIONS ------------------------------------------------------------------
    ---------------------------------------------------------------------------------------- 
    {'tpope/vim-fugitive'}, --
    {
        'tpope/vim-rhubarb',
        -- config = function()
        --     -- ensures that :GBrowse is working
        --     vim.api.nvim_create_user_command('Browse', function(opts)
        --         vim.fn.system {'xdg-open', opts.fargs[1]}
        --     end, {nargs = 1})
        -- end
    }, --
    {'airblade/vim-gitgutter'}, --
    {
        'sindrets/diffview.nvim',
        config = function()
            require("diffview").setup({
                diff_binaries = false, -- Show diffs for binaries
                enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
                git_cmd = {"git"}, -- The git executable followed by default args.
                hg_cmd = {"hg"}, -- The hg executable followed by default args.
                use_icons = true, -- Requires nvim-web-devicons
                show_help_hints = true, -- Show hints for how to open the help panel
                watch_index = true, -- Update views and index buffers when the git index changes.
                signs = {fold_closed = "", fold_open = "", done = "✓"},
                view = {
                    -- Configure the layout and behavior of different types of views.
                    -- Available layouts:
                    --  'diff1_plain'
                    --    |'diff2_horizontal'
                    --    |'diff2_vertical'
                    --    |'diff3_horizontal'
                    --    |'diff3_vertical'
                    --    |'diff3_mixed'
                    --    |'diff4_mixed'
                    -- For more info, see ':h diffview-config-view.x.layout'.
                    default = {
                        -- Config for changed files, and staged files in diff views.
                        layout = "diff2_horizontal",
                        winbar_info = false -- See ':h diffview-config-view.x.winbar_info'
                    },
                    merge_tool = {
                        -- Config for conflicted files in diff views during a merge or rebase.
                        layout = "diff3_horizontal",
                        disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
                        winbar_info = true -- See ':h diffview-config-view.x.winbar_info'
                    },
                    file_history = {
                        -- Config for changed files in file history views.
                        layout = "diff2_horizontal",
                        winbar_info = false -- See ':h diffview-config-view.x.winbar_info'
                    }
                },
                file_panel = {
                    listing_style = "tree", -- One of 'list' or 'tree'
                    win_config = { -- See ':h diffview-config-win_config'
                        position = "bottom",
                        width = 14,
                        win_opts = {}
                    }
                },
                file_history_panel = {
                    log_options = { -- See ':h diffview-config-log_options'
                        git = {
                            single_file = {diff_merges = "combined"},
                            multi_file = {diff_merges = "first-parent"}
                        },
                        hg = {single_file = {}, multi_file = {}}
                    },
                    win_config = { -- See ':h diffview-config-win_config'
                        position = "bottom",
                        height = 16,
                        win_opts = {}
                    }
                },
                commit_log_panel = {
                    win_config = { -- See ':h diffview-config-win_config'
                        win_opts = {}
                    }
                },
                default_args = { -- Default args prepended to the arg-list for the listed commands
                    DiffviewOpen = {},
                    DiffviewFileHistory = {}
                },
                hooks = {} -- See ':h diffview-config-hooks'
            })

        end
    }, --
    {
        'pwntester/octo.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim',
            'nvim-tree/nvim-web-devicons'
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

            local cmp = require('cmp')
            local cmp_action = require('lsp-zero').cmp_action()

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    -- `Enter` key to confirm completion
                    ['<CR>'] = cmp.mapping.confirm({select = false}),

                    -- Ctrl+Space to trigger completion menu
                    ['<C-Space>'] = cmp.mapping.complete(),

                    -- Navigate between snippet placeholder
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

                    -- Scroll up and down in the completion documentation
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4)
                })
            })
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
            require('reticle').enable_cursorcross()
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
                    is_hidden_file = function(name, bufnr)
                        return false
                    end,
                    -- This function defines what will never be shown, even when `show_hidden` is set
                    is_always_hidden = function(name, bufnr)
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
    -- {
    --     'github/copilot.vim',
    --     config = function()
    --         vim.g.copilot_no_tab_map = true
    --         vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")',
    --                                 {silent = true, expr = true})
    --     end
    -- }, --
    ---------------------------------------------------------------------------------------- 
    ---- THEMES ----------------------------------------------------------------------------
    ---------------------------------------------------------------------------------------- 
    {'ellisonleao/gruvbox.nvim'}, --
    {'rebelot/kanagawa.nvim'}, --
    {'rose-pine/neovim', name = 'rose-pine'}, --
    {"EdenEast/nightfox.nvim"} --
})
