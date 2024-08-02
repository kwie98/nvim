return {
    "Vigemus/iron.nvim",

    config = function()
        local iron = require("iron.core")
        iron.setup({
            config = {
                highlight_last = "IronLastSent", -- Highlights the last sent block with bold

                -- Toggling behavior is on by default.
                -- Other options are: `single` and `focus`
                visibility = require("iron.visibility").toggle,

                -- Scope of the repl
                -- By default it is one for the same `pwd`
                -- Other options are `tab_based` and `singleton`
                scope = require("iron.scope").path_based,

                scratch_repl = false, -- Whether the repl buffer is a "throwaway" buffer or not

                close_window_on_exit = true, -- Automatically closes the repl window on process end
                repl_definition = {
                    -- python = require("iron.fts.python").ipython,
                    python = {
                        format = require("iron.fts.common").bracketed_paste,
                        command = { "ipython", "--no-autoindent" },
                    },
                },
                -- repl_open_cmd = require("iron.view").bottom(40),
                repl_open_cmd = require("iron.view").split.vertical.botright(80),
                buflisted = false,
            },
            keymaps = {
                send_motion = "<Leader>rv",
                visual_send = "<Leader>r",
                send_file = "<Leader>rr",
                send_line = "<Leader>rl",
                send_until_cursor = "<Leader>rc",
                -- send_mark = "<Leader>sm",
                -- mark_motion = "<Leader>mc",
                -- mark_visual = "<Leader>mc",
                -- remove_mark = "<Leader>md",
                -- cr = "<Leader>s<cr>",
                -- interrupt = "<Leader>r<Leader>",
                exit = "<Leader>rq",
                -- clear = "<Leader>cl",
            },

            -- If the highlight is on, you can change how it looks
            -- For the available options, check nvim_set_hl
            highlight = {
                italic = true,
            },
        })
    end,
}
