local vim = vim

-- colors/acme.lua
local M = {}

-- Define both light and dark color palettes
M.colors = {
    light = {
        bg = '#ffffd7', -- Slightly darker yellow background
        fg = '#000000', -- Black text
        fg_blue = '#0b67b3', -- Blue-black text
        comment = '#999999', -- Grey for comments
        selection = '#eeee9e', -- Darker yellow for selection
        subtle = '#eaffff', -- Very light blue for subtle highlights
        statusline = '#eaffff', -- Light blue for status line
        statusline_inactive = '#c4f2f2', -- Light blue for status line
        error = '#ff0000', -- Red for errors
        warning = '#888822' -- Dark yellow for warnings
    },
    dark = {
        bg = '#000028', -- Inverted from #ffffd7
        fg = '#ffffff', -- Inverted from #000000
        fg_blue = '#f4984c', -- Inverted from #0b67b3
        comment = '#666666', -- Inverted from #999999
        selection = '#111161', -- Inverted from #eeee9e
        subtle = '#150000', -- Inverted from #eaffff
        statusline = '#150000', -- Inverted from #eaffff
        statusline_inactive = '#3b0d0d', -- Inverted from #c4f2f2
        error = '#ff0000', -- Red for errors
        warning = '#888822' -- Dark yellow for warnings
    }
}

-- Function to get current color scheme
function M.get_colors()
    local background = vim.o.background or 'light'
    return M.colors[background]
end

-- Function to get highlight definitions with current colors
function M.get_highlights()
    local colors = M.get_colors()

    return {
        -- Editor UI
        Normal = {fg = colors.fg, bg = colors.bg},
        NonText = {fg = colors.comment},
        Visual = {bg = colors.selection},
        Search = {bg = colors.selection, bold = true},
        IncSearch = {bg = colors.selection, bold = true},
        StatusLine = {fg = colors.fg, bg = colors.statusline},
        StatusLineNC = {fg = colors.comment, bg = colors.statusline},
        SignColumn = {fg = colors.fg, bg = colors.bg},
        VertSplit = {fg = colors.comment, bg = colors.bg},
        LineNr = {fg = colors.comment, bg = colors.bg},
        CursorLine = {bg = colors.subtle},
        CursorLineNr = {fg = colors.fg, bold = true},
        Folded = {fg = colors.comment, bg = colors.subtle},
        FoldColumn = {fg = colors.comment, bg = colors.bg},
        MatchParen = {bg = colors.selection, bold = true},
        ColorColumn = {bg = colors.subtle},
        Conceal = {fg = colors.comment},
        Directory = {fg = colors.fg},
        MoreMsg = {fg = colors.fg},
        ModeMsg = {fg = colors.fg},
        CursorColumn = {bg = colors.subtle},
        TabLine = {fg = colors.comment, bg = colors.statusline},
        TabLineSel = {fg = colors.fg, bg = colors.bg},
        TabLineFill = {bg = colors.statusline},

        -- Syntax highlighting (minimal)
        String = {fg = colors.fg_blue},
        Number = {fg = colors.fg},
        Float = {fg = colors.fg},
        Boolean = {fg = colors.fg},
        Character = {fg = colors.fg},
        Constant = {fg = colors.fg, bold = true},
        Identifier = {fg = colors.fg},
        Variable = {fg = colors.fg},
        Function = {fg = colors.fg},
        Statement = {fg = colors.fg},
        Operator = {fg = colors.fg, bold = true},
        Keyword = {fg = colors.fg, underline = true},
        Type = {fg = colors.fg, bold = true},
        Special = {fg = colors.fg},
        PreProc = {fg = colors.fg},

        -- Git highlights
        DiffAdd = {bg = '#2a4d30'},
        DiffChange = {bg = '#252525'},
        DiffDelete = {bg = '#4d2a2a'},
        DiffText = {bg = '#3a6640', bold = true},

        -- Popup menu
        Pmenu = {fg = colors.fg, bg = colors.subtle},
        PmenuSel = {fg = colors.fg, bg = colors.selection},
        PmenuSbar = {bg = colors.subtle},
        PmenuThumb = {bg = colors.comment},

        -- Comments and todos
        Comment = {fg = colors.comment, italic = true},
        Todo = {fg = colors.comment, bold = true, italic = true},

        -- Warnings and errors
        WarningMsg = {fg = colors.warning, bold = true, italic = true},
        ErrorMsg = {fg = colors.error, bold = true, italic = true},

        -- Diagnostic messages
        DiagnosticError = {fg = colors.error, bold = true, italic = true},
        DiagnosticWarn = {fg = colors.warning, bold = true, italic = true},
        DiagnosticInfo = {fg = colors.comment, italic = true},
        DiagnosticHint = {fg = colors.comment, italic = true},

        -- Diagnostic underlines
        DiagnosticUnderlineError = {
            undercurl = true,
            sp = colors.error,
            bold = true,
            italic = true
        },
        DiagnosticUnderlineWarn = {
            undercurl = true,
            sp = colors.warning,
            bold = true,
            italic = true
        },
        DiagnosticUnderlineInfo = {
            undercurl = true,
            sp = colors.comment,
            italic = true
        },
        DiagnosticUnderlineHint = {
            undercurl = true,
            sp = colors.comment,
            italic = true
        }
    }
end

-- Setup function
function M.setup(opts)
    -- Override defaults with any user options
    if opts then
        M.colors = vim.tbl_deep_extend("force", M.colors, opts.colors or {})
    end

    -- Reset all highlights
    vim.cmd('highlight clear')
    if vim.fn.exists('syntax_on') then vim.cmd('syntax reset') end

    -- Set colorscheme name
    vim.g.colors_name = 'acme'

    -- Get and set all highlights based on current background
    local highlights = M.get_highlights()
    for group, settings in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, settings)
    end

    -- Set up lualine with current colors
    local colors = M.get_colors()
    require('lualine').setup {
        options = {
            theme = {
                normal = {
                    a = {fg = colors.fg, bg = colors.statusline},
                    b = {fg = colors.fg, bg = colors.statusline},
                    c = {fg = colors.fg, bg = colors.statusline}
                },
                insert = {
                    a = {fg = colors.fg, bg = colors.statusline},
                    b = {fg = colors.fg, bg = colors.statusline},
                    c = {fg = colors.fg, bg = colors.statusline}
                },
                visual = {
                    a = {fg = colors.fg, bg = colors.statusline},
                    b = {fg = colors.fg, bg = colors.statusline},
                    c = {fg = colors.fg, bg = colors.statusline}
                },
                replace = {
                    a = {fg = colors.fg, bg = colors.statusline},
                    b = {fg = colors.fg, bg = colors.statusline},
                    c = {fg = colors.fg, bg = colors.statusline}
                },
                command = {
                    a = {fg = colors.fg, bg = colors.statusline},
                    b = {fg = colors.fg, bg = colors.statusline},
                    c = {fg = colors.fg, bg = colors.statusline}
                },
                inactive = {
                    a = {fg = colors.comment, bg = colors.statusline_inactive},
                    b = {fg = colors.comment, bg = colors.statusline_inactive},
                    c = {fg = colors.comment, bg = colors.statusline_inactive}
                }
            }
        }
    }
end

-- Add autocmd to update colors when background changes
vim.api.nvim_create_autocmd("OptionSet", {
    pattern = "background",
    callback = function() M.setup() end
})

return M
