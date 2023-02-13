return {
    {
        "lewis6991/impatient.nvim",
        lazy = false,
    },
    {
        "tpope/vim-repeat",
        lazy = false,
    },
    {
        "AndrewRadev/splitjoin.vim",
        keys = {
            { "gS", mode = "n" },
            { "gJ", mode = "n" },
        },
    },
    {
        "ethanholz/nvim-lastplace",
        lazy = false,

        config = function()
            local lastplace = require("nvim-lastplace")

            lastplace.setup({
                lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
                lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
                lastplace_open_folds = true,
            })
        end,
    },
}
