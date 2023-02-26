return {
    {
        "moll/vim-bbye",
        keys = {
            { "<Leader>c", mode = "n", desc = "Close Buffer" },
        },

        config = function()
            vim.keymap.set("n", "<Leader>cc", "<CMD>Bdelete!<CR>", { desc = "Close Buffer" })
        end,
    },
}
