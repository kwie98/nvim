local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    print("Could not load null-ls.")
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    debug = true,
    sources = {
        -- working
        formatting.black.with({
            extra_args = { "--fast", "--line-length", "120" },
            cwd = function()
                -- for some reason, black does not work when calling it from some directories?
                -- home works though :)
                return "/home/konrad"
            end,
        }),
        formatting.stylua.with({ extra_args = { "--indent-type=Spaces" } }),
        formatting.markdownlint,
        diagnostics.markdownlint,
        diagnostics.flake8.with({ extra_args = { "--max-line-length", "120" } }),
        diagnostics.codespell.with({
            -- disabled_filetypes = { "markdown" },
        }),
        -- diagnostics.luacheck.with({ extra_args = { "--globals", "vim" } }),
        diagnostics.selene,
        -- diagnostics.mypy,
        -- diagnostics.pydocstyle,
        formatting.isort,

        -- to test
        -- formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
        diagnostics.chktex,
    },
})
