return {
    {
        "kyazdani42/nvim-tree.lua",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },
        keys = {
            { "<Leader>e", mode = "n" },
        },

        config = function()
            local nvim_tree = require("nvim-tree")

            vim.keymap.set("n", "<Leader>e", nvim_tree.toggle, { desc = "Explorer" })
            nvim_tree.setup({
                respect_buf_cwd = true,
                update_focused_file = {
                    enable = true,
                    update_cwd = false,
                },
                actions = {
                    change_dir = {
                        enable = false,
                    },
                    open_file = {
                        window_picker = {
                            enable = true,
                            chars = "UIOPABCDEFGHJKLMNQRSTVWXYZ",
                        },
                    },
                    remove_file = {
                        close_window = false,
                    },
                },
                renderer = {
                    highlight_git = false,
                    highlight_opened_files = "name",
                    root_folder_modifier = ":t",
                    indent_markers = {
                        enable = true,
                    },
                    icons = {
                        git_placement = "signcolumn",
                        glyphs = {
                            git = {
                                unstaged = "M",
                                staged = "S",
                                unmerged = "",
                                renamed = "R",
                                untracked = "?",
                                deleted = "D",
                                ignored = "",
                            },
                        },
                    },
                },
                view = {
                    width = 30,
                    side = "left",
                    mappings = {
                        list = {
                            { key = { "l", "<CR>", "e" }, action = "edit" },
                            { key = "h", action = "close_node" },
                            { key = "<C-v>", action = "vsplit" },
                            { key = "<C-s>", action = "split" },
                            { key = "n", action = "create" },
                            { key = ".", action = "toggle_dotfiles" },
                            { key = "o", action = "system_open" },
                            { key = "L", action = "cd" },
                            { key = "<C-t>", action = "" },
                            { key = "<C-k>", action = "" },
                            { key = "K", action = "toggle_file_info" },
                        },
                    },
                },
                filters = {
                    dotfiles = false,
                },
                git = {
                    enable = true,
                    ignore = false,
                },
            })
        end,
    },
}
