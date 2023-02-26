return {
    {
        "kyazdani42/nvim-tree.lua",
        dependencies = {
            "kyazdani42/nvim-web-devicons",
        },
        keys = {
            { "<Leader>e", mode = "n", desc = "Toggle Explorer" },
            { "<Leader>E", mode = "n", desc = "Focus Explorer" },
        },

        config = function()
            local nvim_tree = require("nvim-tree")
            local api = require("nvim-tree.api")

            -- Close nvim-tree when it is the last window:
            vim.api.nvim_create_autocmd("BufEnter", {
                nested = true,
                callback = function()
                    if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
                        vim.cmd("quit")
                    end
                end,
            })

            vim.keymap.set("n", "<Leader>E", function()
                if vim.bo.filetype == "NvimTree" then
                    -- We are in the tree window; go to previous window:
                    vim.cmd("wincmd p")
                else
                    -- We are not in the tree window; open or focus the tree:
                    nvim_tree.focus()
                    vim.cmd("setlocal winhighlight+=CursorLine:CursorLineCurrent")
                end
            end, { desc = "Focus Explorer" })

            vim.keymap.set("n", "<Leader>e", function()
                nvim_tree.toggle({ focus = false })
                vim.cmd("setlocal winhighlight+=CursorLine:CursorLineCurrent")
            end, { desc = "Toggle Explorer" })

            nvim_tree.setup({
                sync_root_with_cwd = true,
                respect_buf_cwd = true,
                hijack_cursor = true,
                disable_netrw = true,
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
                    -- preserve_window_proportions = true, -- not working
                    -- width = 24,
                    -- side = "right",
                    float = {
                        enable = true,
                        quit_on_focus_loss = false,
                        open_win_config = {
                            -- relative = "win",
                            border = "none",
                            width = 32,
                            height = 53, -- TODO less hacky solution
                            row = 1,
                            col = 1000, -- TODO less hacky solution
                        },
                    },
                    mappings = {
                        list = {
                            { key = { "H" },              action = "dir_up" },
                            { key = { "L" },              action = "cd" },
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
                            {
                                key = "<C-Space>",
                                action = "toggle_mark",
                                action_cb = function()
                                    api.marks.toggle()
                                    vim.cmd("norm! j")
                                end,
                            },
                            {
                                key = "p",
                                action = "paste",
                                action_cb = function()
                                    local marks = api.marks.list()
                                    if #marks == 0 then
                                        api.fs.paste()
                                    else
                                        api.marks.bulk.move()
                                        -- api.marks.clear()
                                    end
                                end,
                            },
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
