return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        -- { "<Leader>H", mode = "n", desc = "Harpoon Terminals" },
        { "<Leader>a", mode = "n", desc = "Add to Harpoon" },
        { "<Leader>h", mode = "n", desc = "Harpoon" },
        { "<Leader>u", mode = "n", desc = "Harpoon First" },
        { "<Leader>i", mode = "n", desc = "Harpoon Second" },
        { "<Leader>o", mode = "n", desc = "Harpoon Third" },
        { "<Leader>p", mode = "n", desc = "Harpoon Fourth" },
    },

    config = function()
        local harpoon = require("harpoon")
        -- local Terminal = require("toggleterm.terminal").Terminal
        -- local terminals = {}

        harpoon:setup({
            settings = {
                border_chars = { " " },
                save_on_toggle = true,
                sync_on_ui_close = true,
            },
            -- terminals = {
            --     select = function(list_item, list, _)
            --         local root = list.config.get_root_dir()
            --         local cmd = list_item.value
            --         -- local terminal = terminals[root][cmd]
            --         if terminals[root] == nil then
            --             terminals[root] = {}
            --         end
            --         if terminals[root] ~= nil and terminals[root][cmd] ~= nil then
            --             terminals[root][cmd]:toggle()
            --             return
            --         end
            --         -- terminals[root] =
            --         local terminal = Terminal:new({
            --             cmd = cmd,
            --             direction = "float",
            --             hidden = true,
            --         })
            --         terminals[root][cmd] = terminal

            --         terminal:toggle()
            --     end,
            -- },
        })

        -- local terminals = require("harpoon.list").decode({
        --     terminals = {
        --         select = function(list_item, _, _) print(list_item.value) end,
        --     },
        -- }, "terminals", {})
        -- local terminals = require("harpoon.list"):new({
        --     select = function(list_item, _, _) print(list_item.value) end,
        -- })
        -- vim.keymap.set("n", "<Leader>H", function() harpoon.ui:toggle_quick_menu(harpoon:list("terminals")) end)
        -- require("harpoon.data")
        -- harpoon.lists[terminals]

        vim.keymap.set("n", "<Leader>a", function() harpoon:list():append() end)
        vim.keymap.set("n", "<Leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        vim.keymap.set("n", "<Leader>u", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<Leader>i", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<Leader>o", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<Leader>p", function() harpoon:list():select(4) end)
    end,
}
