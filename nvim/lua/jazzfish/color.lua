local vim = vim
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
            --- @usage 'auto'|'main'|'moon'|'dawn'
            variant = 'auto',
            --- @usage 'main'|'moon'|'dawn'
            dark_variant = 'moon',
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
        vim.cmd [[highlight WinSeparator guifg=#c7c2a9]] -- this is the correct way to set window split

    elseif (vim.g.colorscheme == "tokyonight") then
        cmd.colorscheme "tokyonight-moon"
        vim.cmd("highlight VertSplit guifg=#546f8f")

    elseif (vim.g.colorscheme == "gruvbox") then
        -- require("gruvbox").setup({
        --     undercurl = true,
        --     underline = true,
        --     bold = true,
        --     italic = {strings = true, operators = true, comments = true},
        --     strikethrough = true,
        --     invert_selection = false,
        --     invert_signs = false,
        --     invert_tabline = false,
        --     invert_intend_guides = false,
        --     inverse = true, -- invert background for search, diffs, statuslines and errors
        --     contrast = "soft", -- can be "hard", "soft" or empty string
        --     palette_overrides = {},
        --     overrides = {},
        --     dim_inactive = false,
        --     transparent_mode = false
        -- })
        -- vim.cmd.colorscheme "gruvbox"

        local options = {
            ["background"] = "medium", -- Options: "hard", "medium", "soft"
            ["enable_italic"] = 1, -- Use 1 for true, 0 for false
            -- ["transparent_background"] = 1, -- Use 1 for editor, 2 for editor & UI
            -- ["dim_inactive_windows"] = 1, -- Dims background of inactive windows
            -- ["disable_italic_comment"] = 1, -- Use 1 to disable italic comments
            ["ui_contrast"] = "high", -- Options: "low", "high"
        }
        for key, value in pairs(options) do
            vim.g["gruvbox_material_" .. key] = value
        end
        vim.cmd.colorscheme "gruvbox-material"
        --
        -- ensure that lualine is also using this color theme
        require('lualine').setup {options = {theme = "gruvbox-material"}}

    elseif (vim.g.colorscheme == "nightfox") then
        -- Default options
        require('nightfox').setup({
            options = {
                -- Compiled file's destination location
                compile_path = vim.fn.stdpath("cache") .. "/nightfox",
                compile_file_suffix = "_compiled", -- Compiled file suffix
                transparent = false, -- Disable setting background
                terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
                dim_inactive = false, -- Non focused panes set to alternative background
                module_default = true, -- Default enable value for modules
                colorblind = {
                    enable = false, -- Enable colorblind support
                    simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
                    severity = {
                        protan = 0, -- Severity [0,1] for protan (red)
                        deutan = 0, -- Severity [0,1] for deutan (green)
                        tritan = 0 -- Severity [0,1] for tritan (blue)
                    }
                },
                styles = { -- Style to be applied to different syntax groups
                    comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
                    conditionals = "NONE",
                    constants = "NONE",
                    functions = "NONE",
                    keywords = "NONE",
                    numbers = "NONE",
                    operators = "NONE",
                    strings = "NONE",
                    types = "NONE",
                    variables = "NONE"
                },
                inverse = { -- Inverse highlight for different types
                    match_paren = false,
                    visual = false,
                    search = false
                },
                modules = { -- List of various plugins and additional options
                    -- ...
                }
            },
            palettes = {},
            specs = {},
            groups = {}
        })

        -- setup must be called before loading
        vim.cmd("colorscheme nordfox")

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

    elseif (vim.g.colorscheme == "moonbow") then
        require("moonbow")

        -- making sure lualine is configured
        require('lualine').setup {options = {theme = "moonbow"}}

    elseif (vim.g.colorscheme == "rasmus") then
        require("rasmus")
        vim.cmd [[colorscheme rasmus]]

    elseif (vim.g.colorscheme == "ayu-light") then
        require('ayu')
        vim.cmd [[colorscheme ayu-mirage]]

    elseif (vim.g.colorscheme == "cyberdream") then
        require("cyberdream").setup({
            -- Enable transparent background
            transparent = false,
            -- Enable italics comments
            italic_comments = true,
            -- Replace all fillchars with ' ' for the ultimate clean look
            hide_fillchars = false,
            -- Modern borderless telescope theme
            borderless_telescope = true,
            -- Set terminal colors used in `:terminal`
            terminal_colors = true,
            theme = {
                variant = "default" -- use "light" for the light variant
            }
        })
        vim.cmd [[colorscheme cyberdream]]

    elseif (vim.g.colorscheme == "onedark") then
        require('onedark').setup {
            -- Main options --
            style = 'warm', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
            transparent = false, -- Show/hide background
            term_colors = true, -- Change terminal color as per the selected theme style
            ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
            cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

            -- toggle theme style ---
            toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
            toggle_style_list = {
                'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'
            }, -- List of styles to toggle between

            -- Change code style ---
            -- Options are italic, bold, underline, none
            -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
            code_style = {
                comments = 'italic',
                keywords = 'none',
                functions = 'none',
                strings = 'none',
                variables = 'none'
            },

            -- Lualine options --
            lualine = {
                transparent = false -- lualine center bar transparency
            },

            -- Custom Highlights --
            colors = {}, -- Override default colors
            highlights = {}, -- Override highlight groups

            -- Plugins Config --
            diagnostics = {
                darker = true, -- darker colors for diagnostic
                undercurl = true, -- use undercurl instead of underline for diagnostics
                background = true -- use background color for virtual text
            }
        }
        require('onedark').load()

        -- making sure lualine is configured
        require('lualine').setup {options = {theme = "onedark"}}

    elseif (vim.g.colorscheme == "acme") then
        require("jazzfish.acme-color-scheme").setup {}

    elseif (vim.g.colorscheme == "everforest") then
        -- configuration options for this specific theme
        local options = {
            ["background"] = "hard" -- Options: "hard", "medium", "soft"
            -- ["enable_italic"] = 1, -- Use 1 for true, 0 for false
            -- ["transparent_background"] = 1, -- Use 1 for editor, 2 for editor & UI
            -- ["dim_inactive_windows"] = 1, -- Dims background of inactive windows
            -- ["disable_italic_comment"] = 1, -- Use 1 to disable italic comments
            -- ["ui_contrast"] = "high", -- Options: "low", "high"
        }
        for key, value in pairs(options) do
            vim.g["everforest_" .. key] = value
        end

        -- setting the color theme
        vim.cmd.colorscheme "everforest"

        -- ensure that lualine is also using this color theme
        require('lualine').setup {options = {theme = "everforest"}}
    end
end

ColorMyPencils()
