return {
    "windwp/nvim-autopairs",
    lazy = true, -- loaded by cmp

    config = function()
        require("nvim-autopairs").setup({
            check_ts = true,
        })
    end,
}
