return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = { "<Leader>e", mode = "n", desc = "Open Explorer" },

    config = function()
        vim.keymap.set("n", "<Leader>e", require("oil").open, { desc = "Open Explorer" })

        require("oil").setup({
            columns = {
                "icon",
            },
            delete_to_trash = true,
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<Enter>"] = "actions.select",
                ["<C-v>"] = "actions.select_vsplit",
                ["<C-s>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["<Tab>"] = "actions.preview",
                ["<Leader>e"] = "actions.close", -- TODO also close preview?
                ["q"] = "actions.close",
                -- ["<C-l>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["<Leader>j"] = "actions.open_cwd",
                -- ["`"] = "actions.cd",
                -- ["~"] = "actions.tcd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
            view_options = { show_hidden = true },
        })
    end,
}
