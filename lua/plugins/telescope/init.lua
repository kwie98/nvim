return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        },
    },
    lazy = true, -- gets loaded by project.nvim
    -- cmd = "Telescope",
    -- keys = {
    --     { "<Leader>F", mode = "n", desc = "Find in Home" },
    --     { "<Leader>b", mode = "n", desc = "Find Buffer" },
    --     { "<Leader>f", mode = "n", desc = "Find File" },
    --     { "<Leader>gb", mode = "n", desc = "Checkout Branch" },
    --     { "<Leader>gd", mode = "n", desc = "Diff File" },
    --     { "<Leader>sc", mode = "n", desc = "Find Highlight" },
    --     { "<Leader>sh", mode = "n", desc = "Find Help" },
    --     { "<Leader>sk", mode = "n", desc = "Keymaps" },
    --     { "<Leader>sm", mode = "n", desc = "Man Pages" },
    --     { "<Leader>sr", mode = "n", desc = "Open Recent File" },
    --     { "<Leader>st", mode = "n", desc = "Find Text" },
    --     { "<Leader>t", mode = "n", desc = "Resume Search" },
    -- },

    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        local actions = require("telescope.actions")
        local my_pickers = require("plugins.telescope.pickers")

        vim.keymap.set(
            "n",
            "<Leader>F",
            function() builtin.find_files({ cwd = "~", hidden = true }) end,
            { desc = "Find in Home" }
        )
        vim.keymap.set("n", "<Leader>b", builtin.buffers, { desc = "Find Buffer" })
        vim.keymap.set("n", "<Leader>f", builtin.find_files, { desc = "Find File" })
        vim.keymap.set("n", "<Leader>gb", builtin.git_branches, { desc = "Checkout Branch" })
        vim.keymap.set("n", "<Leader>gd", my_pickers.my_bcommits, { desc = "Diff File" })
        vim.keymap.set("n", "<Leader>sc", builtin.highlights, { desc = "Find Highlight" })
        vim.keymap.set("n", "<Leader>sh", builtin.help_tags, { desc = "Find Help" })
        vim.keymap.set("n", "<Leader>sk", builtin.keymaps, { desc = "Keymaps" })
        vim.keymap.set("n", "<Leader>sm", builtin.man_pages, { desc = "Man Pages" })
        vim.keymap.set("n", "<Leader>sr", builtin.oldfiles, { desc = "Open Recent File" })
        vim.keymap.set("n", "<Leader>st", builtin.live_grep, { desc = "Find Text" })
        vim.keymap.set("n", "<Leader>t", builtin.resume, { desc = "Resume Search" })

        telescope.setup({
            defaults = {
                border = true,
                borderchars = {
                    prompt = { " " },
                    results = { " " },
                    preview = { " " },
                },
                layout_strategy = "flex",
                sorting_strategy = "ascending",
                layout_config = {
                    flex = {
                        flip_columns = 190,
                    },
                    horizontal = {
                        width = 0.85,
                        preview_width = 0.618,
                        prompt_position = "top",
                    },
                    vertical = {
                        width = 0.85,
                        preview_height = 0.618,
                        prompt_position = "top",
                        mirror = true,
                    },
                },
                dynamic_preview_title = true,
                prompt_prefix = " ",
                selection_caret = "  ",
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--trim",
                },
                path_display = { "truncate" },
                file_ignore_patterns = { "^.git/" },
                mappings = {
                    i = {
                        ["<C-v>"] = actions.select_vertical,
                        ["<C-s>"] = actions.select_horizontal,
                        ["<C-b>"] = actions.results_scrolling_up,
                        ["<C-f>"] = actions.results_scrolling_down,
                        ["<C-i>"] = actions.cycle_history_next,
                        ["<C-o>"] = actions.cycle_history_prev,
                        ["<Esc>"] = actions.close,
                        ["<C-c>"] = actions.send_to_qflist + actions.open_qflist,
                        ["<C-q>"] = actions.nop,
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
                live_grep = {
                    additional_args = { "--hidden" },
                    disable_coordinates = true,
                },
                buffers = {
                    ignore_current_buffer = true,
                    sort_mru = true,
                    mappings = {
                        i = {
                            ["<Esc>"] = false,
                        },
                        n = {
                            ["<C-Space>"] = actions.toggle_selection + actions.move_selection_worse,
                            ["dd"] = actions.delete_buffer,
                        },
                    },
                },
            },
            extensions = {},
        })
        telescope.load_extension("fzf")
    end,
}
