return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<Leader>a", mode = "n", desc = "Add to Harpoon" },
        { "<Leader>h", mode = "n", desc = "Harpoon" },
        { "<Leader>u", mode = "n", desc = "Harpoon First" },
        { "<Leader>i", mode = "n", desc = "Harpoon Second" },
        { "<Leader>o", mode = "n", desc = "Harpoon Third" },
        { "<Leader>p", mode = "n", desc = "Harpoon Fourth" },
    },

    config = function()
        local harpoon = require("harpoon")

        harpoon:setup({
            settings = {
                border_chars = { " " },
                save_on_toggle = true,
                sync_on_ui_close = true,
            },
        })

        vim.keymap.set("n", "<Leader>a", function() harpoon:list():append() end)
        vim.keymap.set("n", "<Leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        vim.keymap.set("n", "<Leader>u", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<Leader>i", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<Leader>o", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<Leader>p", function() harpoon:list():select(4) end)
    end,
}
