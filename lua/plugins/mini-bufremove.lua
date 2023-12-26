return {
    "echasnovski/mini.bufremove",
    keys = { "<Leader>c", mode = "n", desc = "Close Buffer" },

    config = function()
        local bufremove = require("mini.bufremove")
        bufremove.setup()

        vim.keymap.set("n", "<Leader>c", bufremove.delete, { desc = "Close Buffer" })
    end,
}
