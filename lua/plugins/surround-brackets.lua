return {
    "kylechui/nvim-surround",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    enabled = true,
    event = "VeryLazy",

    config = function()
        local surround = require("nvim-surround")

        surround.setup({
            keymaps = {
                normal = "s",
                normal_cur = "ss",
                visual = "s",
            },
            aliases = {
                ["a"] = "a",
                ["b"] = "b",
                ["B"] = "B",
                ["r"] = "r",
                ["s"] = { "}", "]", ")", ">" },
            },
            surrounds = {
                ["i"] = {
                    add = { "_", "_" },
                    find = "%_.-%_",
                    delete = "^(%_?)().-(%_?)()$",
                    change = {
                        target = "^(%_?)().-(%_?)()$",
                    },
                },
                ["*"] = {
                    add = { "**", "**" },
                    find = "%*%*.-%*%*",
                    delete = "^(%*%*?)().-(%*%*?)()$",
                    change = {
                        target = "^(%*%*?)().-(%*%*?)()$",
                    },
                },
                invalid_key_behavior = false,
            },
        })
    end,
}
