return {
    "folke/flash.nvim",
    keys = {
        { "s", mode = "n" },
        { ",", mode = "n" },
    },

    config = function()
        local flash = require("flash")
        flash.setup({
            label = { current = false },
            modes = {
                search = { enabled = false },
                char = { enabled = false },
            },
            prompt = { enabled = false },
        })

        vim.keymap.set("n", "s", flash.jump)
        vim.keymap.set("n", ",", flash.jump)
        -- vim.keymap.set("x", "s", flash.treesitter_search)
    end,
}
