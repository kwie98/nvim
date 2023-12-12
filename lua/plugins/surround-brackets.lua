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
                normal = "gs",
                normal_cur = "gss",
                visual = "gs",
            },
            aliases = {
                a = false,
                b = false,
                B = false,
                r = false,
                s = { "}", "]", ")", ">" },
            },
        })
    end,
}
