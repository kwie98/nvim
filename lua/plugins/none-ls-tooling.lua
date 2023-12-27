return {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim" },
    enabled = vim.fn.has("win32") == 0,

    config = function()
        local null_ls = require("null-ls")
        local null_ls_utils = require("null-ls.utils")
        local code_actions = null_ls.builtins.code_actions
        local diagnostics = null_ls.builtins.diagnostics
        local handlers = require("plugins.lsp.handlers")

        vim.keymap.set("n", "<Leader>N", "<CMD>NullLsInfo<Enter>", { desc = "Null LS" })

        local function root_finder() return null_ls_utils.root_pattern(".git")(vim.fn.expand("%:p")) end

        local function not_conda_or_fugitive()
            -- Needed because mypy does not like code from packages and this stuff is not needed in fugitive (except
            -- for gitlint).
            local cur_path = vim.fn.expand("%:p")
            return cur_path:find("/data/conda/") == nil and cur_path:find("fugitive:") == nil
        end

        vim.api.nvim_create_user_command("NullLsStop", function() null_ls.disable({}) end, {})
        vim.api.nvim_create_user_command("NullLsStart", function() null_ls.enable({}) end, {})

        null_ls.setup({
            debug = false,
            on_attach = handlers.on_attach,
            sources = {
                -- C++:
                diagnostics.clang_check.with({ runtime_condition = not_conda_or_fugitive }),
                diagnostics.cpplint.with({ runtime_condition = not_conda_or_fugitive }),

                -- Docker:
                diagnostics.hadolint,

                -- Git:
                diagnostics.gitlint,
                diagnostics.selene.with({ runtime_condition = not_conda_or_fugitive, cwd = root_finder }),

                -- Sh, Bash, Zsh:
                code_actions.shellcheck.with({ runtime_condition = not_conda_or_fugitive, extra_filetypes = { "zsh" } }),
                diagnostics.shellcheck.with({ runtime_condition = not_conda_or_fugitive, extra_filetypes = { "zsh" } }),

                -- YAML:
                diagnostics.actionlint,
            },
        })
    end,
}
