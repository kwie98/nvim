return {
    {
        "tpope/vim-fugitive",
        cmd = {
            "Git",
            "Gdiffsplit",
        },
        keys = {
            { "<Leader>gg", mode = "n", desc = "Git" },
            { "<Leader>gd", mode = "n", desc = "Diff File" },
            { "<Leader>gD", mode = "n" },
            { "<Leader>gm", mode = "n" },
        },

        config = function()
            vim.keymap.set("n", "<Leader>gg", "<CMD>72vsplit<BAR>0Git<CR>", { desc = "Git" })
            vim.keymap.set("n", "<Leader>gd", "<CMD>Gdiffsplit<CR>", { desc = "Diff File" })
            vim.keymap.set("n", "<Leader>gD", "<CMD>Git difftool -y HEAD<CR>", { desc = "Diff All Files" })
            vim.keymap.set("n", "<Leader>gm", "<CMD>Git mergetool -y | tabprevious<CR>", { desc = "Merge" })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },

        config = function()
            local gitsigns = require("gitsigns")

            vim.keymap.set("n", "<Leader>gz", function()
                gitsigns.toggle_linehl()
                gitsigns.toggle_deleted()
            end, { desc = "Toggle Hunks" })
            vim.keymap.set("n", "<Leader>gB", gitsigns.toggle_current_line_blame, { desc = "Blame" })
            vim.keymap.set("n", "<Leader>gr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
            vim.keymap.set("n", "<Leader>gR", gitsigns.reset_buffer, { desc = "Reset Buffer" })
            vim.keymap.set("n", "<Leader>gs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
            vim.keymap.set("n", "<Leader>gS", gitsigns.stage_buffer, { desc = "Stage Buffer" })
            vim.keymap.set("n", "<Leader>gu", gitsigns.undo_stage_hunk, { desc = "Undo Stage Hunk" })

            vim.keymap.set("v", "<Leader>gs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
            vim.keymap.set("v", "<Leader>gr", gitsigns.reset_hunk, { desc = "Reset Hunk" })

            gitsigns.setup({
                signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
                numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
                linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir = {
                    interval = 1000,
                    follow_files = true,
                },
                attach_to_untracked = true,
                current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                    delay = 0,
                    ignore_whitespace = false,
                },
                current_line_blame_formatter_opts = {
                    relative_time = false,
                },
                sign_priority = 0,
                update_debounce = 100,
                status_formatter = nil, -- Use default
                max_file_length = 40000,
                preview_config = {
                    -- Options passed to nvim_open_win
                    border = vim.g.small_border,
                    style = "minimal",
                    relative = "cursor",
                    row = 0,
                    col = 1,
                },
                yadm = {
                    enable = false,
                },
            })
        end,
    },
}
