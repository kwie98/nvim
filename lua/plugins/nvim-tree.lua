local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    print("Could not load nvim-tree.")
    return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
    return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup({
    -- sync_root_with_cwd = true,
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
                enable = false,
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
                default = "",
                symlink = "",
                folder = {
                    arrow_open = "",
                    arrow_closed = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    -- unstaged = "",
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
    diagnostics = {
        enable = false,
        show_on_dirs = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    view = {
        width = 30,
        height = 30,
        side = "left",
        mappings = {
            list = {
                { key = { "l", "<CR>", "o", "e" }, cb = tree_cb("edit") },
                { key = "h", cb = tree_cb("close_node") },
                { key = "v", cb = tree_cb("vsplit") },
                { key = "n", cb = tree_cb("create") },
                { key = ".", cb = tree_cb("toggle_dotfiles") },
                { key = "<Enter>", cb = tree_cb("system_open") },
                { key = "L", cb = tree_cb("cd") },
                { key = "<C-t>", cb = nil }, -- TODO
            },
        },
    },
    filters = {
        dotfiles = false,
        -- custom = { "^.git$" },
    },
    git = {
        enable = true,
        ignore = false,
    },
})
