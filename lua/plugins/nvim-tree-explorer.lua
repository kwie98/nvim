return {
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
            api.tree.toggle({ focus = false })
            vim.cmd("setlocal winhighlight+=CursorLine:CursorLineCurrent")
        end, { desc = "Toggle Explorer" })

        nvim_tree.setup({
            sync_root_with_cwd = false,
            respect_buf_cwd = false,
            hijack_cursor = true,
            disable_netrw = false,
            hijack_netrw = true,
            update_focused_file = {
                enable = true,
                update_root = false,
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
            on_attach = function(bufnr)
                local function opts(desc)
                    return {
                        desc = "nvim-tree: " .. desc,
                        buffer = bufnr,
                        noremap = true,
                        silent = true,
                        nowait = true,
                    }
                end

                -- Default mappings. Feel free to modify or remove as you wish.
                --
                -- BEGIN_DEFAULT_ON_ATTACH
                -- vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
                vim.keymap.set("n", "~", function()
                    api.tree.change_root("~")
                end, opts("Goto ~"))
                vim.keymap.set("n", "J", function()
                    api.tree.change_root(vim.fn.getcwd())
                end, opts("Goto CWD"))
                vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
                vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
                vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
                vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
                vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
                vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
                vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
                vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
                vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
                vim.keymap.set("n", "a", api.fs.create, opts("Create"))
                vim.keymap.set("n", "bd", api.marks.bulk.delete, opts("Delete Bookmarked"))
                vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
                vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle Filter: No Buffer"))
                vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
                vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Filter: Git Clean"))
                vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
                vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
                vim.keymap.set("n", "d", api.fs.trash, opts("Trash"))
                vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
                vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
                vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
                vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter"))
                vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
                vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
                vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
                vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Filter: Git Ignore"))
                vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
                vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
                vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
                vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
                vim.keymap.set("n", "q", api.tree.close, opts("Close"))
                vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
                vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
                vim.keymap.set("n", "s", api.node.run.system, opts("Run System"))
                vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
                vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Filter: Hidden"))
                vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
                vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
                vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
                vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
                vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
                vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
                -- END_DEFAULT_ON_ATTACH

                -- Mappings migrated from view.mappings.list
                --
                -- You will need to insert "your code goes here" for any mappings with a custom action_cb
                vim.keymap.set("n", "H", api.tree.change_root_to_parent, opts("Up"))
                vim.keymap.set("n", "L", api.tree.change_root_to_node, opts("CD"))
                vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
                vim.keymap.set("n", "e", api.node.open.edit, opts("Open"))
                vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
                vim.keymap.set("n", "<C-s>", api.node.open.horizontal, opts("Open: Horizontal Split"))
                vim.keymap.set("n", "n", api.fs.create, opts("Create"))
                vim.keymap.set("n", ".", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
                vim.keymap.set("n", "o", api.node.run.system, opts("Run System"))
                vim.keymap.set("n", "K", api.node.show_info_popup, opts("Info"))
                vim.keymap.set("n", "<C-Space>", api.marks.toggle, opts("Toggle Bookmark"))
            end,
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
                width = 24,
                side = "left",
            },
            filters = {
                dotfiles = false,
            },
            git = {
                enable = true,
                ignore = true,
            },
        })
    end,
}
