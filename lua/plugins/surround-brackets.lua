return {
    "kylechui/nvim-surround",
    keys = {
        { "s", mode = { "n", "x" } },
        { "cs" },
        { "ds" },
    },

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
