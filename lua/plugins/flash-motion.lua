return {
    "folke/flash.nvim",
    keys = { "s", mode = "n", desc = "Flash Jump" },

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

        vim.keymap.set("n", "s", flash.jump, { desc = "Flash Jump" })
    end,
}
