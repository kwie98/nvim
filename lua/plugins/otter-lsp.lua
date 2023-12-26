return {
    "jmbuhr/otter.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
    },

    config = function()
        local otter = require("otter")
        otter.setup({
            buffers = { set_filetype = true },
        })
    end,
}
