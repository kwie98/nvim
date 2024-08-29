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
            -- show_keys = false,
            -- triggers = "auto",
        })

        which_key.add({
            { "<Leader>d", group = "Debug" },
            { "<Leader>g", group = "Git" },
            { "<Leader>l", group = "LSP" },
            { "<Leader>m", group = "Module Info" },
            { "<Leader>r", group = "Run/Test" },
            { "<Leader>s", group = "Search" },
            { "<Leader>sg", group = "Git" },
            { "<Leader>u", hidden = true },
            { "<Leader>i", hidden = true },
            { "<Leader>o", hidden = true },
            { "<Leader>p", hidden = true },
            { "<Leader>g", group = "Git", mode = "v" },
        })

        -- which_key.register(mappings, { mode = "n", prefix = "<Leader>" })
        -- which_key.register(v_mappings, { mode = "v", prefix = "<Leader>" })
    end,
}
