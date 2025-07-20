return {
    "folke/which-key.nvim",
    event = "VeryLazy",

    config = function()
        local which_key = require("which-key")

        which_key.setup({
            delay = 200,
            plugins = {
                spelling = { enabled = false },
                presets = { operators = false, motions = false, text_objects = false },
            },
            icons = {
                separator = "",
                mappings = false,
            },
            win = {
                padding = { 1, 1 },
            },
            show_help = false,
            -- triggers = {
            --     { "<auto>", mode = "nso" },
            -- },
        })

        which_key.add({
            { "<Leader>d", group = "Debug" },
            { "<Leader>g", group = "Git" },
            { "<Leader>m", group = "Module Info" },
            { "<Leader>r", group = "Run/Test" },
            { "<Leader>s", group = "Search" },
            { "gre", group = "Extract" },
            { "gri", group = "Inline" },
        })
    end,
}
