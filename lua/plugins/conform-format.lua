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
                markdown = { "prettierd", "injected" },
                css = { "prettierd" },
                html = { "prettierd", "rustywind" },
                htmldjango = { "djlint", "rustywind" },
                yaml = { "prettierd" },
                bash = { "shellharden", "shfmt" },
                zsh = { "shellharden", "shfmt" },
                python = { "ruff_format" },
            },
        })

        vim.keymap.set("n", "=", function()
            local success = conform.format({ lsp_fallback = true })
            if not success then vim.fn.feedkeys("=", "n") end
        end, { desc = "Format" })
        vim.keymap.set("x", "=", function()
            local success = conform.format({ lsp_fallback = true })
            if not success then vim.fn.feedkeys("=", "n") end
        end, { desc = "Format Range" })
        vim.keymap.set("n", "<Leader>F", "<CMD>ConformInfo<Enter>", { desc = "Formatter Info" })
    end,
}
