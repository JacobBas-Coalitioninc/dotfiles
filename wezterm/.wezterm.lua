-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- Assuming these are the base colors from the original scheme
local acme_colors = {

    bg = '#ffffd7', -- Slightly darker yellow background
    fg = '#000000', -- Black text
    fg_blue = '#0b67b3', -- Blue-black text
    fg_green = '#478c04', -- Green text 
    fg_red = '#8c1f04', -- Red text
    comment = '#999999', -- Grey for comments
    selection = '#eeee9e', -- Darker yellow for selection
    subtle = '#eaffff', -- Very light blue for subtle highlights
    statusline = '#eaffff', -- Light blue for status line
    statusline_inactive = '#c4f2f2', -- Light blue for status line
    error = '#ff0000', -- Red for errors
    warning = '#888822' -- Dark yellow for warnings
}

local get_acme_colors = function()
    return {
        -- The default text color
        foreground = acme_colors.fg,
        -- The default background color
        background = acme_colors.bg,

        -- Overrides the cell background color when the current cell is occupied by the
        -- cursor and the cursor style is set to Block
        cursor_bg = acme_colors.fg,
        -- Overrides the text color when the current cell is occupied by the cursor
        cursor_fg = acme_colors.bg,
        -- Specifies the border color of the cursor when the cursor style is set to Block,
        -- or the color of the vertical or horizontal bar when the cursor style is set to
        -- Bar or Underline.
        cursor_border = acme_colors.fg,

        -- the foreground color of selected text
        selection_fg = acme_colors.fg,
        -- the background color of selected text
        selection_bg = acme_colors.selection,

        -- The color of the scrollbar "thumb"; the portion that represents the current viewport
        scrollbar_thumb = acme_colors.comment,

        -- The color of the split lines between panes
        split = acme_colors.fg,

        ansi = {
            acme_colors.bg, acme_colors.fg_red, acme_colors.fg_green,
            acme_colors.warning, acme_colors.statusline, acme_colors.fg_blue, -- magenta
            acme_colors.fg,
            acme_colors.fg
        },
        brights = {
            acme_colors.comment, acme_colors.fg_blue, acme_colors.fg_green,
            acme_colors.warning, acme_colors.fg_blue, acme_colors.fg_red, -- magenta
            acme_colors.fg,
            acme_colors.fg
        },

        -- Tab bar colors
        tab_bar = {
            background = acme_colors.statusline,
            active_tab = {bg_color = acme_colors.bg, fg_color = acme_colors.fg},
            inactive_tab = {
                bg_color = acme_colors.statusline,
                fg_color = acme_colors.comment
            },
            inactive_tab_hover = {
                bg_color = acme_colors.subtle,
                fg_color = acme_colors.fg
            },
            new_tab = {bg_color = acme_colors.bg, fg_color = acme_colors.fg},
            new_tab_hover = {
                bg_color = acme_colors.subtle,
                fg_color = acme_colors.fg,
                italic = true
            }
        }
    }
end

-- This table will hold the configuration.
local config = {
    -- color_scheme = 'Gruvbox dark, soft (base16)',
    color_scheme = 'Everforest Dark Hard (Gogh)',
    -- color_scheme = 'nordfox',
    -- color_scheme = 'Kanagawa (Gogh)',
    -- color_scheme = 'rose-pine-moon',
    -- color_scheme = 'rose-pine-dawn',
    -- colors = get_acme_colors(),
    -- wezterm ls-fonts --list-system
    -- font=wezterm.font "Miracode",
    -- font=wezterm.font "DejaVu Sans Mono for Powerline",
    -- font=wezterm.font "Anonymous Pro for Powerline",
    -- font=wezterm.font "Source Code Pro for Powerline",
    -- font=wezterm.font "Consolas",
    -- font = wezterm.font({
        -- family = 'Source Code Pro for Powerline',
        -- family = 'Anonymous Pro for Powerline',
        -- family = 'DejaVu Sans Mono for Powerline',
        -- family = 'Fira Code',
        -- weight = 'DemiLight', -- Can be 'Thin', 'ExtraLight', 'Light', 'DemiLight', 'Regular', 'Medium', 'DemiBold', 'Bold', 'ExtraBold', 'Black'
    -- }),
    -- line_height = 1.1,
    keys = {
        -- general stuff here
        {key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher}, -- like a command pallet
        -- windows and tab configurations ====================================================== 
        {
            key = 'v',
            mods = 'CTRL|SHIFT',
            action = act.SplitHorizontal {domain = 'CurrentPaneDomain'}
        }, -- 
        {
            key = 'h',
            mods = 'CTRL|SHIFT',
            action = act.SplitVertical {domain = 'CurrentPaneDomain'}
        }, --
        {
            key = 'RightArrow',
            mods = 'SUPER|SHIFT',
            action = act.ActivateTabRelative(1)
        }, --
        {
            key = 'LeftArrow',
            mods = 'SUPER|SHIFT',
            action = act.ActivateTabRelative(-1)
        }, -- 
        -- workspace configurations ============================================================
        {
            key = 'y',
            mods = 'CTRL|SHIFT',
            action = act.SwitchToWorkspace {name = 'default'}
        }, --
        {key = 'i', mods = 'CTRL|SHIFT', action = act.SwitchToWorkspace}, --
        {
            key = '9',
            mods = 'ALT',
            action = act.ShowLauncherArgs {flags = 'FUZZY|WORKSPACES'}
        } -- 
        -- example on how to spawn a custom workspace with a command
        -- {
        --     key = 'u',
        --     mods = 'CTRL|SHIFT',
        --     action = act.SwitchToWorkspace {
        --         name = 'monitoring',
        --         spawn = {args = {'top'}}
        --     }
        -- } --
    }
}

-- and finally, return the configuration to wezterm
return config
