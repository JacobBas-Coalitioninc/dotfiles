vim.keymap.set("n", "<leader>t", "<cmd>NERDTreeToggle<cr>",
  {silent = true, noremap = true}
)
vim.cmd("let NERDTreeIgnore=[\'\\~$\', \'__pycache__\']")
