require('neogen').setup{}
vim.keymap.set(
  "",
  "<Leader><leader>d",
  require('neogen').generate,
  { desc = "add in docstring to a function" }
)