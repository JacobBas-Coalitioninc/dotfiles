require("lsp_lines").setup()

vim.diagnostic.config({
	virtual_lines = true,
	update_in_insert = true,
})
require("lsp_lines").toggle()

local function toggle_lsp_lines()
    vim.diagnostic.config({
			virtual_text = not vim.diagnostic.config()["virtual_text"],
		})
    require("lsp_lines").toggle()
end

vim.keymap.set(
  "",
  "<Leader>d",
  toggle_lsp_lines,
  { desc = "Toggle lsp_lines" }
)
