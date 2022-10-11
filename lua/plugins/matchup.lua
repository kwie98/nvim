vim.g.matchup_matchparen_offscreen = {} -- disable weird float that shows match

vim.g.matchup_matchparen_deferred = 0
vim.g.matchup_matchparen_hi_surround_always = 0 -- 1 is extremely laggy in some filetypes

-- highlighting for matching parents and words is the same, grey background
-- vim.cmd([[
--     hi MatchParenCur cterm=None gui=None
--     " hi MatchParen ctermbg=237 guibg=#3c3836
--     hi MatchWord cterm=NONE gui=NONE ctermbg=237 guibg=#3c3836
--     hi MatchWordCur cterm=NONE gui=NONE ctermbg=237 guibg=#3c3836
-- ]])
