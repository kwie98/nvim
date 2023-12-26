return {
    "monkoose/matchparen.nvim",
    event = "VeryLazy",

    config = function()
        require("matchparen").setup({
            debounce_time = 0,
        })
    end,
}
