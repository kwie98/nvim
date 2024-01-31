-- Bootstrap:
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local lazy = require("lazy")
vim.keymap.set("n", "<Leader>mp", lazy.show, { desc = "Plugins" })
lazy.setup("plugins", {
    change_detection = {
        notify = false,
    },
})
