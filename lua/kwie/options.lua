-- Disable builtin plugins:
vim.g.loaded_matchparen = 1
vim.g.loaded_matchit = 1

vim.opt.formatoptions = "cqj" -- "a" is also nice but breaks markdown code blocks
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.pumheight = 10
vim.opt.showmode = false
vim.opt.showtabline = 0
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.timeoutlen = 400 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes" -- always show the sign column
vim.opt.wrap = false -- display lines as one long line
vim.opt.linebreak = true -- when using wrap, split between words
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8
vim.opt.gdefault = true
vim.opt.colorcolumn = "+1"
vim.opt.laststatus = 3 -- one status line for everything

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
vim.g.small_border = "none" -- smaller helper floats
vim.g.blend = 10
vim.opt.pumblend = vim.g.blend

vim.lsp.set_log_level("OFF")

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
