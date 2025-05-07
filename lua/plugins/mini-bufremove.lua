return {
    "echasnovski/mini.bufremove",
    keys = { { "<Leader>cc", mode = "n", desc = "Close Buffer" } },

    config = function()
        local bufremove = require("mini.bufremove")
        bufremove.setup()

        vim.keymap.set("n", "<Leader>cc", bufremove.delete, { desc = "Close Buffer" })
        -- TODO Leader C close others?
    end,
}
