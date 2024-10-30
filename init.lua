vim.loader.enable()

-- OPTIONS --
vim.o.title = true
-- vim.o.titlestring = "%{getcwd()}"
vim.cmd([[set titlestring=%{substitute(getcwd(),\ $HOME,\ '~',\ '')}]])
-- Status columns and bars around the window:
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.colorcolumn = "+1"
vim.o.laststatus = 3
vim.o.showtabline = 0
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
-- Displaying invisible characters:
vim.o.list = true
vim.opt.listchars = { tab = "⇥ ", nbsp = "·" }
-- Diagnostics:
local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}
for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end
vim.diagnostic.config({
    virtual_text = false,
    signs = signs,
})
-- Misc:
vim.o.cursorline = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.scrolloff = 4
vim.o.sidescrolloff = 8
vim.o.swapfile = false
vim.o.undofile = true
vim.o.clipboard = "unnamedplus"
-- vim.o.bg = "dark"

-- KEYMAPS --
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
-- Diagnostics:
vim.keymap.set("n", "<Leader>k", vim.diagnostic.open_float)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set(
    "n",
    "<Leader>lh",
    function() vim.diagnostic.config({ virtual_text = not vim.diagnostic.config()["virtual_text"] }) end,
    { desc = "Toggle Diagnostics" }
)
-- Move text:
vim.keymap.set("n", "<A-j>", "<Esc>:m .+1<CR>==")
vim.keymap.set("n", "<A-k>", "<Esc>:m .-2<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
-- Paste:
vim.keymap.set({ "i", "c" }, "<C-v>", "<C-r><C-o>+")
-- j/k move in wrapped lines, but not when jumping multiple lines:
vim.keymap.set("n", "j", function()
    if vim.v.count == 0 then return "gj" end
    return "j"
end, { expr = true })
vim.keymap.set("n", "k", function()
    if vim.v.count == 0 then return "gk" end
    return "k"
end, { expr = true })

-- PLUGINS --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
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

-- AUTOCOMMANDS --
require("kwie.autocommands")
