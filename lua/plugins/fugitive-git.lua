return {
    "tpope/vim-fugitive",
    cmd = {
        "Git",
        "Gdiffsplit",
    },
    keys = {
        { "<Leader>gg", mode = "n", desc = "Fugitive" },
        { "<Leader>gd", mode = "n", desc = "Diff File" },
        { "<Leader>gD", mode = "n", desc = "Diff All Files" },
        { "<Leader>gm", mode = "n", desc = "Merge" },
    },

    config = function()
        vim.keymap.set("n", "<Leader>gg", "<CMD>72vsplit<BAR>0Git<CR>", { desc = "Fugitive" })
        vim.keymap.set("n", "<Leader>gd", "<CMD>Gdiffsplit<CR>", { desc = "Diff File" })
        vim.keymap.set("n", "<Leader>gD", "<CMD>Git difftool -y HEAD<CR>", { desc = "Diff All Files" })
        vim.keymap.set("n", "<Leader>gm", "<CMD>Git mergetool -y | tabprevious<CR>", { desc = "Merge" })
    end,
}
