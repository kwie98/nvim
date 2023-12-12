return {
    "RRethy/vim-illuminate",
    event = "VeryLazy",

    config = function()
        local illuminate = require("illuminate")

        illuminate.configure({
            providers = { "lsp", "treesitter" },
            delay = 400,
            -- filetype_overrides = {},
            filetypes_denylist = { "fugitive", "lazy", "toggleterm", "DressingSelect", "TelescopePrompt" },
            under_cursor = true,
            min_count_to_highlight = 2,
        })

        local next = function() illuminate.goto_next_reference(false) end
        local prev = function() illuminate.goto_prev_reference(false) end

        vim.keymap.set("n", "]]", next, { desc = "Goto next reference" })
        vim.keymap.set("n", "[[", prev, { desc = "Goto previous reference" })

        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                vim.keymap.set("n", "]]", next, { buffer = true, desc = "Goto next reference" })
                vim.keymap.set("n", "[[", prev, { buffer = true, desc = "Goto previous reference" })
            end,
        })
    end,
}
