return {
    "mfussenegger/nvim-lint",
    lazy = false, -- Needed for autocommand triggering on first BufEnter

    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            bash = { "shellcheck" },
            dockerfile = { "hadolint" },
            go = { "golangcilint" },
            -- htmldjango = { "djlint" },
            lua = { "selene" },
            -- markdown = { "markdownlint" },
            zsh = { "zsh" },
        }

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
            callback = function() lint.try_lint() end,
        })
    end,
}
