return {
    "stevearc/conform.nvim",
    event = "VeryLazy",

    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "prettier" },
                jsonc = { "prettier" },
                css = { "prettier" },

                sh = { "shellharden", "shfmt" },
                zsh = { "shellharden", "shfmt" },

                lua = { "stylua" },
                python = { "ruff_format" },
                rust = { "rustfmt" },

                markdown = { "prettier", "injected" },
                yaml = { "prettier" },
                -- nix = { "nixfmt" },
            },
        })

        vim.keymap.set("n", "=", function()
            local success = conform.format()
            if not success then vim.fn.feedkeys("=", "n") end
        end, { desc = "Format" })
        vim.keymap.set("x", "=", function()
            local success = conform.format()
            if not success then vim.fn.feedkeys("=", "n") end
        end, { desc = "Format Range" })
        vim.keymap.set("n", "<Leader>mf", "<CMD>ConformInfo<Enter>", { desc = "Formatter Info" })

        vim.api.nvim_create_user_command("Format", function() conform.format({ lsp_fallback = true }) end, {})
    end,
}
