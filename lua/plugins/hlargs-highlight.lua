return {
    "m-demare/hlargs.nvim",
    -- dependencies = { "folke/tokyonight.nvim" },
    event = "VeryLazy",

    config = function()
        require("hlargs").setup({
            excluded_filetypes = { "TelescopePrompt", "TelescopeResults" },
            extras = { named_parameters = true },
        })
    end,
}
