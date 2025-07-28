# Neovim Configuration

A comprehensive Neovim configuration built with Lua, featuring a modern plugin ecosystem, extensive keybindings, and a well-organized modular structure.

## 🏗️ Architecture

The configuration follows a modular approach with clear separation of concerns:

```
nvim/
├── init.lua                    # Entry point - loads jazzfish module
└── lua/jazzfish/              # Main configuration module
    ├── init.lua               # Module initialization
    ├── editor-opts.lua        # Editor options and settings
    ├── lazy.lua               # Plugin management (Lazy.nvim)
    ├── remap.lua              # Keybindings and mappings
    ├── color.lua              # Colorscheme and highlighting
    ├── acme-color-scheme.lua  # Custom ACME colorscheme
    └── snippets/              # Custom snippet system
        ├── init.lua           # Snippets initialization
        ├── lua.lua            # Lua programming snippets
        ├── nvim-config.lua    # Neovim config snippets
        ├── general.lua        # General programming snippets
        ├── documentation.lua  # Documentation snippets
        ├── debugging.lua      # Debugging snippets
        └── README.md          # Snippets documentation
```

## 🚀 Features

### **Plugin Ecosystem**
- **Lazy.nvim** - Fast plugin manager with lazy loading
- **LSP** - Language Server Protocol with Mason for easy server installation
- **Telescope** - Fuzzy finder for files, buffers, grep, and more
- **Treesitter** - Advanced syntax highlighting and parsing
- **Harpoon** - Fast file navigation and switching
- **Oil.nvim** - Modern file explorer
- **Git Integration** - Fugitive, GitGutter, and Rhubarb

### **Language Support**
- **Go** - Full Go development with go.nvim
- **Rust** - Rust syntax highlighting and tools
- **Lua** - Comprehensive Lua support
- **Polyglot** - Syntax highlighting for 100+ languages

### **Development Tools**
- **Autocomplete** - nvim-cmp with LSP integration
- **Snippets** - LuaSnip with friendly-snippets
- **Debugging** - nvim-dap for debugging support
- **Formatting** - Neoformat and LSP formatting
- **Linting** - Built-in diagnostics with LSP

### **Quality of Life**
- **Status Line** - Lualine with git info and diagnostics
- **Commentary** - Easy commenting with `gc`
- **Surround** - Surround text with brackets/quotes
- **Undotree** - Visual undo history
- **Todo Comments** - Highlight TODO/FIXME comments
- **Big File** - Optimizations for large files

## ⌨️ Keybindings

### **Leader Key**
The leader is set to `<Space>` and is used extensively throughout the configuration.

### **File Navigation**
- `<leader>ff` - Find files (Telescope)
- `<leader>fb` - Find buffers (Telescope)
- `<leader>fg` - Live grep (Telescope)
- `<leader>fd` - Find diagnostics (Telescope)
- `<leader>fr` - Find references (Telescope)
- `<leader>fh` - Find help tags (Telescope)
- `<leader>t` - Open file explorer (Oil)

### **Harpoon File Management**
- `<leader>ha` - Add file to harpoon
- `<leader>hh` - Toggle harpoon menu
- `<leader>1-9` - Quick jump to harpoon files

### **Window Management**
- `<leader>wv` - Split window vertically
- `<leader>wh` - Split window horizontally
- `<leader>w<arrow>` - Navigate between windows
- `<leader>b` - Go to previous cursor position

### **LSP Commands**
- `K` - Hover documentation
- `gd` - Go to definition
- `gr` - Go to references
- `ga` - Rename symbol
- `[d`/`]d` - Navigate diagnostics

### **AI-Assisted Copy Commands**
- `<leader>yp` - Copy file path
- `<leader>yn` - Copy current line number
- `<leader>yl` - Copy selected line range
- `<leader>ye` - Copy error context
- `<leader>yf` - Copy function context
- `<leader>ys` - Copy symbol context
- `<leader>yd` - Copy directory context
- `<leader>yg` - Copy git blame context

### **Other Commands**
- `<leader>u` - Toggle undotree
- `<leader>d` - Toggle LSP diagnostic lines
- `<leader>dv` - Toggle diffview

## 🎨 Appearance

### **Colorscheme**
- **Gruvbox** - Primary colorscheme with custom modifications
- **Custom ACME** - Additional colorscheme for variety
- **Lualine** - Status line with git integration
- **Scrollbar** - Visual scrollbar with highlights
- **Reticle** - Enhanced cursor line/column highlighting

### **Highlights**
- Custom syntax highlighting
- Git diff indicators
- Diagnostic highlights
- Search highlighting
- Comment highlighting

## 📝 Snippets System

A comprehensive snippet system is included with categories for:

### **Lua Programming**
- `module` - Lua module template
- `func` - Function with documentation
- `local`, `table`, `if`, `for` - Basic constructs
- `vimapi`, `keymap`, `autocmd` - Neovim API calls

### **Neovim Configuration**
- `lazy` - Lazy.nvim plugin entry
- `plugin` - Simple plugin entry
- `section` - Section headers
- `keymap`, `autocmd` - Common config patterns

### **General Programming**
- `todo`, `fixme`, `note` - Comment types
- `doc` - Function documentation
- `error`, `pairs`, `ipairs` - Common patterns

### **Documentation**
- `readme` - README template
- `section`, `subsection` - Markdown headers
- `code`, `inline` - Code blocks
- `table`, `link`, `image` - Markdown elements

### **Debugging**
- `debug`, `debugvar`, `debugtable` - Debug prints
- `debugtime`, `debugmem` - Performance debugging
- `debugfile`, `debugbuf` - Context debugging

## 🔧 Configuration Files

### **editor-opts.lua**
- Editor options and settings
- Must load first due to leader key setup

### **lazy.lua**
- Plugin management with Lazy.nvim
- Organized by categories (LSP, Git, UI, etc.)
- Clean configuration with minimal keybindings

### **remap.lua**
- All keybindings and mappings
- Organized by functionality
- AI-assisted copy commands for development

### **color.lua**
- Colorscheme configuration
- Custom highlights and colors
- Theme integration

## 🚀 Getting Started

1. **Install Neovim** (0.8+ required)
2. **Clone this repository** to `~/.config/nvim/`
3. **Start Neovim** - plugins will auto-install
4. **Wait for setup** - Lazy.nvim will install all plugins
5. **Enjoy!** - All features are ready to use

## 📚 Learning Resources

### **Neovim Lua API**
- `:h vim.` - Vim Lua API reference
- `:h nvim_` - Neovim Lua API reference
- `:h lua-` - Lua integration guide

### **Plugin Documentation**
- `:h lazy.nvim` - Plugin manager docs
- `:h telescope` - Fuzzy finder docs
- `:h lspconfig` - LSP configuration
- `:h luasnip` - Snippet system

### **Keybinding Help**
- `:h keymap` - Key mapping guide
- `:h leader` - Leader key usage
- `:h which-key` - Key binding discovery

## 🔄 Customization

### **Adding Plugins**
Edit `lua/jazzfish/lazy.lua` and add to the appropriate section:

```lua
{
    'author/plugin-name',
    config = function()
        require('plugin-name').setup({
            -- your config
        })
    end
},
```

### **Adding Keybindings**
Edit `lua/jazzfish/remap.lua` and add to the appropriate section:

```lua
vim.keymap.set('n', '<leader>key', function()
    -- your mapping
end, { desc = 'Description' })
```

### **Adding Snippets**
Edit the appropriate file in `lua/jazzfish/snippets/`:

```lua
s("trigger", {
    t({"text", ""}),
    i(1, "placeholder"),
}),
```

## 🐛 Troubleshooting

### **Common Issues**
1. **Plugins not loading** - Check `:Lazy` for installation status
2. **LSP not working** - Run `:Mason` to install language servers
3. **Keybindings not working** - Check for conflicts in `:map`
4. **Colorscheme issues** - Verify Treesitter is installed

### **Debugging**
- Use the debugging snippets (`debug`, `debugvar`, etc.)
- Check `:checkhealth` for system health
- Use `:LspInfo` for LSP status
- Use `:Telescope diagnostics` for error browsing

## 📈 Performance

The configuration is optimized for performance:
- **Lazy loading** - Plugins load only when needed
- **Big file handling** - Disables features for large files
- **Efficient LSP** - Minimal server configurations
- **Fast startup** - Minimal required plugins

## 🤝 Contributing

Feel free to customize this configuration for your needs:
1. Fork the repository
2. Make your changes
3. Test thoroughly
4. Document any new features

## 📄 License

This configuration is open source and available under the MIT License.

---

**Happy coding with Neovim! 🚀**
