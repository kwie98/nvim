return {
    "sindrets/diffview.nvim",
    -- lazy = true, -- loaded by telescope/advanced git search

    config = function()
        local diffview = require("diffview")
        local actions = require("diffview.actions")
        diffview.setup({
            enhanced_diff_hl = true,
            use_icons = false,
            keymaps = {
                disable_defaults = true,
                view = {
                    { "n", "<Tab>", actions.select_next_entry },
                    { "n", "<s-Tab>", actions.select_prev_entry },
                    { { "n", "x" }, "<CR>", ":diffget<CR>" },
                    { "n", "<Leader><CR>", "<CMD>%diffget<CR>", { desc = "Stage whole file" } },
                },
                file_panel = {
                    { "n", "<Tab>", actions.select_next_entry },
                    { "n", "<s-Tab>", actions.select_prev_entry },
                    { "n", "<CR>", actions.select_entry },
                    { "n", "j", actions.next_entry },
                    { "n", "s", actions.toggle_stage_entry },
                    { "n", "k", actions.prev_entry },
                },
                file_history_panel = {
                    { "n", "<Tab>", actions.select_next_entry },
                    { "n", "<S-Tab>", actions.select_prev_entry },
                    { "n", "<Leader><CR>", actions.open_in_diffview, { desc = "Open in Diffview" } },
                    { "n", "j", actions.next_entry },
                    { "n", "k", actions.prev_entry },
                    { "n", "<CR>", actions.select_entry },
                    { "n", "<C-u>", actions.scroll_view(-0.5) },
                    { "n", "<C-d>", actions.scroll_view(0.5) },
                },
            },
        })

        vim.keymap.set("n", "<Leader>gd", diffview.open, { desc = "Diffview" })
        vim.keymap.set("n", "<Leader>gh", diffview.file_history, { desc = "History" })
        vim.keymap.set(
            "n",
            "<Leader>gf",
            function() diffview.file_history(nil, { "%" }) end,
            { desc = "History of this File" }
        )
    end,
}
