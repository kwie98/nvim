return {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",

    config = function()
        require("noice").setup({
            lsp = {
                documentation = {
                    opts = {
                        win_options = { concealcursor = "n", conceallevel = 1 },
                    },
                },
                progress = { enabled = false },
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            cmdline = { enabled = false },
            messages = { enabled = false },
            notify = { enabled = false },
        })
    end,
}
