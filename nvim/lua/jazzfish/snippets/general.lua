-- =============================================================================
-- GENERAL PROGRAMMING SNIPPETS
-- =============================================================================
-- General programming snippets for common patterns

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local rep = require("luasnip.extras").rep

-- General programming snippets
ls.add_snippets("all", {
    -- TODO comment
    s("todo", {
        t({"TODO: ", ""}),
        i(1, "todo message"),
    }),
    
    -- FIXME comment
    s("fixme", {
        t({"FIXME: ", ""}),
        i(1, "fixme message"),
    }),
    
    -- NOTE comment
    s("note", {
        t({"NOTE: ", ""}),
        i(1, "note message"),
    }),
    
    -- HACK comment
    s("hack", {
        t({"HACK: ", ""}),
        i(1, "hack message"),
    }),
    
    -- XXX comment
    s("xxx", {
        t({"XXX: ", ""}),
        i(1, "xxx message"),
    }),
    
    -- Function documentation
    s("doc", {
        t({"--- ", ""}),
        i(1, "function description"),
        t({"", ""}),
        t({"--- @param ", ""}),
        i(2, "param_name"),
        t({" ", ""}),
        i(3, "param_type"),
        t({" ", ""}),
        i(4, "param_description"),
        t({"", ""}),
        t({"--- @return ", ""}),
        i(5, "return_type"),
        t({" ", ""}),
        i(6, "return_description"),
    }),
    
    -- Section divider
    s("divider", {
        t({"-- =============================================================================", ""}),
        t({"-- ", ""}),
        i(1, "SECTION_NAME"),
        t({"", ""}),
        t({"-- =============================================================================", ""}),
    }),
    
    -- Simple comment block
    s("comment", {
        t({"-- ", ""}),
        i(1, "comment text"),
    }),
    
    -- Multi-line comment block
    s("commentblock", {
        t({"--[[", ""}),
        t({"    ", ""}),
        i(1, "comment block"),
        t({"", ""}),
        t({"]]"}),
    }),
    
    -- Error handling
    s("error", {
        t({"local ok, result = pcall(", ""}),
        i(1, "function_call"),
        t({")", ""}),
        t({"if not ok then", ""}),
        t({"    ", ""}),
        i(2, "-- error handling"),
        t({"", ""}),
        t({"end"}),
    }),
    
    -- Table iteration
    s("pairs", {
        t({"for ", ""}),
        i(1, "key"),
        t({", ", ""}),
        i(2, "value"),
        t({" in pairs(", ""}),
        i(3, "table"),
        t({") do", ""}),
        t({"    ", ""}),
        i(4, "-- iteration body"),
        t({"", ""}),
        t({"end"}),
    }),
    
    -- Array iteration
    s("ipairs", {
        t({"for ", ""}),
        i(1, "index"),
        t({", ", ""}),
        i(2, "value"),
        t({" in ipairs(", ""}),
        i(3, "array"),
        t({") do", ""}),
        t({"    ", ""}),
        i(4, "-- iteration body"),
        t({"", ""}),
        t({"end"}),
    }),
    
    -- Conditional assignment
    s("cond", {
        t({"local ", ""}),
        i(1, "variable"),
        t({" = ", ""}),
        i(2, "condition"),
        t({" and ", ""}),
        i(3, "true_value"),
        t({" or ", ""}),
        i(4, "false_value"),
    }),
    
    -- String concatenation
    s("concat", {
        t({"local ", ""}),
        i(1, "result"),
        t({" = ", ""}),
        i(2, "string1"),
        t({" .. ", ""}),
        i(3, "string2"),
    }),
    
    -- String format
    s("format", {
        t({"string.format('", ""}),
        i(1, "format_string"),
        t({"', ", ""}),
        i(2, "values"),
        t({")"}),
    }),
    
    -- Table insert
    s("insert", {
        t({"table.insert(", ""}),
        i(1, "table"),
        t({", ", ""}),
        i(2, "value"),
        t({")"}),
    }),
    
    -- Table remove
    s("remove", {
        t({"table.remove(", ""}),
        i(1, "table"),
        t({", ", ""}),
        i(2, "index"),
        t({")"}),
    }),
    
    -- Type checking
    s("type", {
        t({"if type(", ""}),
        i(1, "variable"),
        t({") == '", ""}),
        i(2, "expected_type"),
        t({"' then", ""}),
        t({"    ", ""}),
        i(3, "-- type-specific code"),
        t({"", ""}),
        t({"end"}),
    }),
    
    -- Nil check
    s("nilcheck", {
        t({"if ", ""}),
        i(1, "variable"),
        t({" then", ""}),
        t({"    ", ""}),
        i(2, "-- not nil code"),
        t({"", ""}),
        t({"end"}),
    }),
    
    -- Deep copy
    s("deepcopy", {
        t({"local function deep_copy(", ""}),
        i(1, "obj"),
        t({")", ""}),
        t({"    if type(", ""}),
        rep(1),
        t({") ~= 'table' then", ""}),
        t({"        return ", ""}),
        rep(1),
        t({"", ""}),
        t({"    end", ""}),
        t({"    local copy = {}", ""}),
        t({"    for k, v in pairs(", ""}),
        rep(1),
        t({") do", ""}),
        t({"        copy[k] = deep_copy(v)", ""}),
        t({"    end", ""}),
        t({"    return copy", ""}),
        t({"end"}),
    }),
    
    -- Shallow copy
    s("copy", {
        t({"local function copy(", ""}),
        i(1, "obj"),
        t({")", ""}),
        t({"    local copy = {}", ""}),
        t({"    for k, v in pairs(", ""}),
        rep(1),
        t({") do", ""}),
        t({"        copy[k] = v", ""}),
        t({"    end", ""}),
        t({"    return copy", ""}),
        t({"end"}),
    }),
}) 