return {
    "mfussenegger/nvim-lint",
    lazy = false, -- Needed for autocommand triggering on first BufEnter

    config = function()
        local lint = require("lint")
        local djlint_django = lint.linters.djlint
        djlint_django.args = {
            "--profile",
            "django",
            "--linter-output-format",
            "{line}:{code}: {message}",
            "-",
        }
        lint.linters.djlint_django = djlint_django

        lint.linters_by_ft = {
            bash = { "shellcheck" },
            dockerfile = { "hadolint" },
            htmldjango = { "djlint_django" },
            lua = { "selene" },
            markdown = { "markdownlint" },
            zsh = { "zsh" },
        }

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
            callback = function() lint.try_lint() end,
        })
    end,
}
