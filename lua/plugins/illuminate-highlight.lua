return {
    "RRethy/vim-illuminate",
    event = "VeryLazy",

    config = function()
        local illuminate = require("illuminate")
        local ref = require("illuminate.reference")
        local min_count = 2

        illuminate.configure({
            providers = { "lsp", "treesitter" },
            delay = 100,
            filetypes_denylist = { "fugitive", "lazy", "toggleterm", "DressingSelect", "TelescopePrompt" },
            under_cursor = true,
            min_count_to_highlight = min_count,
        })

        vim.keymap.set("n", "*", function()
            local refs = ref.buf_get_references(vim.api.nvim_get_current_buf())
            if not refs or #refs < min_count then return "*" end
            return '<CMD>lua require"illuminate".goto_next_reference()<Enter>'
        end, { expr = true, desc = "Goto next reference or occurence" })
        vim.keymap.set("n", "#", function()
            local refs = ref.buf_get_references(vim.api.nvim_get_current_buf())
            if not refs or #refs < min_count then return "#" end
            return '<CMD>lua require"illuminate".goto_prev_reference()<Enter>'
        end, { expr = true, desc = "Goto prev reference or occurence" })
    end,
}
