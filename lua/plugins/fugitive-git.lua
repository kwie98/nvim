return {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gdiffsplit" },
    keys = {
        { "<Leader>G", mode = "n", desc = "Fugitive" },
        -- { "<Leader>gd", mode = "n", desc = "Diff File" },
        { "<Leader>gD", mode = "n", desc = "Diff All Files" },
        { "<Leader>gm", mode = "n", desc = "Merge" },
    },

    config = function()
        vim.keymap.set("n", "<Leader>G", "<CMD>72vsplit<BAR>0Git<Enter>", { desc = "Fugitive" })
        -- vim.keymap.set("n", "<Leader>gd", "<CMD>Gdiffsplit<Enter>", { desc = "Diff File" })
        vim.keymap.set("n", "<Leader>gD", "<CMD>Git difftool -y HEAD<Enter>", { desc = "Diff All Files" })
        vim.keymap.set("n", "<Leader>gm", "<CMD>Git mergetool -y | tabprevious<Enter>", { desc = "Merge" })
    end,
}
