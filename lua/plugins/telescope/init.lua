return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        },
        "aaronhallaert/advanced-git-search.nvim",
        "tpope/vim-fugitive",
        -- "sindrets/diffview.nvim",
    },
    -- lazy = true, -- gets loaded by project.nvim
    event = "VeryLazy",

    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        local actions = require("telescope.actions")
        -- local my_pickers = require("plugins.telescope.pickers")
        local advanced_git_search = require("advanced_git_search.telescope.pickers")

        vim.keymap.set(
            "n",
            "<Leader>s~",
            function() builtin.find_files({ cwd = "~", hidden = true }) end,
            { desc = "~/**" }
        )
        vim.keymap.set("n", "<Leader>b", builtin.buffers, { desc = "Buffers" })
        vim.keymap.set("n", "<Leader>t", builtin.live_grep, { desc = "Grep" })
        vim.keymap.set("n", "<Leader>f", builtin.find_files, { desc = "Files" })

        -- vim.keymap.set("n", "<Leader>sd", my_pickers.my_bcommits, { desc = "Git Commits" })
        vim.keymap.set("n", "<Leader>sd", advanced_git_search.search_log_content_file, { desc = "File Diffs" })
        vim.keymap.set("n", "<Leader>sg", advanced_git_search.search_log_content, { desc = "Git" })
        vim.keymap.set("n", "<Leader>sc", builtin.highlights, { desc = "Highlights" })
        vim.keymap.set("n", "<Leader>sh", builtin.help_tags, { desc = "Help" })
        vim.keymap.set("n", "<Leader>sk", builtin.keymaps, { desc = "Keys" })
        vim.keymap.set("n", "<Leader>sm", builtin.man_pages, { desc = "Manual" })
        vim.keymap.set("n", "<Leader>sr", builtin.oldfiles, { desc = "Recent Files" })
        vim.keymap.set("n", "<Leader>st", builtin.resume, { desc = "Resume Search" })

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
                        ["<C-Space>"] = actions.cycle_previewers_next,
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
                            ["<C-v>"] = actions.select_vertical,
                            ["<C-s>"] = actions.select_horizontal,
                            ["dd"] = actions.delete_buffer,
                        },
                    },
                },
            },
            extensions = {
                advanced_git_search = {
                    entry_default_author_or_date = "date",
                },
            },
        })
        telescope.load_extension("fzf")
        telescope.load_extension("advanced_git_search")
    end,
}
