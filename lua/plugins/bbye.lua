return {
    {
        "moll/vim-bbye",
        keys = {
            { "<Leader>c", mode = "n" },
        },

        config = function()
            vim.keymap.set("n", "<Leader>c", "<CMD>Bdelete!<CR>", { desc = "Close Buffer" })
        end,
    },
}
