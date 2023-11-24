return {
    "stevearc/dressing.nvim",

    config = function()
        local dressing = require("dressing")

        dressing.setup({
            input = {
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
            select = {
                backend = { "telescope" },
                -- telescope = {

                --     border = true,
                --     borderchars = {
                --         prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
                --         results = { " " },
                --         preview = { " " },
                --     },
                --     -- dynamic_preview_title = true, -- trying this out
                --     prompt_prefix = " ",
                -- },
            },
        })
    end,
}
