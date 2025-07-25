local vim = vim

-- Window Management and Navigation
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<cr>", {}) -- split window vertically
vim.keymap.set("n", "<leader>wh", "<cmd>split<cr>", {}) -- split window horizontally
vim.keymap.set("n", "<leader>w<Left>", "<C-w>h", {}) -- move to left window
vim.keymap.set("n", "<leader>w<Right>", "<C-w>l", {}) -- move to right window
vim.keymap.set("n", "<leader>w<Down>", "<C-w>j", {}) -- move to down window
vim.keymap.set("n", "<leader>w<Up>", "<C-w>k", {}) -- move to up window
vim.keymap.set("n", "<leader>b", "<C-o>", {}) -- go to previous cursor position

-- Diffview Plugin Toggle
vim.keymap.set("n", "<leader>dv", "<cmd>DiffviewToggle<cr>", {desc = "Toggle Diffview"})

-- Clipboard Operations
-- Copy visual selection to system clipboard
vim.keymap.set("v", "<leader>yc", '"+y', {})

-- Copy file path and selected line range (relative to project root) to system clipboard
-- Formats as @path/to/file.lua:start_line-end_line for Gemini context
vim.keymap.set("v", "<leader>yl", function()
  local file_path = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':.')
  local start_line = vim.fn.line('v')
  local end_line = vim.fn.line('.')
  local location_string = string.format("@%s:%d-%d", file_path, start_line, end_line)
  vim.fn.setreg('+', location_string)
  vim.notify("Copied: " .. location_string, vim.log.levels.INFO)
end, {desc = "Copy file location and line range"})

-- CSV File Specific Settings and Mappings
-- Automatically enter insert mode when opening a terminal buffer
vim.cmd("autocmd TermOpen * startinsert")
-- Automatically delete terminal buffer when it closes
vim.cmd("autocmd TermClose * execute 'bdelete! ' . expand('<abuf>')")
-- Open VisiData (vd) for the current file in a terminal
vim.keymap.set("n", "<leader>vd", "<cmd>terminal vd % startinsert <cr>")

-- Notes Management Shortcuts
-- Define a custom command to update notes using a Go script
vim.cmd([[command! UpdateNotes execute '!go run ~/.notes/create_main.go']])
-- Open the main notes file
vim.keymap.set("n", "<leader>nm", "<cmd>e ~/.notes/main.txt<cr>", {}) -- opens up a notes file within my notes directory
-- Execute the notes update command
vim.keymap.set("n", "<leader>nu", "<cmd>UpdateNotes<cr>", {}) -- update notes with the go script

-- GBrowse Integration
-- Custom command to open the current file in a browser (requires vim.rhubarb and 'open' command)
vim.cmd[[command! -nargs=1 Browse silent execute '!open' shellescape(<q-args>,1)]]
