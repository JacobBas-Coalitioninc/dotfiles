local cmd = vim.cmd -- to exectue vim commands
local g = vim.g     -- a table to access global variables
local opt = vim.opt -- to set options

cmd 'syntax on'
cmd 'filetype indent plugin on'

vim.keymap.set('', '<Space>', '<Nop>', { noremap = true, silent = false })
g.mapleader = " "
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
opt.termguicolors = true

opt.modifiable = true
opt.belloff = 'all'
opt.errorbells = false
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false
opt.hlsearch = false
opt.scrolloff = 8
opt.number = true
opt.hidden = true
-- opt.cmdheight = 0
opt.mouse = ""

opt.updatetime = 50

opt.swapfile = false
opt.backup = false

opt.colorcolumn = '95'
opt.signcolumn = 'yes'
cmd('highlight ColorColumn ctermbg=0 guibg=lightgrey')

g.python3_host_prog = '/usr/bin/python3'
