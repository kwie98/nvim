return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",

    config = function()
        local gitsigns = require("gitsigns")

        vim.keymap.set("n", "]h", function()
            if vim.wo.diff then
                vim.cmd.normal({ "]c", bang = true })
            else
                gitsigns.nav_hunk("next")
            end
        end)

        vim.keymap.set("n", "[h", function()
            if vim.wo.diff then
                vim.cmd.normal({ "[c", bang = true })
            else
                gitsigns.nav_hunk("prev")
            end
        end)

        -- vim.keymap.set("n", "<Leader>gh", function()
        --     gitsigns.toggle_linehl()
        --     gitsigns.toggle_deleted()
        --     gitsigns.toggle_word_diff()
        -- end, { desc = "Toggle Hunks" })
        vim.keymap.set("n", "<Leader>gb", gitsigns.toggle_current_line_blame, { desc = "Blame" })

        gitsigns.setup({
            signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
            numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
            linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = { interval = 1000, follow_files = true },
            attach_to_untracked = true,
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 0,
                ignore_whitespace = false,
            },
            sign_priority = 0,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000,
        })
    end,
}
