local cmd = vim.cmd -- to exectue vim commands

function ColorMyPencils()
    if (vim.g.colorscheme == "noirbuddy") then
        require('noirbuddy').setup {
            -- preset = "kiwi" --
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
                primary = "#ffb703",
                --
                -- background ---------------------------------------
                background = "#131513",
                -- 
                -- greyscale colors ---------------------------------
                noir_0 = '#ffffff',
                noir_1 = '#f5f5f5',
                noir_2 = '#d5d5d5',
                noir_3 = '#b4b4b4',
                noir_4 = '#a7a7a7',
                noir_5 = '#949494',
                noir_6 = '#737373',
                noir_7 = '#535353',
                noir_8 = '#323232',
                noir_9 = '#212121'
            },
            styles = {
                italic = true,
                bold = true,
                underline = false,
                undercurl = false
            }
        }

    elseif (vim.g.colorscheme == "catppucin") then
        require("catppuccin").setup({
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            background = { -- :h background
                light = "latte",
                dark = "mocha"
            },
            transparent_background = false,
            term_colors = false,
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
                -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
            }
        })

        -- setup must be called before loading
        cmd.colorscheme "catppuccin"

    elseif (vim.g.colorscheme == "kanagawa") then
        cmd.colorscheme "kanagawa"

    elseif (vim.g.colorscheme == "tokyonight") then
        cmd.colorscheme "tokyonight-moon"

    elseif (vim.g.colorscheme == "gruvbox") then
        cmd("set background=dark")
        vim.cmd.colorscheme "gruvbox"

        cmd("hi CursorLineNR guibg=None")
        cmd("highlight Normal guibg=none")
        cmd("highlight LineNr guifg=#ff8659")
        cmd("highlight LineNr guifg=#aed75f")
        cmd("highlight LineNr guifg=#5eacd3")
        cmd("highlight qfFileName guifg=#aed75f")
        cmd("hi TelescopeBorder guifg=#5eacd")
    end
end

-- vim.g.colorscheme = "catppucin"
vim.g.colorscheme = "noirbuddy"
-- require("styler").setup({
--     themes = {
--         markdown = {colorscheme = "gruvbox"},
--         help = {colorscheme = "catppuccin-mocha", background = "dark"}
--     }
-- })
ColorMyPencils()
