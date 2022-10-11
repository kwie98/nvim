local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
    print("Could not load null-ls.")
    return
end

local null_ls_utils = require("null-ls.utils")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    -- border = u.big_border, -- not supported yet
    debug = true,
    sources = {
        -- working
        formatting.black.with({
            extra_args = { "--fast", "--line-length", "120" },
            cwd = function()
                return null_ls_utils.root_pattern(".git")(vim.fn.expand("%:p"))
            end,
        }),
        formatting.stylua.with({ extra_args = { "--indent-type=Spaces" } }),
        formatting.markdownlint.with({
            cwd = function()
                return null_ls_utils.root_pattern(".git")(vim.fn.expand("%:p"))
            end,
        }),
        diagnostics.markdownlint.with({
            cwd = function()
                return null_ls_utils.root_pattern(".git")(vim.fn.expand("%:p"))
            end,
        }),
        -- diagnostics.flake8.with({
        --     extra_args = { "--max-line-length", "120" },
        --     cwd = function()
        --         return null_ls_utils.root_pattern(".git")(vim.fn.expand("%:p"))
        --     end,
        -- }), TODO disabled for now because pyright finds all of this anyways?
        diagnostics.codespell.with({
            -- disabled_filetypes = { "markdown" },
        }),
        diagnostics.gitlint,
        diagnostics.selene.with({
            cwd = function()
                return null_ls_utils.root_pattern(".git")(vim.fn.expand("%:p"))
            end,
        }),
        diagnostics.mypy.with({
            extra_args = {
                "--python-executable=python", -- use env python
                "--namespace-packages", -- find stuff where __init__.py file is missing
            },
            cwd = function()
                return null_ls_utils.root_pattern(".git")(vim.fn.expand("%:p"))
            end,
            runtime_condition = function()
                -- needed because mypy does not like code from packages
                local cur_path = vim.fn.expand("%:p")
                return cur_path:find("/data/conda/") == nil
            end,
        }),
        diagnostics.pydocstyle.with({
            cwd = function()
                return null_ls_utils.root_pattern(".git")(vim.fn.expand("%:p"))
            end,
        }),
        formatting.isort.with({
            cwd = function()
                return null_ls_utils.root_pattern(".git")(vim.fn.expand("%:p"))
            end,
        }),

        -- to test
        diagnostics.chktex,
    },
})
