return {
    "Vigemus/iron.nvim",

    config = function()
        local iron = require("iron.core")
        iron.setup({
            config = {
                -- Highlights the last sent block with bold
                highlight_last = "IronLastSent",

                -- Toggling behavior is on by default.
                -- Other options are: `single` and `focus`
                visibility = require("iron.visibility").toggle,

                -- Scope of the repl
                -- By default it is one for the same `pwd`
                -- Other options are `tab_based` and `singleton`
                scope = require("iron.scope").path_based,

                -- Whether the repl buffer is a "throwaway" buffer or not
                scratch_repl = false,

                -- Automatically closes the repl window on process end
                close_window_on_exit = true,
                repl_definition = {
                    -- forcing a default
                    python = require("iron.fts.python").ipython,

                    -- new, custom repl
                    lua = {
                        -- Can be a table or a function that returns a table (see below)
                        command = { "my-lua-repl", "-arg" },
                    },
                },
                -- repl_open_cmd = require("iron.view").bottom(40),
                repl_open_cmd = require("iron.view").split.vertical.botright(80),
                buflisted = false,
            },
            keymaps = {
                send_motion = "<Leader>rc",
                visual_send = "<Leader>rc",
                -- send_file = "<Leader>rl",
                send_line = "<Leader>rl",
                send_until_cursor = "<Leader>ra",
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
