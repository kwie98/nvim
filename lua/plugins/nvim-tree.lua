local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    print("Could not load nvim-tree.")
    return
end

-- local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
-- if not config_status_ok then
--     return
-- end

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
                -- default = "",
                -- symlink = "",
                -- folder = {
                --     arrow_open = "",
                --     arrow_closed = "",
                --     default = "",
                --     open = "",
                --     empty = "",
                --     empty_open = "",
                --     symlink = "",
                --     symlink_open = "",
                -- },
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
    -- diagnostics = {
    --     enable = false,
    --     show_on_dirs = true,
    --     icons = {
    --         hint = "",
    --         info = "",
    --         warning = "",
    --         error = "",
    --     },
    -- },
    view = {
        width = 30,
        -- height = 30,
        side = "left",
        mappings = {
            list = {
                { key = { "l", "o", "e" }, action = "edit" },
                { key = "h", action = "close_node" },
                { key = "<C-v>", action = "vsplit" },
                { key = "<C-s>", action = "split" },
                { key = "n", action = "create" },
                { key = ".", action = "toggle_dotfiles" },
                { key = "<CR>", action = "system_open" },
                { key = "L", action = "cd" },
                { key = "<C-t>", action = "" },
                { key = "<C-k>", action = "" },
                { key = "K", action = "toggle_file_info" },
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
