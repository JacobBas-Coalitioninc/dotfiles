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

-- =============================================================================
-- AI-ASSISTED EDITING COPY COMMANDS
-- =============================================================================
-- These commands copy various file and code contexts to the system clipboard
-- in formats that AI assistants (like Cursor, ChatGPT, etc.) can easily parse
-- and understand. All commands use the leader key + 'y' + [specific key].
--
-- Usage Examples:
--   <leader>yp  -> Copies: "nvim/lua/jazzfish/remap.lua"
--   <leader>yn  -> Copies: "nvim/lua/jazzfish/remap.lua#L25"
--   <leader>yl  -> Copies: "nvim/lua/jazzfish/remap.lua#L15-L24"
--   <leader>ye  -> Copies: "nvim/lua/jazzfish/remap.lua#L23-L27 (error context)"
--   <leader>yf  -> Copies: "nvim/lua/jazzfish/remap.lua#L25 (function: setup_keymaps)"
--   <leader>ys  -> Copies: "nvim/lua/jazzfish/remap.lua#L25 (symbol: vim.keymap.set)"
--   <leader>yd  -> Copies: "Directory: nvim/lua/jazzfish\nFile: remap.lua"
--   <leader>yg  -> Copies: "nvim/lua/jazzfish/remap.lua#L25 (commit: a1b2c3d4)"
-- =============================================================================

-- Copy file path (relative to project root) to system clipboard
-- Output: "path/to/file.lua"
-- Use case: When you want to reference the entire file to an AI assistant
vim.keymap.set("n", "<leader>yp", function()
  local file_path = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':.')
  local location_string = string.format("%s", file_path)
  vim.fn.setreg('+', location_string)
  vim.notify("Copied file path: " .. location_string, vim.log.levels.INFO)
end, {desc = "Copy file path"})

-- Copy current line number for precise AI references
-- Output: "path/to/file.lua#L25"
-- Use case: When you want to point AI to a specific line in the file
vim.keymap.set("n", "<leader>yn", function()
  local line_num = vim.fn.line('.')
  local file_path = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':.')
  local location_string = string.format("%s#L%d", file_path, line_num)
  vim.fn.setreg('+', location_string)
  vim.notify("Copied line reference: " .. location_string, vim.log.levels.INFO)
end, {desc = "Copy current line number"})

-- Copy file path and selected line range (relative to project root) to system clipboard
-- Output: "path/to/file.lua#L15-L24"
-- Use case: When you want to reference a specific range of lines (visual selection)
vim.keymap.set("v", "<leader>yl", function()
  local file_path = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':.')
  local start_line = vim.fn.line('v')
  local end_line = vim.fn.line('.')
  local location_string = string.format("%s#L%d-L%d", file_path, start_line, end_line)
  vim.fn.setreg('+', location_string)
  vim.notify("Copied line range: " .. location_string, vim.log.levels.INFO)
end, {desc = "Copy file location and line range"})

-- Copy error context with surrounding lines (5 lines total)
-- Output: "path/to/file.lua#L23-L27 (error context)"
-- Use case: When reporting errors to AI, includes context around the error line
vim.keymap.set("n", "<leader>ye", function()
  local file_path = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':.')
  local current_line = vim.fn.line('.')
  local start_line = math.max(1, current_line - 2)
  local end_line = current_line + 2
  local location_string = string.format("%s#L%d-L%d (error context)", file_path, start_line, end_line)
  vim.fn.setreg('+', location_string)
  vim.notify("Copied error context: " .. location_string, vim.log.levels.INFO)
end, {desc = "Copy error context"})

-- Copy current function/class name and location
-- Output: "path/to/file.lua#L25 (function: setup_keymaps)"
-- Use case: When you want to reference a specific function or class to AI
vim.keymap.set("n", "<leader>yf", function()
  local file_path = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':.')
  local line_num = vim.fn.line('.')
  local function_name = vim.fn.expand('<cword>')
  local location_string = string.format("%s#L%d (function: %s)", file_path, line_num, function_name)
  vim.fn.setreg('+', location_string)
  vim.notify("Copied function context: " .. location_string, vim.log.levels.INFO)
end, {desc = "Copy function context"})

-- Copy current LSP symbol information
-- Output: "path/to/file.lua#L25 (symbol: vim.keymap.set)"
-- Use case: When you want to reference a specific symbol (variable, function, etc.)
vim.keymap.set("n", "<leader>ys", function()
  local file_path = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':.')
  local line_num = vim.fn.line('.')
  local symbol_name = vim.fn.expand('<cword>')
  local location_string = string.format("%s#L%d (symbol: %s)", file_path, line_num, symbol_name)
  vim.fn.setreg('+', location_string)
  vim.notify("Copied symbol context: " .. location_string, vim.log.levels.INFO)
end, {desc = "Copy symbol context"})

-- Copy current directory structure context
-- Output: "Directory: nvim/lua/jazzfish\nFile: remap.lua"
-- Use case: When you want to give AI context about the file's location in your project
vim.keymap.set("n", "<leader>yd", function()
  local file_path = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':.')
  local dir_path = vim.fn.fnamemodify(file_path, ':h')
  local file_name = vim.fn.fnamemodify(file_path, ':t')
  local location_string = string.format("Directory: %s\nFile: %s", dir_path, file_name)
  vim.fn.setreg('+', location_string)
  vim.notify("Copied directory context", vim.log.levels.INFO)
end, {desc = "Copy directory context"})

-- Copy current line with git blame info (requires git repository)
-- Output: "path/to/file.lua#L25 (commit: a1b2c3d4)"
-- Use case: When you want to reference code with its git history context
vim.keymap.set("n", "<leader>yg", function()
  local file_path = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':.')
  local line_num = vim.fn.line('.')
  local git_blame = vim.fn.system(string.format("git blame -L %d,%d --porcelain %s | head -1", line_num, line_num, vim.fn.expand('%:p')))
  local commit_hash = vim.fn.split(git_blame, ' ')[1]
  if commit_hash and commit_hash ~= "" then
    local location_string = string.format("%s#L%d (commit: %s)", file_path, line_num, commit_hash:sub(1, 8))
    vim.fn.setreg('+', location_string)
    vim.notify("Copied git context: " .. location_string, vim.log.levels.INFO)
  else
    vim.notify("Not in a git repository or git blame failed", vim.log.levels.WARN)
  end
end, {desc = "Copy git blame context"})

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
