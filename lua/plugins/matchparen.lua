return {
    "monkoose/matchparen.nvim",
    lazy = false, -- load before builtin plugin

    config = function()
        require("matchparen").setup({
            debounce_time = 0,
        })
    end,
}
