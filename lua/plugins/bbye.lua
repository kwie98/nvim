return {
    "moll/vim-bbye",
    keys = { "<Leader>c", mode = "n", desc = "Close Buffer" },

    config = function() vim.keymap.set("n", "<Leader>c", "<CMD>Bdelete!<Enter>", { desc = "Close Buffer" }) end,
}
