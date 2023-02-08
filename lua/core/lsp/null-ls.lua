U.load({ "null-ls", "null-ls.utils" }, function(null_ls, null_ls_utils)
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    local function root_finder()
        return null_ls_utils.root_pattern(".git")(vim.fn.expand("%:p"))
    end

    local function not_conda_or_fugitive()
        -- needed because mypy does not like code from packages and this stuff is not needed in fugitive (except for
        -- gitlint).
        local cur_path = vim.fn.expand("%:p")
        return cur_path:find("/data/conda/") == nil and cur_path:find("fugitive:") == nil
    end

    vim.api.nvim_create_user_command("NullLsStop", function()
        null_ls.disable({})
    end, {})

    vim.api.nvim_create_user_command("NullLsStart", function()
        null_ls.enable({})
    end, {})

    null_ls.setup({
        -- border = u.big_border, -- not supported yet
        debug = false,
        on_attach = require("core.lsp.handlers").on_attach,
        sources = {
            -- working
            formatting.black.with({
                extra_args = { "--fast", "--line-length", "120" },
                cwd = root_finder,
                runtime_condition = not_conda_or_fugitive,
            }),
            formatting.latexindent.with({
                extra_args = {"-l", "indentconfig.yaml"},
                cwd = root_finder,
                runtime_condition = not_conda_or_fugitive,
            }),
            formatting.stylua.with({
                extra_args = { "--indent-type=Spaces" },
                runtime_condition = not_conda_or_fugitive,
            }),
            formatting.markdownlint.with({
                cwd = root_finder,
                runtime_condition = not_conda_or_fugitive,
            }),
            formatting.isort.with({
                cwd = root_finder,
                runtime_condition = not_conda_or_fugitive,
            }),
            formatting.prettierd.with({
                filetypes = { "yaml" },
                runtime_condition = not_conda_or_fugitive,
            }),
            -- breaks code block bg highlighting?
            diagnostics.markdownlint.with({
                cwd = root_finder,
                runtime_condition = not_conda_or_fugitive,
            }),
            -- diagnostics.flake8.with({
            --     extra_args = { "--max-line-length", "120" },
            --     cwd = root_finder,
            -- }), TODO disabled for now because pyright finds all of this anyways?
            -- diagnostics.codespell.with({
            --     disabled_filetypes = { "markdown" },
            --     runtime_condition = not_conda_or_fugitive,
            -- }),
            diagnostics.gitlint,
            diagnostics.selene.with({
                cwd = root_finder,
                runtime_condition = not_conda_or_fugitive,
            }),
            -- diagnostics.mypy.with({
            --     extra_args = {
            --         "--python-executable=python", -- use env python
            --         "--namespace-packages", -- find stuff where __init__.py file is missing
            --     },
            --     cwd = root_finder,
            --     method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
            --     runtime_condition = not_conda_or_fugitive,
            -- }),
            diagnostics.pydocstyle.with({
                cwd = root_finder,
                runtime_condition = not_conda_or_fugitive,
            }),

            -- to test
            -- diagnostics.chktex,
        },
    })
end)
