return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",

    config = function()
        local gitsigns = require("gitsigns")

        vim.keymap.set("n", "]h", function()
            if vim.wo.diff then return "]c" end
            gitsigns.next_hunk()
            return "<Ignore>"
        end, { expr = true })
        vim.keymap.set("n", "[h", function()
            if vim.wo.diff then return "[c" end
            gitsigns.prev_hunk()
            return "<Ignore>"
        end, { expr = true })

        vim.keymap.set("n", "<Leader>gh", function()
            gitsigns.toggle_linehl()
            gitsigns.toggle_deleted()
            gitsigns.toggle_word_diff()
        end, { desc = "Toggle Hunks" })
        vim.keymap.set("n", "<Leader>gb", gitsigns.toggle_current_line_blame, { desc = "Blame" })
        vim.keymap.set("n", "<Leader>gr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
        vim.keymap.set("n", "<Leader>gs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
        vim.keymap.set("n", "<Leader>gS", gitsigns.undo_stage_hunk, { desc = "Undo Stage Hunk" })

        vim.keymap.set("v", "<Leader>gr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
        vim.keymap.set("v", "<Leader>gs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)

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
