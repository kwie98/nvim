return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
    },
    lazy = true,
    keys = {
        { "<Leader>rr", mode = "n", desc = "Neotest" }
    },

    config = function()
        local neotest = require("neotest")
        neotest.setup({
            adapters = {
                require("neotest-python")({
                    dap = { justMyCode = false },
                    pytest_discover_instances = true,
                }),
            },
        })
        vim.keymap.set("n", "<Leader>rr", neotest.summary.open, { desc = "Neotest" })
    end,
}
