return {
    "stevearc/conform.nvim",
    event = "VeryLazy",

    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                -- TODO remove biome since it should be registered as a LSP with formatting?
                javascript = { "biome" },
                javascriptreact = { "biome" },
                typescript = { "biome" },
                typescriptreact = { "biome" },
                json = { "biome" },
                jsonc = { "biome" },
                markdown = { "prettierd" },
                css = { "prettierd" },
                html = { "prettierd" },
                htmldjango = { "djlint" },
                yaml = { "prettierd" },
                bash = { "shellharden", "shfmt" },
                zsh = { "shellharden", "shfmt" },
            },
        })

        vim.keymap.set("n", "=", function() conform.format({ lsp_fallback = true }) end, { desc = "Format" })
        vim.keymap.set("n", "<Leader>F", "<CMD>ConformInfo<Enter>", { desc = "Formatter Info" })
    end,
}
