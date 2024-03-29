return {
    "ethanholz/nvim-lastplace",
    event = "VeryLazy",

    config = function()
        local lastplace = require("nvim-lastplace")

        lastplace.setup({
            lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
            lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
            lastplace_open_folds = true,
        })
    end,
}
