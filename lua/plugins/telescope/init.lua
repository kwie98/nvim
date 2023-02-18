return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            "IllustratedMan-code/telescope-conda.nvim",
        },
        cmd = "Telescope",
        keys = {
            { "<Leader>f", mode = "n" },
            { "<Leader>F", mode = "n" },
            { "<Leader>gb", mode = "n" },
            { "<Leader>gc", mode = "n" },
            { "<Leader>lm", mode = "n" },
            { "<Leader>lc", mode = "n" },
            { "<Leader>ls", mode = "n" },
            { "<Leader>lw", mode = "n" },
            { "<Leader>ld", mode = "n" },
            { "<Leader>lD", mode = "n" },
            { "<Leader>sh", mode = "n" },
            { "<Leader>sc", mode = "n" },
            { "<Leader>sm", mode = "n" },
            { "<Leader>sr", mode = "n" },
            { "<Leader>sk", mode = "n" },
            { "<Leader>sa", mode = "n" },
            { "<Leader>t", mode = "n" },
        },

        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")
            local actions = require("telescope.actions")
            local my_pickers = require("plugins.telescope.pickers")

            vim.keymap.set("n", "<Leader>f", builtin.find_files, { desc = "Find File" })
            vim.keymap.set("n", "<Leader>F", builtin.live_grep, { desc = "Find Text" })

            vim.keymap.set("n", "<Leader>gb", builtin.git_branches, { desc = "Checkout Branch" })
            vim.keymap.set("n", "<Leader>gc", my_pickers.my_bcommits, { desc = "Find Revision" })

            vim.keymap.set("n", "<Leader>sh", builtin.help_tags, { desc = "Find Help" })
            vim.keymap.set("n", "<Leader>sc", builtin.highlights, { desc = "Find Highlights" })
            vim.keymap.set("n", "<Leader>sm", builtin.man_pages, { desc = "Man Pages" })
            vim.keymap.set("n", "<Leader>sr", builtin.oldfiles, { desc = "Open Recent File" })
            vim.keymap.set("n", "<Leader>sk", builtin.keymaps, { desc = "Keymaps" })
            vim.keymap.set("n", "<Leader>sa", function()
                builtin.find_files({ cwd = "~", hidden = true })
            end, { desc = "Find in Home" })

            vim.keymap.set("n", "<Leader>t", builtin.resume, { desc = "Resume Search" })

            telescope.setup({
                defaults = {
                    border = true,
                    borderchars = {
                        prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
                        results = { " " },
                        preview = { " " },
                    },
                    dynamic_preview_title = true, -- trying this out
                    prompt_prefix = " ",
                    -- selection_caret = " ",
                    path_display = { "truncate" },
                    file_ignore_patterns = { "^.git/" },
                    mappings = {
                        i = {
                            ["<C-v>"] = actions.select_vertical,
                            ["<C-s>"] = actions.select_horizontal,

                            ["<C-b>"] = actions.results_scrolling_up,
                            ["<C-f>"] = actions.results_scrolling_down,

                            ["<C-Space>"] = actions.cycle_previewers_next,

                            ["<Esc>"] = actions.close,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        -- find_command = { "fd", vim.fn.expand("<cword>") },
                        hidden = true,
                        -- no_ignore = true,
                    },
                    live_grep = {
                        additional_args = function()
                            return { "--hidden" }
                        end,
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true, -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                    },
                    conda = {
                        anaconda_path = "/data/conda",
                    },
                },
            })
            telescope.load_extension("fzf")
        end,
    },
    {
        "ahmedkhalf/project.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        event = "VeryLazy",

        config = function()
            local project = require("project_nvim")
            local telescope = require("telescope")

            project.setup({
                manual_mode = false,
                detection_methods = { "pattern" },
                -- patterns = { ">Python", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
                patterns = { ".git" }, -- ">"-patterns break fugitive sadly
                ignore_lsp = {},
                show_hidden = false,
                silent_chdir = true,
                datapath = vim.fn.stdpath("data"),
            })

            vim.keymap.set("n", "<Leader>j", telescope.extensions.projects.projects, { desc = "Projects" })
        end,
    },
}
