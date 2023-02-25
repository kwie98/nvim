return {
    {
        "kyazdani42/nvim-tree.lua",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },
        keys = {
            { "<Leader>e", mode = "n", desc = "Focus Explorer" },
            { "<Leader>E", mode = "n", desc = "Toggle Explorer" },
        },

        config = function()
            local nvim_tree = require("nvim-tree")

            vim.keymap.set("n", "<Leader>e", function()
                if vim.bo.filetype == "NvimTree" then
                    -- we are in the tree window
                    vim.cmd("wincmd p")
                else
                    -- we are not in the tree window
                    nvim_tree.focus()
                    vim.cmd("setlocal winhighlight+=CursorLine:CursorLineCurrent")
                end
            end, { desc = "Focus Explorer" })
            vim.keymap.set("n", "<Leader>E", function()
                nvim_tree.toggle({focus = false})
                vim.cmd("setlocal winhighlight+=CursorLine:CursorLineCurrent")
            end, { desc = "Toggle Explorer" })

            nvim_tree.setup({
                sync_root_with_cwd = true,
                respect_buf_cwd = true,
                update_focused_file = {
                    enable = true,
                    update_root = true,
                },
                system_open = {
                    cmd = "gio",
                    args = { "open" },
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
                    add_trailing = true,
                    group_empty = true,
                    full_name = true,
                    highlight_git = false,
                    highlight_opened_files = "name",
                    root_folder_label = ":t",
                    indent_markers = {
                        enable = true,
                    },
                    icons = {
                        show = {
                            folder_arrow = false,
                        },
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
                    -- width = {
                    --     min = 32,
                    --     max = 64,
                    -- },
                    side = "left",
                    mappings = {
                        list = {
                            { key = { "l", "<CR>", "e" }, action = "edit" },
                            { key = "h",                  action = "close_node" },
                            { key = "<C-v>",              action = "vsplit" },
                            { key = "<C-s>",              action = "split" },
                            { key = "n",                  action = "create" },
                            { key = ".",                  action = "toggle_dotfiles" },
                            { key = "o",                  action = "system_open" },
                            { key = "L",                  action = "cd" },
                            { key = "<C-t>",              action = "" },
                            { key = "<C-k>",              action = "" },
                            { key = "K",                  action = "toggle_file_info" },
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
