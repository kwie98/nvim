return {
    {
        "andymass/vim-matchup",
        event = "VeryLazy",

        config = function()
            vim.g.matchup_matchparen_offscreen = {} -- disable weird float that shows match

            vim.g.matchup_matchparen_deferred = 0
            vim.g.matchup_matchparen_hi_surround_always = 0 -- 1 is extremely laggy in some filetypes
        end,
    },
}
