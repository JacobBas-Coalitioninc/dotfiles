-- general setup for nvim tree
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- setting up some keymaps for nvim-tree
vim.keymap.set("n", "<leader>t", "<cmd>NvimTreeToggle<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader><leader>t", "<cmd>NvimTreeFocus<cr>",
  {silent = true, noremap = true}
)
