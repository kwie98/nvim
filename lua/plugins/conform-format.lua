return {
    "stevearc/conform.nvim",
    event = "VeryLazy",

    config = function()
        local conform = require("conform")
        conform.formatters.rustywind_css = {
            command = "rustywind",
            args = { "--custom-regex", [[@apply ([_a-zA\.-Z0-9\-:\[\] ]+);]], "--stdin" },
        }
        conform.formatters.rustywind_htmldjango = {
            command = "rustywind",
            args = {
                "--custom-regex",
                "\\b(?:class(?:Name)*\\s*=\\s*[\"'])([{}_a-zA-Z0-9\\.\\s\\-:\\[\\]/]+)[\"']",
                "--stdin",
            },
        }

        conform.setup({
            formatters_by_ft = {
                javascript = { "prettierd" },
                typescript = { "prettierd" },

                sh = { "shellharden", "shfmt" },
                css = { "prettierd", "rustywind_css" },
                html = { "prettierd", "rustywind" },
                htmldjango = { "djlint", "rustywind_htmldjango" },
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
