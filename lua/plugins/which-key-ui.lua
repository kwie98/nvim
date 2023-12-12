return {
    "folke/which-key.nvim",
    event = "VeryLazy",

    config = function()
        local which_key = require("which-key")

        which_key.setup({
            plugins = {
                spelling = { enabled = false },
                presets = { operators = false, motions = false, text_objects = false },
            },
            icons = { separator = ":" },
            window = {
                padding = { 1, 1, 1, 1 },
            },
            show_help = false,
            triggers = "auto",
        })

        local opts = { mode = "n", prefix = "<Leader>" }
        local mappings = {
            g = { name = "Git" },
            r = { name = "Run/Test" },
            d = { name = "Debug" },
            l = { name = "LSP" },
            m = { name = "Module Info" },
            s = { name = "Search" },
            u = "which_key_ignore",
            i = "which_key_ignore",
            o = "which_key_ignore",
            p = "which_key_ignore",
        }

        local v_opts = { mode = "v", prefix = "<Leader>" }
        local v_mappings = {
            g = { name = "Git" },
        }

        which_key.register(mappings, opts)
        which_key.register(v_mappings, v_opts)
    end,
}
