return {
    "ThePrimeagen/harpoon",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    lazy = true,
    keys = {
        { "<Leader>a", mode = "n", desc = "Add to Harpoon" },
        { "<Leader>h", mode = "n", desc = "Harpoon" },
        { "<Leader>u", mode = "n" },
        { "<Leader>i", mode = "n" },
        { "<Leader>o", mode = "n" },
        { "<Leader>p", mode = "n" },
    },

    config = function()
        local harpoon = require("harpoon")
        local ui = require("harpoon.ui")
        local mark = require("harpoon.mark")

        harpoon.setup({
            menu = {
                width = 128,
            },
        })

        vim.keymap.set("n", "<Leader>a", function()
            mark.add_file()
        end, { desc = "Add to Harpoon" })
        vim.keymap.set("n", "<Leader>h", function()
            ui.toggle_quick_menu()
        end, { desc = "Harpoon" })

        vim.keymap.set("n", "<Leader>u", function()
            ui.nav_file(1)
        end)
        vim.keymap.set("n", "<Leader>i", function()
            ui.nav_file(2)
        end)
        vim.keymap.set("n", "<Leader>o", function()
            ui.nav_file(3)
        end)
        vim.keymap.set("n", "<Leader>p", function()
            ui.nav_file(4)
        end)
    end,
}
