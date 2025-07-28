# Neovim Configuration Snippets

This directory contains a comprehensive snippet system for Neovim configuration and Lua development.

## Structure

- `init.lua` - Main snippets initialization
- `lua.lua` - Lua programming snippets
- `nvim-config.lua` - Neovim configuration snippets
- `general.lua` - General programming snippets
- `documentation.lua` - Documentation and README snippets
- `debugging.lua` - Debugging and development snippets

## Usage

### Lua Snippets

| Trigger | Description |
|---------|-------------|
| `module` | Create a Lua module template |
| `func` | Function with documentation |
| `local` | Local variable declaration |
| `table` | Table definition |
| `if` | If statement |
| `ifelse` | If-else statement |
| `for` | For loop |
| `forpairs` | For pairs loop |
| `req` | Require statement |
| `print` | Print debug statement |
| `vimapi` | Vim API call |
| `keymap` | Vim keymap |
| `autocmd` | Autocmd definition |
| `plugin` | Plugin configuration |

### Neovim Config Snippets

| Trigger | Description |
|---------|-------------|
| `lazy` | Lazy.nvim plugin entry with config |
| `plugin` | Simple plugin entry |
| `section` | Section header with dividers |
| `keymap` | Keymap with description |
| `autocmd` | Autocmd with description |
| `opt` | Option setting |
| `highlight` | Highlight group |
| `command` | User command definition |
| `bufkeymap` | Buffer-local keymap |
| `lspsetup` | LSP setup |
| `telescope` | Telescope finder |
| `setup` | Plugin setup |
| `filetype` | File type autocmd |
| `bufwritepre` | BufWritePre autocmd |

### General Programming Snippets

| Trigger | Description |
|---------|-------------|
| `todo` | TODO comment |
| `fixme` | FIXME comment |
| `note` | NOTE comment |
| `hack` | HACK comment |
| `xxx` | XXX comment |
| `doc` | Function documentation |
| `divider` | Section divider |
| `comment` | Simple comment |
| `commentblock` | Multi-line comment block |
| `error` | Error handling with pcall |
| `pairs` | Table iteration |
| `ipairs` | Array iteration |
| `cond` | Conditional assignment |
| `concat` | String concatenation |
| `format` | String format |
| `insert` | Table insert |
| `remove` | Table remove |
| `type` | Type checking |
| `nilcheck` | Nil check |
| `deepcopy` | Deep copy function |
| `copy` | Shallow copy function |

### Documentation Snippets

| Trigger | Description |
|---------|-------------|
| `readme` | README template |
| `section` | Section header |
| `subsection` | Subsection header |
| `code` | Code block |
| `inline` | Inline code |
| `link` | Link |
| `image` | Image |
| `li` | List item |
| `nli` | Numbered list item |
| `bold` | Bold text |
| `italic` | Italic text |
| `quote` | Quote block |
| `table` | Table |
| `task` | Task list item |
| `done` | Completed task |
| `hr` | Horizontal rule |
| `footnote` | Footnote |
| `fnref` | Footnote reference |

### Debugging Snippets

| Trigger | Description |
|---------|-------------|
| `debug` | Debug print |
| `debugvar` | Debug print with variable |
| `debugtable` | Debug print with table |
| `debugfunc` | Debug function entry |
| `debugexit` | Debug function exit |
| `debugline` | Debug with line number |
| `debugerror` | Error handling with debug |
| `debugtime` | Performance timing |
| `debugmem` | Memory usage |
| `debugif` | Conditional debug |
| `debugctx` | Debug with context |
| `debugdump` | Debug table contents |
| `debugargs` | Debug function arguments |
| `debugstack` | Debug with stack trace |
| `debugfile` | Debug with file info |
| `debugbuf` | Debug with buffer info |
| `debugwin` | Debug with window info |
| `debugmode` | Debug with mode info |
| `debugreg` | Debug with register info |
| `debugopt` | Debug with option value |
| `debuggvar` | Debug with global variable |
| `debuglvar` | Debug with local variable |

## Adding New Snippets

To add new snippets:

1. Choose the appropriate file based on the snippet type
2. Add your snippet using the LuaSnip API
3. Follow the existing pattern for consistency

Example:
```lua
s("mytrigger", {
    t({"local ", ""}),
    i(1, "variable_name"),
    t({" = ", ""}),
    i(2, "value"),
}),
```

## Integration

The snippets are automatically loaded when Neovim starts. They integrate with your existing LuaSnip setup and work with your current completion configuration.

## Tips

- Use `<Tab>` to jump between snippet placeholders
- Use `<S-Tab>` to jump backwards
- Snippets work in insert mode
- You can customize the trigger words by editing the snippet files 