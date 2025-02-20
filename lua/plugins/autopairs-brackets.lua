return {
    "windwp/nvim-autopairs",
    lazy = true, -- loaded by cmp

    config = function()
        local autopairs = require("nvim-autopairs")
        local Rule = require("nvim-autopairs.rule")
        local cond = require("nvim-autopairs.conds")

        autopairs.setup({
            check_ts = true,
            enable_abbr = true,
            enable_afterquote = false,
        })

        autopairs.add_rule(Rule("%", "%"):with_pair(cond.before_text("{")))
        autopairs.add_rule(Rule(" ", " ")
            -- :with_pair(function(opts)
            --     local pair = opts.line:sub(opts.col - 1, opts.col)
            --     return vim.tbl_contains({ "()", "{}", "%%" }, pair)
            -- end)
            :with_pair(cond.done())
            :replace_endpair(function(opts)
                local pair = opts.line:sub(opts.col - 1, opts.col)
                if vim.tbl_contains({ "()", "{}", "%%" }, pair) then
                    return " " -- it return space here
                end
                return "" -- return empty
            end)
            :with_move(cond.none())
            :with_cr(cond.none())
            :with_del(function(opts)
                local col = vim.api.nvim_win_get_cursor(0)[2]
                local context = opts.line:sub(col - 1, col + 2)
                return vim.tbl_contains({ "(  )", "{  }", "%  %" }, context)
            end))
    end,
}
