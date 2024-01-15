
--general nvim set-up
--if you want, you can move this to seperate option.lua file into core directory 
local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

opt.iskeyword:append("-") -- consider string-string as whole word


require("bongphysik.lazy")
--require("bongphysik.core")
--require("bongphysik.plugins.comment")
-- require("bongphysik.plugins.transparent.lua")
--require("bongphysik.plugins.nvim-tree")
--require("bongphysik.plugins.lualine")
--require("bongphysik.plugins.telescope")
--require("bongphysik.plugins.nvim-cmp")
-- require("bongphysik.plugins.lsp.mason")
-- require("bongphysik.plugins.lsp.lspsaga")
-- require("bongphysik.plugins.lsp.lspconfig")
-- require("bongphysik.plugins.lsp.null-ls")
--require("bongphysik.plugins.autopairs")
--require("bongphysik.plugins.treesitter")
--require("bongphysik.plugins.gitsigns")
