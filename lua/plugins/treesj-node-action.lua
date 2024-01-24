return {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = { "<Enter>", mode = "n", desc = "Node Action" },

    config = function()
        local treesj = require("treesj")
        treesj.setup({
            use_default_keymaps = false,
        })

        vim.keymap.set("n", "<Enter>", function() treesj.toggle() end, { desc = "Node Action" })
    end,
}
