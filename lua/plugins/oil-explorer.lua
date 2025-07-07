---@type LazySpec
return {
    "stevearc/oil.nvim",
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "-", "<CMD>Oil<CR>", desc = "Oil" },
    },
    lazy = false,

    opts = {
        default_file_explorer = true,
        -- columns = { "permissions", "mtime", "size" },
        delete_to_trash = true,
        cleanup_delay_ms = 0,
        keymaps = {
            ["<F1>"] = "actions.show_help",
            ["<Tab>"] = "actions.preview",
            ["~"] = false,
            ["gd"] = { "actions.cd", opts = { scope = "win" } },
        },
        -- keymaps = {
        --     ["g?"] = "actions.show_help",
        --     ["<Enter>"] = "actions.select",
        --     -- ["<C-v>"] = { "actions.select_vsplit", mode = "n" },
        --     -- ["<C-s>"] = "actions.select_split",
        --     -- ["<C-t>"] = "actions.select_tab",
        --     ["<Tab>"] = "actions.preview",
        --     ["-"] = "actions.parent",
        --     ["J"] = { "actions.cd", opts = { scope = "tab" } },
        --     ["gs"] = "actions.change_sort",
        --     ["gx"] = "actions.open_external",
        --     ["g."] = "actions.toggle_hidden",
        --     ["g\\"] = "actions.toggle_trash",
        --     ["<Leader>y"] = "actions.copy_entry_path",
        --     ["_"] = false,
        -- },
        view_options = {
            show_hidden = true,
            is_always_hidden = function(name, _) return name == ".." end,
        },
        watch_for_changes = true,
        preview_win = {
            preview_method = "load", -- for dcmdump (ftplugin)
        },
        lsp_file_methods = {
            timeout_ms = 5000,
        },
    },
}
