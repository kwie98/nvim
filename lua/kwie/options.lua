--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.title = true
vim.opt.formatoptions = "cqj" -- "a" is also nice but breaks markdown code blocks
vim.opt.mousescroll = "ver:1,hor:1"
vim.opt.diffopt = vim.opt.diffopt + "vertical,context:100" -- always do vertical diff, don't fold away so much code
if vim.fn.has("nvim-0.9") == 1 then
    vim.opt.diffopt = vim.opt.diffopt + "linematch:50" -- better diff matches
end
vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
-- vim.opt.completeopt = { "menu,menuone,noselect" } -- mostly just for cmp
vim.opt.conceallevel = 1 -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.hlsearch = false -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- smart case
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.selectmode = "mouse" -- dragging mouse starts SELECT instead of VISUAL
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 0 -- never show tabs
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 400 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.tabstop = 4 -- insert 2 spaces for a tab
vim.opt.softtabstop = 4 -- unknown
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.cursorline = true -- highlight the current line
vim.opt.number = true -- set numbered lines
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.numberwidth = 4 -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false -- display lines as one long line
vim.opt.linebreak = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.guifont = "monospace:h17"
vim.opt.gdefault = true
vim.opt.spell = false
vim.opt.shell = "/usr/bin/bash"
vim.opt.textwidth = 120
vim.opt.colorcolumn = "+1"
vim.opt.wildmode = "longest:full,full"
vim.opt.laststatus = 3 -- one lualine for everything
vim.opt.foldlevel = 20
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.updatetime = 500
-- vim.opt.equalalways = false -- don't automatically resize windows to have equal sizes after some changes

vim.g.modified_icon = "" -- for bufferline, lualine
vim.g.small_border = "single" -- smaller helper floats
vim.g.big_border = "shadow" -- ui window floats
vim.g.diagnostics_visible = true
vim.g.semantic_highlighting = true
