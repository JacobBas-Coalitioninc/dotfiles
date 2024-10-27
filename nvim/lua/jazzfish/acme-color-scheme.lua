-- colors/acme.lua
local M = {}

-- Color palette
M.colors = {
    bg = '#ffffd7', -- Slightly darker yellow background
    fg = '#000000', -- Black text
    comment = '#999999', -- Grey for comments
    selection = '#eeee9e', -- Darker yellow for selection
    subtle = '#eaffff', -- Very light blue for subtle highlights
    statusline = '#eaffff', -- Light blue for status line
    statusline_inactive = '#c4f2f2', -- Light blue for status line
    error = '#ff0000', -- Red for errors
    warning = '#888822' -- Dark yellow for warnings
}

-- Highlight group definitions
M.highlights = {
    -- Editor UI
    Normal = {fg = M.colors.fg, bg = M.colors.bg},
    NonText = {fg = M.colors.comment},
    Visual = {bg = M.colors.selection},
    Search = {bg = M.colors.selection, bold = true},
    IncSearch = {bg = M.colors.selection, bold = true},
    StatusLine = {fg = M.colors.fg, bg = M.colors.statusline},
    StatusLineNC = {fg = M.colors.comment, bg = M.colors.statusline},
    SignColumn = {fg = M.colors.fg, bg = M.colors.bg},
    VertSplit = {fg = M.colors.comment, bg = M.colors.bg},
    LineNr = {fg = M.colors.comment, bg = M.colors.bg},
    CursorLine = {bg = M.colors.subtle},
    CursorLineNr = {fg = M.colors.fg, bold = true},
    Folded = {fg = M.colors.comment, bg = M.colors.subtle},
    FoldColumn = {fg = M.colors.comment, bg = M.colors.bg},
    MatchParen = {bg = M.colors.selection, bold = true},
    ColorColumn = {bg = M.colors.subtle},
    Conceal = {fg = M.colors.comment},
    Directory = {fg = M.colors.fg},
    WarningMsg = {fg = M.colors.warning},
    ErrorMsg = {fg = M.colors.error},
    MoreMsg = {fg = M.colors.fg},
    ModeMsg = {fg = M.colors.fg},
    CursorColumn = {bg = M.colors.subtle},
    TabLine = {fg = M.colors.comment, bg = M.colors.statusline},
    TabLineSel = {fg = M.colors.fg, bg = M.colors.bg},
    TabLineFill = {bg = M.colors.statusline},
    -- Syntax highlighting (minimal)
    Comment = {fg = M.colors.comment},
    String = {fg = M.colors.fg},
    Number = {fg = M.colors.fg},
    Float = {fg = M.colors.fg},
    Boolean = {fg = M.colors.fg},
    Character = {fg = M.colors.fg},
    Constant = {fg = M.colors.fg},
    Identifier = {fg = M.colors.fg},
    Function = {fg = M.colors.fg},
    Statement = {fg = M.colors.fg},
    Operator = {fg = M.colors.fg},
    Keyword = {fg = M.colors.fg},
    Type = {fg = M.colors.fg},
    Special = {fg = M.colors.fg},
    PreProc = {fg = M.colors.fg},
    Todo = {fg = M.colors.comment, bold = true},
    -- Diagnostic highlights
    DiagnosticError = {fg = M.colors.error},
    DiagnosticWarn = {fg = M.colors.warning},
    DiagnosticInfo = {fg = M.colors.comment},
    DiagnosticHint = {fg = M.colors.comment},
    DiagnosticUnderlineError = {undercurl = true, sp = M.colors.error},
    DiagnosticUnderlineWarn = {undercurl = true, sp = M.colors.warning},
    DiagnosticUnderlineInfo = {undercurl = true, sp = M.colors.comment},
    DiagnosticUnderlineHint = {undercurl = true, sp = M.colors.comment},
    -- Git highlights
    DiffAdd = {bg = '#2a4d30'},
    DiffChange = {bg = '#252525'},
    DiffDelete = {bg = '#4d2a2a'},
    DiffText = {bg = '#3a6640', bold = true},
    -- Popup menu
    Pmenu = {fg = M.colors.fg, bg = M.colors.subtle},
    PmenuSel = {fg = M.colors.fg, bg = M.colors.selection},
    PmenuSbar = {bg = M.colors.subtle},
    PmenuThumb = {bg = M.colors.comment}
}

-- Setup function
function M.setup(opts)
    -- Override defaults with any user options
    if opts then
        M.colors = vim.tbl_deep_extend("force", M.colors, opts.colors or {})
        M.highlights = vim.tbl_deep_extend("force", M.highlights,
                                           opts.highlights or {})
    end

    -- Reset all highlights
    vim.cmd('highlight clear')
    if vim.fn.exists('syntax_on') then vim.cmd('syntax reset') end

    -- Set background and colorscheme name
    vim.o.background = 'light'
    vim.g.colors_name = 'acme'

    -- Set all highlights
    for group, settings in pairs(M.highlights) do
        vim.api.nvim_set_hl(0, group, settings)
    end

    require('lualine').setup {
        options = {
            theme = {
                normal = {
                    a = {fg = M.colors.fg, bg = M.colors.statusline},
                    b = {fg = M.colors.fg, bg = M.colors.statusline},
                    c = {fg = M.colors.fg, bg = M.colors.statusline}
                },
                insert = {
                    a = {fg = M.colors.fg, bg = M.colors.statusline},
                    b = {fg = M.colors.fg, bg = M.colors.statusline},
                    c = {fg = M.colors.fg, bg = M.colors.statusline}
                },
                visual = {
                    a = {fg = M.colors.fg, bg = M.colors.statusline},
                    b = {fg = M.colors.fg, bg = M.colors.statusline},
                    c = {fg = M.colors.fg, bg = M.colors.statusline}
                },
                replace = {
                    a = {fg = M.colors.fg, bg = M.colors.statusline},
                    b = {fg = M.colors.fg, bg = M.colors.statusline},
                    c = {fg = M.colors.fg, bg = M.colors.statusline}
                },
                command = {
                    a = {fg = M.colors.fg, bg = M.colors.statusline},
                    b = {fg = M.colors.fg, bg = M.colors.statusline},
                    c = {fg = M.colors.fg, bg = M.colors.statusline}
                },
                inactive = {
                    a = {
                        fg = M.colors.comment,
                        bg = M.colors.statusline_inactive
                    },
                    b = {
                        fg = M.colors.comment,
                        bg = M.colors.statusline_inactive
                    },
                    c = {
                        fg = M.colors.comment,
                        bg = M.colors.statusline_inactive
                    }
                }
            }
        }
    }

    -- Disable TreeSitter highlighting for ultra-minimal look
    vim.cmd('TSDisable highlight')
end

return M
