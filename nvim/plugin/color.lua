local cmd = vim.cmd -- to exectue vim commands

function ColorMyPencils()
    if (vim.g.colorscheme == "catppucin") then
        require("catppuccin").setup({
            flavour = "latte", -- latte, frappe, macchiato, mocha
            background = { -- :h background
                light = "latte",
                dark = "mocha",
            },
            transparent_background = false,
            term_colors = false,
            dim_inactive = {
                enabled = false,
                shade = "dark",
                percentage = 0.15,
            },
            no_italic = false, -- Force no italic
            no_bold = false, -- Force no bold
            styles = {
                comments = { "italic" },
                conditionals = { "italic" },
                loops = {},
                functions = {},
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
            },
            color_overrides = {},
            custom_highlights = {},
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = false,
                telescope = true,
                notify = false,
                mini = false,
                -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
            },
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
vim.g.colorscheme = "gruvbox"
ColorMyPencils()
