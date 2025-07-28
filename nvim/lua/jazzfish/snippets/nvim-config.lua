-- =============================================================================
-- NEOVIM CONFIG SNIPPETS
-- =============================================================================
-- Snippets specifically for Neovim configuration files

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

-- Neovim config snippets
ls.add_snippets("lua", {
    -- Lazy.nvim plugin entry
    s("lazy", {
        t({"    {", ""}),
        t({"        '", ""}),
        i(1, "plugin/name"),
        t({"',", ""}),
        t({"        dependencies = {", ""}),
        i(2, "dependencies"),
        t({"        },", ""}),
        t({"        config = function()", ""}),
        t({"            require('", ""}),
        rep(1),
        t({"').setup({", ""}),
        t({"                ", ""}),
        i(3, "-- config options"),
        t({"", ""}),
        t({"            })", ""}),
        t({"        end", ""}),
        t({"    }, --"}),
    }),
    
    -- Simple plugin entry
    s("plugin", {
        t({"    {'", ""}),
        i(1, "plugin/name"),
        t({"'}, --"}),
    }),
    
    -- Section header
    s("section", {
        t({"    ---------------------------------------------------------------------------------------- ", ""}),
        t({"    ---- ", ""}),
        i(1, "SECTION_NAME"),
        t({" ", ""}),
        t({"    ---------------------------------------------------------------------------------------- ", ""}),
    }),
    
    -- Keymap with description
    s("keymap", {
        t({"vim.keymap.set('", ""}),
        i(1, "n"),
        t({"', '", ""}),
        i(2, "key"),
        t({"', ", ""}),
        i(3, "function"),
        t({", {", ""}),
        t({"desc = '", ""}),
        i(4, "description"),
        t({"'", ""}),
        t({"})"}),
    }),
    
    -- Autocmd with description
    s("autocmd", {
        t({"vim.api.nvim_create_autocmd('", ""}),
        i(1, "event"),
        t({"', {", ""}),
        t({"    desc = '", ""}),
        i(2, "description"),
        t({"',", ""}),
        t({"    callback = function()", ""}),
        t({"        ", ""}),
        i(3, "-- autocmd body"),
        t({"", ""}),
        t({"    end", ""}),
        t({"})"}),
    }),
    
    -- Option setting
    s("opt", {
        t({"vim.opt.", ""}),
        i(1, "option_name"),
        t({" = ", ""}),
        i(2, "value"),
    }),
    
    -- Highlight group
    s("highlight", {
        t({"vim.api.nvim_set_hl(0, '", ""}),
        i(1, "group_name"),
        t({"', {", ""}),
        t({"    ", ""}),
        i(2, "highlight_options"),
        t({"", ""}),
        t({"})"}),
    }),
    
    -- Command definition
    s("command", {
        t({"vim.api.nvim_create_user_command('", ""}),
        i(1, "CommandName"),
        t({"', function()", ""}),
        t({"    ", ""}),
        i(2, "-- command body"),
        t({"", ""}),
        t({"end, {", ""}),
        t({"    ", ""}),
        i(3, "-- command options"),
        t({"", ""}),
        t({"})"}),
    }),
    
    -- Buffer-local keymap
    s("bufkeymap", {
        t({"vim.keymap.set('", ""}),
        i(1, "n"),
        t({"', '", ""}),
        i(2, "key"),
        t({"', ", ""}),
        i(3, "function"),
        t({", {", ""}),
        t({"    buffer = ", ""}),
        i(4, "bufnr"),
        t({"", ""}),
        t({"})"}),
    }),
    
    -- LSP setup
    s("lspsetup", {
        t({"lspconfig.", ""}),
        i(1, "language_server"),
        t({".setup({", ""}),
        t({"    capabilities = lsp_capabilities,", ""}),
        t({"    ", ""}),
        i(2, "-- additional config"),
        t({"", ""}),
        t({"})"}),
    }),
    
    -- Telescope finder
    s("telescope", {
        t({"vim.keymap.set('n', '<leader>", ""}),
        i(1, "key"),
        t({"', require('telescope.builtin').", ""}),
        i(2, "finder"),
        t({", {", ""}),
        t({"    desc = '", ""}),
        i(3, "description"),
        t({"'", ""}),
        t({"})"}),
    }),
    
    -- Plugin setup
    s("setup", {
        t({"require('", ""}),
        i(1, "plugin_name"),
        t({"').setup({", ""}),
        t({"    ", ""}),
        i(2, "-- setup options"),
        t({"", ""}),
        t({"})"}),
    }),
    
    -- File type autocmd
    s("filetype", {
        t({"vim.api.nvim_create_autocmd('FileType', {", ""}),
        t({"    pattern = {", ""}),
        t({"        '", ""}),
        i(1, "filetype"),
        t({"',", ""}),
        t({"    },", ""}),
        t({"    callback = function()", ""}),
        t({"        ", ""}),
        i(2, "-- filetype-specific setup"),
        t({"", ""}),
        t({"    end", ""}),
        t({"})"}),
    }),
    
    -- BufWritePre autocmd
    s("bufwritepre", {
        t({"vim.api.nvim_create_autocmd('BufWritePre', {", ""}),
        t({"    pattern = {", ""}),
        t({"        '", ""}),
        i(1, "*.ext"),
        t({"',", ""}),
        t({"    },", ""}),
        t({"    callback = function()", ""}),
        t({"        ", ""}),
        i(2, "-- pre-write action"),
        t({"", ""}),
        t({"    end", ""}),
        t({"})"}),
    }),
}) 