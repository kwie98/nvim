return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    keys = {
        {
            "gref",
            function() return require("refactoring").refactor("Extract Function") end,
            mode = "x",
            expr = true,
            desc = "extract function",
        },
        {
            "greF",
            function() return require("refactoring").refactor("Extract Function To File") end,
            mode = "x",
            expr = true,
            desc = "extract function to file",
        },
        {
            "grev",
            function() return require("refactoring").refactor("Extract Variable") end,
            mode = { "n", "x" },
            expr = true,
            desc = "extract variable",
        },
        {
            "grif",
            function() return require("refactoring").refactor("Inline Function") end,
            mode = { "n", "x" },
            expr = true,
            desc = "inline function",
        },
        {
            "griv",
            function() return require("refactoring").refactor("Inline Variable") end,
            mode = { "n", "x" },
            expr = true,
            desc = "inline variable",
        },
        {
            "greb",
            function() return require("refactoring").refactor("Extract Block") end,
            mode = { "n", "x" },
            expr = true,
            desc = "extract block",
        },
        {
            "greB",
            function() return require("refactoring").refactor("Extract Block To File") end,
            mode = { "n", "x" },
            expr = true,
            desc = "extract block to file",
        },
    },
    init = function()
        vim.keymap.del("n", "gri")
    end,
    opts = {},
}
