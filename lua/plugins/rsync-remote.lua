return {
    "OscarCreator/rsync.nvim",
    build = "make",
    dependencies = "nvim-lua/plenary.nvim",
    event = "VeryLazy",

    config = function()
        require("rsync").setup({})
    end,
}
