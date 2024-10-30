return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = { { "-", mode = "n", desc = "Open Explorer" } },

    config = function()
        local oil = require("oil")
        vim.keymap.set("n", "-", oil.open, { desc = "Open Explorer (parent)" })
        vim.keymap.set("n", "—", function() oil.open(vim.fn.getcwd()) end, { desc = "Open Explorer (cwd)" })

        oil.setup({
            columns = { "permissions", "mtime", "icon" },
            delete_to_trash = true,
            cleanup_delay_ms = 0,
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<Enter>"] = "actions.select",
                ["<C-v>"] = { "actions.select_vsplit", mode = "n" },
                ["<C-s>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["<Tab>"] = "actions.preview",
                ["-"] = "actions.parent",
                ["J"] = { "actions.cd", opts = { scope = "tab" } },
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
                ["<Leader>y"] = "actions.copy_entry_path",
                ["_"] = false,
            },
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, _) return name == ".." end,
            },
            watch_for_changes = true,
        })
    end,
}
