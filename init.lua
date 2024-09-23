vim.loader.enable()

-- Line numbers and sign column:
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
-- Searching:
vim.o.smartcase = true
vim.o.ignorecase = true
-- Completion:
vim.o.completeopt = "menuone,noinsert,noselect"
vim.opt.shortmess:append("c")
vim.opt.shortmess:append("C")
-- Text wrapping:
vim.o.linebreak = true
vim.o.breakindent = true
-- Folding:
vim.o.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
-- Indenting:
vim.o.shiftwidth = 4
vim.o.expandtab = true
-- Misc:
vim.o.cursorline = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.scrolloff = 4
vim.o.sidescrolloff = 8
vim.o.laststatus = 3
vim.o.swapfile = false
vim.o.undofile = true
vim.o.clipboard = "unnamedplus"

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", vim.cmd.w, { desc = "Write" })
vim.keymap.set("n", "<leader>q", vim.cmd.q, { desc = "Quit" })
vim.keymap.set("n", "<Leader>n", function() vim.cmd(':let @/ = ""') end, { desc = "Toggle Search Highlight" })
vim.keymap.set("n", "<C-j>", "<C-w>w")
vim.keymap.set("n", "<C-k>", "<C-w>W")
vim.keymap.set("n", "gp", "`[v`]")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("n", "<", "<<")
vim.keymap.set("n", ">", ">>")
vim.keymap.set("n", "<Leader>k", vim.diagnostic.open_float)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)

-- Plugins:
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)
local lazy = require("lazy")
lazy.setup("plugins", {
    change_detection = {
        notify = false,
    },
    install = {
        colorscheme = { "default" },
    },
})
vim.keymap.set("n", "<Leader>mp", lazy.show, { desc = "Plugins" })

require("kwie.autocommands")
