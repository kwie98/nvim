return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = { "-", mode = "n", desc = "Open Explorer" },

    config = function()
        vim.keymap.set("n", "-", require("oil").open, { desc = "Open Explorer" })

        require("oil").setup({
            columns = {
                "icon",
            },
            delete_to_trash = true,
            cleanup_delay_ms = 0,
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<Enter>"] = "actions.select",
                ["<C-v>"] = "actions.select_vsplit",
                ["<C-s>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["<Tab>"] = "actions.preview",
                ["-"] = "actions.parent",
                ["<Leader>j"] = "actions.open_cwd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, _) return name == ".." end,
            },
        })
    end,
}
