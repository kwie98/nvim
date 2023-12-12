return {
    "m-demare/hlargs.nvim",
    event = "VeryLazy",

    config = function()
        require("hlargs").setup({
            excluded_filetypes = { "TelescopePrompt", "TelescopeResults", "harpoon" },
            extras = { named_parameters = true },
        })
    end,
}
