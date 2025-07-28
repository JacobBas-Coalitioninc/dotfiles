-- =============================================================================
-- LUA SNIPPETS
-- =============================================================================
-- Lua-specific snippets for Neovim configuration and Lua programming

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

-- Lua module template
ls.add_snippets("lua", {
    s("module", {
        t({"local M = {}", ""}),
        t({"", ""}),
        t({"M.setup = function()", ""}),
        t({"    -- TODO: Add setup logic", ""}),
        t({"end", ""}),
        t({"", ""}),
        t({"return M"}),
    }),
    
    -- Function with documentation
    s("func", {
        t({"--- ", ""}),
        t({"--- @param ", ""}),
        t({"--- @return ", ""}),
        t({"local function ", ""}),
        i(1, "function_name"),
        t({"(", ""}),
        i(2, "params"),
        t({")", ""}),
        t({"    ", ""}),
        i(3, "-- function body"),
        t({"", ""}),
        t({"end"}),
    }),
    
    -- Local variable
    s("local", {
        t({"local ", ""}),
        i(1, "variable_name"),
        t({" = ", ""}),
        i(2, "value"),
    }),
    
    -- Table definition
    s("table", {
        t({"local ", ""}),
        i(1, "table_name"),
        t({" = {", ""}),
        t({"    ", ""}),
        i(2, "-- table contents"),
        t({"", ""}),
        t({"}"}),
    }),
    
    -- If statement
    s("if", {
        t({"if ", ""}),
        i(1, "condition"),
        t({" then", ""}),
        t({"    ", ""}),
        i(2, "-- if body"),
        t({"", ""}),
        t({"end"}),
    }),
    
    -- If-else statement
    s("ifelse", {
        t({"if ", ""}),
        i(1, "condition"),
        t({" then", ""}),
        t({"    ", ""}),
        i(2, "-- if body"),
        t({"", ""}),
        t({"else", ""}),
        t({"    ", ""}),
        i(3, "-- else body"),
        t({"", ""}),
        t({"end"}),
    }),
    
    -- For loop
    s("for", {
        t({"for ", ""}),
        i(1, "i"),
        t({" = ", ""}),
        i(2, "1"),
        t({", ", ""}),
        i(3, "10"),
        t({" do", ""}),
        t({"    ", ""}),
        i(4, "-- loop body"),
        t({"", ""}),
        t({"end"}),
    }),
    
    -- For pairs loop
    s("forpairs", {
        t({"for ", ""}),
        i(1, "key"),
        t({", ", ""}),
        i(2, "value"),
        t({" in pairs(", ""}),
        i(3, "table"),
        t({") do", ""}),
        t({"    ", ""}),
        i(4, "-- loop body"),
        t({"", ""}),
        t({"end"}),
    }),
    
    -- Require statement
    s("req", {
        t({"local ", ""}),
        i(1, "module_name"),
        t({" = require('", ""}),
        rep(1),
        t({"')"}),
    }),
    
    -- Print debug
    s("print", {
        t({"print('", ""}),
        i(1, "debug message"),
        t({"')"}),
    }),
    
    -- Vim API call
    s("vimapi", {
        t({"vim.api.nvim_", ""}),
        i(1, "api_call"),
        t({"(", ""}),
        i(2, "args"),
        t({")"}),
    }),
    
    -- Vim keymap
    s("keymap", {
        t({"vim.keymap.set('", ""}),
        i(1, "n"),
        t({"', '", ""}),
        i(2, "key"),
        t({"', ", ""}),
        i(3, "function"),
        t({", {", ""}),
        i(4, "opts"),
        t({"})"}),
    }),
    
    -- Autocmd
    s("autocmd", {
        t({"vim.api.nvim_create_autocmd('", ""}),
        i(1, "event"),
        t({"', {", ""}),
        t({"    callback = function()", ""}),
        t({"        ", ""}),
        i(2, "-- autocmd body"),
        t({"", ""}),
        t({"    end", ""}),
        t({"})"}),
    }),
    
    -- Plugin config
    s("plugin", {
        t({"    {", ""}),
        t({"        '", ""}),
        i(1, "plugin/name"),
        t({"',", ""}),
        t({"        config = function()", ""}),
        t({"            require('", ""}),
        rep(1),
        t({"').setup({", ""}),
        t({"                ", ""}),
        i(2, "-- config options"),
        t({"", ""}),
        t({"            })", ""}),
        t({"        end", ""}),
        t({"    }, --"}),
    }),
}) 