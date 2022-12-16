-- I am going to want to add in some more configuration to here that is based on the
-- g.colorscheme variable that calls different if statements dependent on the color
-- that I am selecting

-- setting the colorscheme easily; this should be done within the
-- plugin/color.vim script
-- g.colorscheme = "github_*"
-- g.colorscheme = "kanagawa"
-- g.colorscheme = "gruvbox"
-- g.colorscheme = "everforest"
-- g.colorscheme = "tokyonight"

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
        vim.cmd.colorscheme "catppuccin"

    elseif (vim.g.colorscheme == "kanagawa") then
         vim.cmd.colorscheme "kanagawa"
    end

    elseif (vim.g.colorscheme == "tokyonight") then
         vim.cmd.colorscheme "tokyonight-moon"
    end

    elseif (vim.g.colorscheme == "gruvbox") then
         vim.cmd("set background=dark")
         vim.cmd.colorscheme "gruvbox"

         vim.cmd("hi CursorLineNR guibg=None")
         vim.cmd("highlight Normal guibg=none")
         vim.cmd("highlight LineNr guifg=#ff8659")
         vim.cmd("highlight LineNr guifg=#aed75f")
         vim.cmd("highlight LineNr guifg=#5eacd3")
         vim.cmd("highlight qfFileName guifg=#aed75f")
         vim.cmd("hi TelescopeBorder guifg=#5eacd")
    end
end

-- vim.g.colorscheme = "catppucin"
vim.g.colorscheme = "gruvbox"
ColorMyPencils()
