vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<cr>", {}) -- split window vertically
vim.keymap.set("n", "<leader>wh", "<cmd>split<cr>", {}) -- split window horizontally
vim.keymap.set("n", "<leader>w<Left>", "<C-w>h", {}) -- move to left window
vim.keymap.set("n", "<leader>w<Right>", "<C-w>l", {}) -- move to right window
vim.keymap.set("n", "<leader>w<Down>", "<C-w>j", {}) -- move to down window
vim.keymap.set("n", "<leader>w<Up>", "<C-w>k", {}) -- move to up window
vim.keymap.set("n", "<leader>b", "<C-o>", {}) -- go to previous cursor position

vim.keymap.set("n", "<leader>t", "<cmd>Explore<cr>",
               {silent = true, noremap = true})
vim.cmd("let g:netrw_list_hide=[\'\\~$\', \'__pycache__\']")

-- for working with csv files specifically
-- might want to do something like this: https://vi.stackexchange.com/a/19889
vim.cmd("autocmd TermOpen * startinsert") -- start the terminal in insert mode
vim.cmd("autocmd TermClose * execute 'bdelete! ' . expand('<abuf>')") -- quick exit the terminal
vim.keymap.set("n", "<leader>vd", "<cmd>terminal vd % startinsert <cr>") -- opens up visidata on the current file
