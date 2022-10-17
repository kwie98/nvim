U.load({ "null-ls", "null-ls.utils" }, function(null_ls, null_ls_utils)
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    local function root_finder()
        return null_ls_utils.root_pattern(".git")(vim.fn.expand("%:p"))
    end

    null_ls.setup({
        -- border = u.big_border, -- not supported yet
        debug = true,
        on_attach = require("core.lsp.handlers").on_attach,
        sources = {
            -- working
            formatting.black.with({
                extra_args = { "--fast", "--line-length", "120" },
                cwd = root_finder,
            }),
            formatting.stylua.with({ extra_args = { "--indent-type=Spaces" } }),
            formatting.markdownlint.with({
                cwd = root_finder,
            }),
            diagnostics.markdownlint.with({
                cwd = root_finder,
            }),
            -- diagnostics.flake8.with({
            --     extra_args = { "--max-line-length", "120" },
            --     cwd = root_finder,
            -- }), TODO disabled for now because pyright finds all of this anyways?
            diagnostics.codespell.with({
                -- disabled_filetypes = { "markdown" },
            }),
            diagnostics.gitlint,
            diagnostics.selene.with({
                cwd = root_finder,
            }),
            diagnostics.mypy.with({
                extra_args = {
                    "--python-executable=python", -- use env python
                    "--namespace-packages", -- find stuff where __init__.py file is missing
                },
                cwd = root_finder,
                runtime_condition = function()
                    -- needed because mypy does not like code from packages
                    local cur_path = vim.fn.expand("%:p")
                    return cur_path:find("/data/conda/") == nil
                end,
            }),
            diagnostics.pydocstyle.with({
                cwd = root_finder,
            }),
            formatting.isort.with({
                cwd = root_finder,
            }),

            -- to test
            diagnostics.chktex,
        },
    })
end)
