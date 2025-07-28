-- =============================================================================
-- DOCUMENTATION SNIPPETS
-- =============================================================================
-- Snippets for documentation and README files

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Documentation snippets
ls.add_snippets("markdown", {
    -- README header
    s("readme", {
        t({"# ", ""}),
        i(1, "Project Name"),
        t({"", ""}),
        t({"", ""}),
        t({"## Description", ""}),
        t({"", ""}),
        i(2, "Project description"),
        t({"", ""}),
        t({"## Installation", ""}),
        t({"", ""}),
        t({"```bash", ""}),
        i(3, "installation commands"),
        t({"", ""}),
        t({"```", ""}),
        t({"", ""}),
        t({"## Usage", ""}),
        t({"", ""}),
        i(4, "usage instructions"),
        t({"", ""}),
        t({"## Configuration", ""}),
        t({"", ""}),
        i(5, "configuration details"),
        t({"", ""}),
        t({"## Contributing", ""}),
        t({"", ""}),
        i(6, "contributing guidelines"),
        t({"", ""}),
        t({"## License", ""}),
        t({"", ""}),
        i(7, "license information"),
    }),
    
    -- Section header
    s("section", {
        t({"## ", ""}),
        i(1, "Section Title"),
        t({"", ""}),
        t({"", ""}),
        i(2, "section content"),
    }),
    
    -- Subsection header
    s("subsection", {
        t({"### ", ""}),
        i(1, "Subsection Title"),
        t({"", ""}),
        t({"", ""}),
        i(2, "subsection content"),
    }),
    
    -- Code block
    s("code", {
        t({"```", ""}),
        i(1, "language"),
        t({"", ""}),
        i(2, "code content"),
        t({"", ""}),
        t({"```", ""}),
    }),
    
    -- Inline code
    s("inline", {
        t({"`", ""}),
        i(1, "inline code"),
        t({"`"}),
    }),
    
    -- Link
    s("link", {
        t({"[", ""}),
        i(1, "link text"),
        t({"](", ""}),
        i(2, "url"),
        t({")"}),
    }),
    
    -- Image
    s("image", {
        t({"![", ""}),
        i(1, "alt text"),
        t({"](", ""}),
        i(2, "image url"),
        t({")"}),
    }),
    
    -- List item
    s("li", {
        t({"- ", ""}),
        i(1, "list item"),
    }),
    
    -- Numbered list item
    s("nli", {
        t({"1. ", ""}),
        i(1, "numbered list item"),
    }),
    
    -- Bold text
    s("bold", {
        t({"**", ""}),
        i(1, "bold text"),
        t({"**"}),
    }),
    
    -- Italic text
    s("italic", {
        t({"_", ""}),
        i(1, "italic text"),
        t({"_"}),
    }),
    
    -- Quote block
    s("quote", {
        t({"> ", ""}),
        i(1, "quoted text"),
    }),
    
    -- Table header
    s("table", {
        t({"| ", ""}),
        i(1, "Column 1"),
        t({" | ", ""}),
        i(2, "Column 2"),
        t({" | ", ""}),
        i(3, "Column 3"),
        t({" |", ""}),
        t({"| --- | --- | --- |", ""}),
        t({"| ", ""}),
        i(4, "Row 1 Col 1"),
        t({" | ", ""}),
        i(5, "Row 1 Col 2"),
        t({" | ", ""}),
        i(6, "Row 1 Col 3"),
        t({" |", ""}),
    }),
    
    -- Task list item
    s("task", {
        t({"- [ ] ", ""}),
        i(1, "task description"),
    }),
    
    -- Completed task
    s("done", {
        t({"- [x] ", ""}),
        i(1, "completed task"),
    }),
    
    -- Horizontal rule
    s("hr", {
        t({"---", ""}),
    }),
    
    -- Footnote
    s("footnote", {
        t({"[^", ""}),
        i(1, "footnote_id"),
        t({"]: ", ""}),
        i(2, "footnote text"),
    }),
    
    -- Footnote reference
    s("fnref", {
        t({"[^", ""}),
        i(1, "footnote_id"),
        t({"]"}),
    }),
})

-- Lua documentation snippets
ls.add_snippets("lua", {
    -- Module documentation
    s("moddoc", {
        t({"---@module ", ""}),
        i(1, "module_name"),
        t({"", ""}),
        t({"--- ", ""}),
        i(2, "module description"),
        t({"", ""}),
        t({"--- @field ", ""}),
        i(3, "field_name"),
        t({" ", ""}),
        i(4, "field_type"),
        t({" ", ""}),
        i(5, "field_description"),
    }),
    
    -- Function documentation
    s("funcdoc", {
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
    
    -- Variable documentation
    s("vardoc", {
        t({"--- @type ", ""}),
        i(1, "variable_type"),
        t({" ", ""}),
        i(2, "variable_name"),
        t({" ", ""}),
        i(3, "variable_description"),
    }),
    
    -- Class documentation
    s("classdoc", {
        t({"---@class ", ""}),
        i(1, "class_name"),
        t({"", ""}),
        t({"--- ", ""}),
        i(2, "class description"),
        t({"", ""}),
        t({"--- @field ", ""}),
        i(3, "field_name"),
        t({" ", ""}),
        i(4, "field_type"),
        t({" ", ""}),
        i(5, "field_description"),
    }),
}) 