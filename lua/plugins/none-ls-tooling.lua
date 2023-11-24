return {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    dependencies = {
        "williamboman/mason.nvim", -- load after mason so that used binaries are available on the path
    },
    enabled = vim.fn.has("win32") == 0,

    config = function()
        local null_ls = require("null-ls")
        local null_ls_utils = require("null-ls.utils")
        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics
        local handlers = require("plugins.lsp.handlers")

        vim.keymap.set("n", "<Leader>N", "<CMD>NullLsInfo<CR>", { desc = "Null LS" })

        local function root_finder()
            return null_ls_utils.root_pattern(".git")(vim.fn.expand("%:p"))
        end

        local function not_conda_or_fugitive()
            -- Needed because mypy does not like code from packages and this stuff is not needed in fugitive (except
            -- for gitlint).
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
            debug = false,
            on_attach = handlers.on_attach,
            sources = {
                formatting.black.with({
                    extra_args = { "--fast" },
                    cwd = root_finder,
                    runtime_condition = not_conda_or_fugitive,
                }),
                formatting.latexindent.with({
                    extra_args = { "-l", "indentconfig.yaml" },
                    cwd = root_finder,
                    runtime_condition = not_conda_or_fugitive,
                }),
                formatting.stylua.with({
                    runtime_condition = not_conda_or_fugitive,
                }),
                formatting.prettierd.with({
                    -- Handled by biome:
                    disabled_filetypes = { "javascript", "javascriptreact", "typescript", "json", "jsonc" },
                    runtime_condition = not_conda_or_fugitive,
                }),

                diagnostics.gitlint,
                diagnostics.selene.with({
                    cwd = root_finder,
                    runtime_condition = not_conda_or_fugitive,
                }),
                diagnostics.cpplint.with({
                    runtime_condition = not_conda_or_fugitive,
                }),
                diagnostics.clang_check.with({
                    runtime_condition = not_conda_or_fugitive,
                }),
            },
        })
    end,
}
