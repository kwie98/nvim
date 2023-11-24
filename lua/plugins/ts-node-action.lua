return {
    "CKolkey/ts-node-action",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        { "<Enter>", mode = "n", desc = "Node Action" },
    },

    config = function()
        local node_action = require("ts-node-action")

        node_action.setup()

        vim.keymap.set("n", "<Enter>", node_action.node_action, { desc = "Node Action" })
    end,
}
