return {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",

    config = function()
        local colorizer = require("colorizer")

        colorizer.setup({
            filetypes = { "*", "!lazy" },
            user_default_options = {
                names = false,
            },
        })
    end,
}
