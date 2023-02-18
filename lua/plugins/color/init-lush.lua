return {
    {
        "rktjmp/lush.nvim",
        lazy = false,

        config = function ()
            pcall(vim.cmd.colorscheme, "habamax")
        end
    }
}
