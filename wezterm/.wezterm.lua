-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This table will hold the configuration.
local config = {
    -- color_scheme = 'Gruvbox dark, medium (base16)',
    -- color_scheme = 'nordfox',
    color_scheme = 'Kanagawa (Gogh)',
    -- color_scheme = 'rose-pine-moon',
    -- color_scheme = 'rose-pine-dawn',
    -- wezterm ls-fonts --list-system
    font=wezterm.font "Miracode",
    -- font=wezterm.font "DejaVu Sans Mono for Powerline",
    -- font=wezterm.font "Anonymous Pro for Powerline",
    -- font=wezterm.font "Source Code Pro for Powerline",
    -- font=wezterm.font "Consolas",
    font_size = 10,
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
        }, -- 
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
