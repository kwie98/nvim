return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    event = "VeryLazy",

    config = function()
        local refactoring = require("refactoring")
        refactoring.setup({})

        vim.keymap.set("x", "<Leader>le", ":Refactor extract ", { desc = "Extract to Function" })
        vim.keymap.set("x", "<Leader>lE", ":Refactor extract_to_file ", { desc = "Extract to Function in new File" })
        vim.keymap.set("x", "<Leader>lv", ":Refactor extract_var ", { desc = "Extract Expression to Variable" })
        vim.keymap.set({ "n", "x" }, "<Leader>li", "<CMD>Refactor inline_var<Enter>", { desc = "Inline Variable" })
        vim.keymap.set("n", "<Leader>lI", ":Refactor inline_func", { desc = "Inline Function" })
        -- vim.keymap.set("n", "<Leader>lb", ":Refactor extract_block", { desc = "Extract Block?" })
        -- vim.keymap.set("n", "<Leader>lB", ":Refactor extract_block_to_file", { desc = "Extract Block to new File?" })
        vim.keymap.set("n", "<Leader>lp", refactoring.debug.print_var, { desc = "Insert Print" })
        vim.keymap.set("n", "<Leader>lP", refactoring.debug.cleanup, { desc = "Clean Up Prints" })
    end,
}
