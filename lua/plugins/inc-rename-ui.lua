return {
    "smjonas/inc-rename.nvim",
    keys = { { "grn", mode = "n", desc = "Rename Symbol" } },
    enabled = vim.fn.has("win32") == 0,

    config = function()
        require("inc_rename").setup()

        vim.keymap.set(
            "n",
            "grn",
            function() return ":IncRename " .. vim.fn.expand("<cword>") end,
            { desc = "Rename Symbol", expr = true }
        )
    end,
}
