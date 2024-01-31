return {
    "williamboman/mason.nvim",
    enabled = vim.fn.has("win32") == 0,
    keys = { { "<Leader>mm", mode = "n", desc = "Mason" } },

    config = function()
        local mason = require("mason")
        local m_ui = require("mason.ui")

        vim.keymap.set("n", "<Leader>mm", m_ui.open, { desc = "Mason" })

        mason.setup({
            PATH = "skip",
            ui = {
                border = vim.g.big_border,
                keymaps = { apply_language_filter = "f" },
            },
        })
    end,
}
