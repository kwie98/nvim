return {
    "kylechui/nvim-surround",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    event = "VeryLazy",

    config = function()
        local surround = require("nvim-surround")

        surround.setup({
            keymaps = {
                visual = "s",
                visual_line = "gs",
            },
        })
    end,
}
