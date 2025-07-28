-- =============================================================================
-- SNIPPETS INITIALIZATION
-- =============================================================================
-- This file loads all snippet categories and sets up the snippet system

local M = {}

-- Load all snippet categories
local function load_snippets()
    -- Load Lua snippets
    require('jazzfish.snippets.lua')
    
    -- Load Neovim config snippets
    require('jazzfish.snippets.nvim-config')
    
    -- Load general programming snippets
    require('jazzfish.snippets.general')
    
    -- Load documentation snippets
    require('jazzfish.snippets.documentation')
    
    -- Load debugging snippets
    require('jazzfish.snippets.debugging')
end

-- Initialize snippets
M.setup = function()
    load_snippets()
end

return M 