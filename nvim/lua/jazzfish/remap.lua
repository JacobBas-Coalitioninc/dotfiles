vim.keymap.set("n", "<leader>wv", "<cmd>:vsplit<cr>", {}) -- split window vertically
vim.keymap.set("n", "<leader>wh", "<cmd>:split<cr>", {})  -- split window horizontally

vim.keymap.set("n", "<leader>w<Left>", "<C-w>h", {})      -- move to left window
vim.keymap.set("n", "<leader>w<Right>", "<C-w>l", {})     -- move to right window
vim.keymap.set("n", "<leader>w<Down>", "<C-w>j", {})      -- move to down window
vim.keymap.set("n", "<leader>w<Up>", "<C-w>k", {})        -- move to up window

vim.keymap.set("n", "<leader>b", "<C-o>", {})             -- go to previous cursor position