return {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gdiffsplit" },
    keys = {
        { "<Leader>G", mode = "n", desc = "Fugitive" },
        { "<Leader>gm", mode = "n", desc = "Merge" },
    },

    config = function()
        vim.keymap.set("n", "<Leader>G", function()
            vim.cmd("vertical Git")
            vim.cmd("vertical resize 72")
        end, { desc = "Fugitive" })
        vim.keymap.set("n", "<Leader>gm", "<CMD>Git mergetool -y | tabprevious<Enter>", { desc = "Merge" })
    end,
}
