local cmd = vim.cmd -- to exectue vim commands

function ColorMyPencils()
    if (vim.g.colorscheme == "noirbuddy") then
        require('noirbuddy').setup {
            -- preset = "slate", --
            colors = {
                -- -- blue/green ------------------------------------
                -- primary = "#97CC04",
                -- secondary = "#2D7DD2",
                --
                -- terquoise/beige ----------------------------------
                -- primary = "#e9c46a",
                -- secondary = "#2a9d8f",
                --
                -- yellow ------------------------------------
                -- primary = "#ffb703",
                --
                -- blue ------------------------------------
                primary = "#0096c7",
                --
                -- background ---------------------------------------
                -- background = "#131513",
                background = "#21201e"
                -- 
                -- -- greyscale colors ---------------------------------
                -- noir_0 = '#ffffff',
                -- noir_1 = '#f5f5f5',
                -- noir_2 = '#d5d5d5',
                -- noir_3 = '#b4b4b4',
                -- noir_4 = '#a7a7a7',
                -- noir_5 = '#949494',
                -- noir_6 = '#737373',
                -- noir_7 = '#535353',
                -- noir_8 = '#323232',
                -- noir_9 = '#21201e'
            },
            styles = {
                italic = true,
                bold = true,
                underline = false,
                undercurl = false
            }
        }

    elseif (vim.g.colorscheme == "tokyonight") then
        vim.cmd [[colorscheme tokyonight-moon]]

    elseif (vim.g.colorscheme == "rose-pine") then
        require('rose-pine').setup({
            --- @usage 'main' | 'moon'
            dark_variant = 'main',
            bold_vert_split = false,
            dim_nc_background = false,
            disable_background = false,
            disable_float_background = false,
            disable_italics = false,

            --- @usage string hex value or named color from rosepinetheme.com/palette
            groups = {
                background = 'base',
                panel = 'surface',
                border = 'highlight_med',
                comment = 'muted',
                link = 'iris',
                punctuation = 'subtle',

                error = 'love',
                hint = 'iris',
                info = 'foam',
                warn = 'gold',

                headings = {
                    h1 = 'iris',
                    h2 = 'foam',
                    h3 = 'rose',
                    h4 = 'gold',
                    h5 = 'pine',
                    h6 = 'foam'
                }
                -- or set all headings at once
                -- headings = 'subtle'
            },

            -- Change specific vim highlight groups
            highlight_groups = {ColorColumn = {bg = 'rose'}}
        })
        -- setup must be called before loading
        cmd.colorscheme "rose-pine"

        -- set colorscheme after options
        vim.cmd('colorscheme rose-pine')

    elseif (vim.g.colorscheme == "catppuccin") then
        require("catppuccin").setup({
            flavour = "frappe", -- latte, frappe, macchiato, mocha
            background = { -- :h background
                light = "latte",
                dark = "mocha"
            },
            transparent_background = false,
            term_colors = true,
            dim_inactive = {enabled = false, shade = "dark", percentage = 0.15},
            no_italic = false, -- Force no italic
            no_bold = false, -- Force no bold
            styles = {
                comments = {"italic"},
                conditionals = {"italic"},
                loops = {},
                functions = {},
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {}
            },
            color_overrides = {},
            custom_highlights = {},
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = false,
                telescope = true,
                notify = false,
                mini = false
            }
        })

        -- setup must be called before loading
        cmd.colorscheme "catppuccin"

    elseif (vim.g.colorscheme == "kanagawa") then
        cmd.colorscheme "kanagawa"
        cmd("hi TelescopeBorder guifg=#5eacd")
        cmd("hi VertSplit guifg=#5eacd")
        cmd("hi CursorLineNR guibg=guifg=#ff8659")

    elseif (vim.g.colorscheme == "tokyonight") then
        cmd.colorscheme "tokyonight-moon"
        vim.cmd("highlight VertSplit guifg=#546f8f")

    elseif (vim.g.colorscheme == "gruvbox") then
        require("gruvbox").setup({
            undercurl = true,
            underline = true,
            bold = true,
            italic = true,
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true, -- invert background for search, diffs, statuslines and errors
            contrast = "", -- can be "hard", "soft" or empty string
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = false
        })
        vim.cmd.colorscheme "gruvbox"

    elseif (vim.g.colorscheme == "nord") then
        -- Example config in lua
        vim.g.nord_contrast = true
        vim.g.nord_borders = true
        vim.g.nord_disable_background = false
        vim.g.nord_italic = true
        vim.g.nord_uniform_diff_background = true
        vim.g.nord_bold = true

        -- Load the colorscheme
        require('nord').set()

        -- making sure lualine is configured
        require('lualine').setup {options = {theme = 'nord'}}

        -- setting the split border color to be a nice white value so it's easier to see
        -- the separations
        vim.cmd("highlight VertSplit guifg=#d5d8de")

    elseif (vim.g.colorscheme == "moonfly") then
        vim.cmd [[colorscheme moonfly]]

        -- making sure lualine is configured
        require('lualine').setup {options = {theme = 'moonfly'}}

        -- moonfly configuration options
        vim.g.moonflyWinSeparator = 2
        vim.g.moonflyNormalFloat = true

    elseif (vim.g.colorscheme == "github") then
        require("github-theme").setup({theme_style = "dimmed"})

        -- making sure lualine is configured
        require('lualine').setup {options = {theme = "auto"}}
    end
end

vim.g.colorscheme = "gruvbox"
ColorMyPencils()
