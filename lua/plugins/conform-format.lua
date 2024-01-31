return {
    "stevearc/conform.nvim",
    event = "VeryLazy",

    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                -- TODO remove biome since it should be registered as a LSP with formatting?
                javascript = { "biome" },
                javascriptreact = { "biome" },
                typescript = { "biome" },
                typescriptreact = { "biome" },
                json = { "biome" },
                jsonc = { "biome" },

                bash = { "shellharden", "shfmt" },
                css = { "prettierd", "rustywind" },
                html = { "prettierd", "rustywind" },
                htmldjango = { "djlint", "rustywind" },
                lua = { "stylua" },
                markdown = { "prettierd", "injected" },
                python = { "ruff_format" },
                yaml = { "prettierd" },
                zsh = { "shellharden", "shfmt" },
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
        vim.keymap.set("n", "<Leader>mf", "<CMD>ConformInfo<Enter>", { desc = "Formatter Info" })

        vim.api.nvim_create_user_command("Format", function() conform.format({ lsp_fallback = true }) end, {})
    end,
}
