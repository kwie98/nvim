return {
    "numToStr/Comment.nvim",
    event = "VeryLazy",

    config = function()
        local comment = require("Comment")

        comment.setup({
            ignore = "^$",
            toggler = {
                line = "gcc",
                block = "gbc",
            },
            sticky = false,
            opleader = {
                line = "gc",
                block = "gb",
            },
            extra = {
                above = "gcO",
                below = "gco",
                eol = "gcA",
            },
            mappings = {
                basic = true,
                extra = true,
                extended = false,
            },
        })
    end,
}
