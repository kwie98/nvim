U.load({ "null-ls", "null-ls.utils" }, function(null_ls, null_ls_utils)
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    local function root_finder()
        return null_ls_utils.root_pattern(".git")(vim.fn.expand("%:p"))
    end

    vim.api.nvim_create_user_command("NullLsStop", function()
        null_ls.disable({})
    end, {})

    vim.api.nvim_create_user_command("NullLsStart", function()
        null_ls.enable({})
    end, {})

    null_ls.setup({
        -- border = u.big_border, -- not supported yet
        debug = true,
        on_attach = require("core.lsp.handlers").on_attach,
        sources = {
            -- working
            formatting.black.with({
                -- extra_args = { "--fast", "--line-length", "120" },
                extra_args = { "--fast" },
                cwd = root_finder,
            }),
            formatting.stylua.with({ extra_args = { "--indent-type=Spaces" } }),
            formatting.markdownlint.with({
                cwd = root_finder,
            }),
            formatting.isort.with({
                cwd = root_finder,
            }),
            formatting.prettierd.with({
                filetypes = { "yaml" },
            }),
            -- breaks code block bg highlighting?
            diagnostics.markdownlint.with({
                cwd = root_finder,
            }),
            -- diagnostics.flake8.with({
            --     extra_args = { "--max-line-length", "120" },
            --     cwd = root_finder,
            -- }), TODO disabled for now because pyright finds all of this anyways?
            diagnostics.codespell.with({
                disabled_filetypes = { "markdown" },
            }),
            diagnostics.gitlint,
            diagnostics.selene.with({
                cwd = root_finder,
            }),
            diagnostics.mypy.with({
                extra_args = {
                    -- NOTE: Probably nicer to have mypy installed either by conda or globally, so that we can use the
                    -- stubgen module
                    -- "--python-executable=python", -- use the python that has all the packages
                    "--namespace-packages", -- find stuff where __init__.py file is missing
                },
                timeout = -1, -- mypy can take really long sometimes
                method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
                cwd = root_finder,
                method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
                runtime_condition = function()
                    -- needed because mypy does not like code from packages
                    local cur_path = vim.fn.expand("%:p")
                    return cur_path:find("/data/conda/") == nil
                end,
            }),
            diagnostics.pydocstyle.with({
                cwd = root_finder,
            }),

            -- to test
            diagnostics.chktex,
        },
    })
end)
