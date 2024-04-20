return {
    "windwp/nvim-autopairs",
    lazy = true, -- loaded by cmp

    config = function()
        local autopairs = require("nvim-autopairs")

        autopairs.setup({
            check_ts = true,
            enable_abbr = true,
        })
    end,
}
