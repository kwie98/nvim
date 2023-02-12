local dressing = require("dressing")

dressing.setup({
    input = {
        anchor = "NW",
        border = vim.g.small_border,
        override = function(conf)
            conf.row = -3
            conf.col = -2
            return conf
        end,
        win_options = {
            winblend = 0,
        },
    },
})
