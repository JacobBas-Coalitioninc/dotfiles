-- =============================================================================
-- DEBUGGING SNIPPETS
-- =============================================================================
-- Snippets for debugging and development

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

-- Debugging snippets
ls.add_snippets("lua", {
    -- Debug print
    s("debug", {
        t({"print('DEBUG: ", ""}),
        i(1, "debug message"),
        t({"')"}),
    }),
    
    -- Debug print with variable
    s("debugvar", {
        t({"print('DEBUG: ", ""}),
        i(1, "variable_name"),
        t({" = ' .. tostring(", ""}),
        rep(1),
        t({"))"}),
    }),
    
    -- Debug print with table
    s("debugtable", {
        t({"print('DEBUG: ", ""}),
        i(1, "table_name"),
        t({" = ' .. vim.inspect(", ""}),
        rep(1),
        t({"))"}),
    }),
    
    -- Debug function entry
    s("debugfunc", {
        t({"print('DEBUG: Entering function ", ""}),
        i(1, "function_name"),
        t({"')"}),
    }),
    
    -- Debug function exit
    s("debugexit", {
        t({"print('DEBUG: Exiting function ", ""}),
        i(1, "function_name"),
        t({"')"}),
    }),
    
    -- Debug with line number
    s("debugline", {
        t({"print('DEBUG: Line ", ""}),
        i(1, "line_info"),
        t({" - ", ""}),
        i(2, "debug message"),
        t({"')"}),
    }),
    
    -- Error handling with debug
    s("debugerror", {
        t({"local ok, result = pcall(", ""}),
        i(1, "function_call"),
        t({")", ""}),
        t({"if not ok then", ""}),
        t({"    print('ERROR: ' .. tostring(result))", ""}),
        t({"    ", ""}),
        i(2, "-- error handling"),
        t({"", ""}),
        t({"end"}),
    }),
    
    -- Performance timing
    s("debugtime", {
        t({"local start_time = vim.loop.hrtime()", ""}),
        t({"", ""}),
        i(1, "-- code to time"),
        t({"", ""}),
        t({"local end_time = vim.loop.hrtime()", ""}),
        t({"print('DEBUG: Time taken: ' .. (end_time - start_time) / 1000000 .. 'ms')"}),
    }),
    
    -- Memory usage
    s("debugmem", {
        t({"local mem_before = collectgarbage('count')", ""}),
        t({"", ""}),
        i(1, "-- code to measure"),
        t({"", ""}),
        t({"local mem_after = collectgarbage('count')", ""}),
        t({"print('DEBUG: Memory used: ' .. (mem_after - mem_before) .. ' KB')"}),
    }),
    
    -- Conditional debug
    s("debugif", {
        t({"if vim.g.debug then", ""}),
        t({"    print('DEBUG: ", ""}),
        i(1, "debug message"),
        t({"')", ""}),
        t({"end"}),
    }),
    
    -- Debug with context
    s("debugctx", {
        t({"print('DEBUG: Context - ", ""}),
        i(1, "context_info"),
        t({" - ", ""}),
        i(2, "debug message"),
        t({"')"}),
    }),
    
    -- Debug table contents
    s("debugdump", {
        t({"print('DEBUG: Dumping table ", ""}),
        i(1, "table_name"),
        t({"')", ""}),
        t({"for k, v in pairs(", ""}),
        rep(1),
        t({") do", ""}),
        t({"    print('  ' .. tostring(k) .. ' = ' .. tostring(v))", ""}),
        t({"end"}),
    }),
    
    -- Debug function arguments
    s("debugargs", {
        t({"print('DEBUG: Function arguments:')", ""}),
        t({"for i, arg in ipairs({", ""}),
        i(1, "arg1, arg2, arg3"),
        t({"}) do", ""}),
        t({"    print('  ' .. i .. ' = ' .. tostring(arg))", ""}),
        t({"end"}),
    }),
    
    -- Debug with stack trace
    s("debugstack", {
        t({"print('DEBUG: Stack trace:')", ""}),
        t({"for i = 1, 10 do", ""}),
        t({"    local info = debug.getinfo(i)", ""}),
        t({"    if not info then break end", ""}),
        t({"    print('  ' .. i .. ': ' .. (info.name or 'unknown') .. ' in ' .. (info.source or 'unknown'))", ""}),
        t({"end"}),
    }),
    
    -- Debug with file info
    s("debugfile", {
        t({"print('DEBUG: File: ' .. vim.fn.expand('%:p'))", ""}),
        t({"print('DEBUG: Line: ' .. vim.fn.line('.'))", ""}),
        t({"print('DEBUG: Column: ' .. vim.fn.col('.'))"}),
    }),
    
    -- Debug with buffer info
    s("debugbuf", {
        t({"print('DEBUG: Buffer: ' .. vim.fn.bufnr())", ""}),
        t({"print('DEBUG: Buffer name: ' .. vim.fn.bufname())", ""}),
        t({"print('DEBUG: File type: ' .. vim.bo.filetype)"}),
    }),
    
    -- Debug with window info
    s("debugwin", {
        t({"print('DEBUG: Window: ' .. vim.fn.winnr())", ""}),
        t({"print('DEBUG: Tab: ' .. vim.fn.tabpagenr())", ""}),
        t({"print('DEBUG: Window count: ' .. vim.fn.winnr('$'))"}),
    }),
    
    -- Debug with mode info
    s("debugmode", {
        t({"print('DEBUG: Mode: ' .. vim.fn.mode())", ""}),
        t({"print('DEBUG: Visual mode: ' .. vim.fn.visualmode())", ""}),
        t({"print('DEBUG: Insert mode: ' .. tostring(vim.fn.mode() == 'i'))"}),
    }),
    
    -- Debug with register info
    s("debugreg", {
        t({"print('DEBUG: Register: ' .. vim.fn.getreg('\"'))", ""}),
        t({"print('DEBUG: Register type: ' .. vim.fn.getregtype('\"'))"}),
    }),
    
    -- Debug with option value
    s("debugopt", {
        t({"print('DEBUG: Option ", ""}),
        i(1, "option_name"),
        t({" = ' .. tostring(vim.opt.", ""}),
        rep(1),
        t({":get()))"}),
    }),
    
    -- Debug with global variable
    s("debuggvar", {
        t({"print('DEBUG: Global ", ""}),
        i(1, "variable_name"),
        t({" = ' .. tostring(vim.g.", ""}),
        rep(1),
        t({"))"}),
    }),
    
    -- Debug with local variable
    s("debuglvar", {
        t({"print('DEBUG: Local ", ""}),
        i(1, "variable_name"),
        t({" = ' .. tostring(", ""}),
        rep(1),
        t({"))"}),
    }),
}) 