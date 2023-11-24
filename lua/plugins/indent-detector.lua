return {
    "Darazaki/indent-o-matic",
    lazy = false,

    config = function()
        local indenter = require("indent-o-matic")

        indenter.setup({
            -- Global settings (optional, used as fallback)
            max_lines = 2048,
            standard_widths = { 2, 4, 8 },
        })
    end,
}
