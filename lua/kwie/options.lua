-- Disable builtin plugins:
vim.g.loaded_matchparen = 1
vim.g.loaded_matchit = 1

vim.opt.title = true
vim.opt.formatoptions = "cqj" -- "a" is also nice but breaks markdown code blocks
vim.opt.mousescroll = "ver:1,hor:1"
vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.conceallevel = 1 -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- smart case
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.showmode = false
vim.opt.showtabline = 0
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 400 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.cursorline = true -- highlight the current line
vim.opt.number = true -- set numbered lines
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.numberwidth = 4 -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false -- display lines as one long line
vim.opt.linebreak = true
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8
vim.opt.guifont = "monospace:h17"
vim.opt.gdefault = true
vim.opt.spell = false
vim.opt.colorcolumn = "+1"
vim.opt.wildmode = "longest:full,full"
vim.opt.laststatus = 3 -- one status line for everything
vim.opt.updatetime = 500

-- Always do vertical diff, don't fold away so much code:
if vim.fn.has("nvim-0.9") == 1 then
    vim.opt.diffopt = vim.opt.diffopt + "linematch:50" -- better diff matches
end
vim.opt.diffopt = vim.opt.diffopt + "vertical,context:64"

-- Default indentation settings (overwritten by .editorconfig):
vim.opt.expandtab = true -- don't convert tabs to spaces (to catch formatters doing this automatically!)
vim.opt.tabstop = 4 -- number of spaces a <Tab> in the text stands for
vim.opt.softtabstop = 4 -- unknown
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.list = true
vim.opt.listchars = { tab = "⇥ ", nbsp = "·" }

vim.opt.splitkeep = "screen"

vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- vim.g.modified_icon = "" -- for bufferline, lualine
vim.g.small_border = "none" -- smaller helper floats
-- vim.g.big_border = "shadow" -- ui window floats
vim.g.blend = 10
vim.opt.pumblend = vim.g.blend
vim.g.semantic_highlighting = true

vim.lsp.set_log_level("OFF")

if vim.g.neovide then
    vim.g.neovide_refresh_rate = 144
    vim.g.neovide_cursor_animation_length = 0
end

if vim.fn.has("win32") == 1 then
    vim.cmd([[
        let &shell = 'powershell'
        let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
        let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
        let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
        set shellquote= shellxquote=
    ]])
else
    vim.opt.shell = "zsh"
end
