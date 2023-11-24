return {
    "smjonas/inc-rename.nvim",
    dependencies = {
        "stevearc/dressing.nvim",
    },
    lazy = true,
    keys = {
        { "<Leader>lr", mode = "n", desc = "Rename Symbol" },
    },
    enabled = vim.fn.has("win32") == 0,

    config = function()
        require("inc_rename").setup({
            input_buffer_type = "dressing",
        })

        vim.keymap.set("n", "<leader>lr", function()
            return ":IncRename " .. vim.fn.expand("<cword>")
        end, { desc = "Rename Symbol", expr = true })
    end,
}
