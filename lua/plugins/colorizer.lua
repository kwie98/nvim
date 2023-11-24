return {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPost",

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
