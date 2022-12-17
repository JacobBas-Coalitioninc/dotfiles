require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "go",
        "javascript",
        "lua",
        "python",
        "rust",
        "vim",
    },
    highlight = { 
        enable = true ,
        disable = { "vim" }
    },
}
