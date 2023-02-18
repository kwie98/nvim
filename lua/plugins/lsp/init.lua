return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "folke/neodev.nvim",
            "simrat39/rust-tools.nvim",
            "barreiroleo/ltex_extra.nvim", -- in ltex config
            "b0o/SchemaStore.nvim", -- in jsonls config
            {
                "hrsh7th/cmp-nvim-lsp",
                cond = function()
                    return require("lazy.core.config").plugins["nvim-cmp"] ~= nil
                end,
            },
        },
        event = { "BufReadPre", "BufNewFile" },
        -- event = "VeryLazy",

        config = function()
            local mason = require("mason")
            local index = require("mason-registry.index")
            local mason_lspconfig = require("mason-lspconfig")
            local lspconfig = require("lspconfig")
            local handlers = require("plugins.lsp.handlers")
            local neodev = require("neodev")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            vim.keymap.set("n", "<Leader>L", "<CMD>LspInfo<CR>", { desc = "LSP" })
            vim.keymap.set("n", "<Leader>M", "<CMD>Mason<CR>", { desc = "Mason" })

            neodev.setup({
                setup_jsonls = false,
            })

            -- Add custom pydocstyle package
            index["pydocstyle[toml]"] = "plugins.lsp.packages.pydocstyle-toml"

            mason.setup({
                ui = {
                    border = vim.g.big_border,
                    keymaps = {
                        apply_language_filter = "f",
                    },
                },
            })

            mason_lspconfig.setup()

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
            -- auto setup installed LSPs:
            mason_lspconfig.setup_handlers({
                function(server) -- default handler (optional)
                    local opts = {
                        on_attach = handlers.on_attach,
                        capabilities = capabilities,
                    }
                    -- use custom configurations from the settings folder:
                    local has_custom_opts, server_custom_opts = pcall(require, "plugins.lsp.configs." .. server)
                    if has_custom_opts then
                        opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
                    end
                    lspconfig[server].setup(opts)
                end,
                ["rust_analyzer"] = function()
                    local rust_tools = require("rust-tools")
                    rust_tools.setup({
                        tools = {
                            inlay_hints = {
                                show_parameter_hints = false,
                            },
                        },
                        server = {
                            on_attach = function(client, bufnr)
                                handlers.on_attach(client, bufnr)
                                -- Hover actions
                                vim.keymap.set(
                                    "n",
                                    "K",
                                    rust_tools.hover_actions.hover_actions,
                                    { buffer = bufnr, desc = "Hover Actions" }
                                )
                                -- Code action groups
                                vim.keymap.set(
                                    "n",
                                    "<Leader>lA",
                                    rust_tools.code_action_group.code_action_group,
                                    { buffer = bufnr, desc = "Code Action Group" }
                                )
                            end,
                        },
                    })
                end,
            })

            local signs = {
                { name = "DiagnosticSignError", text = "" },
                { name = "DiagnosticSignWarn",  text = "" },
                { name = "DiagnosticSignHint",  text = "" },
                { name = "DiagnosticSignInfo",  text = "" },
            }

            for _, sign in ipairs(signs) do
                vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
            end

            local config = {
                virtual_text = { spacing = 4, prefix = "●" },

                -- show signs
                signs = {
                    active = signs,
                    priority = 1,
                },
                update_in_insert = false,
                underline = true,
                severity_sort = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = vim.g.small_border,
                    source = "always",
                    header = "",
                    prefix = "",
                },
            }

            vim.diagnostic.config(config)

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = vim.g.small_border,
                -- width = 60,
            })

            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = vim.g.small_border,
                -- width = 60,
            })
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        -- event = { "BufReadPre", "BufNewFile" },
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
        },

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
                debug = false,
                on_attach = handlers.on_attach,
                sources = {
                    formatting.black.with({
                        extra_args = { "--fast", "--line-length", "120" },
                        cwd = root_finder,
                        runtime_condition = not_conda_or_fugitive,
                    }),
                    formatting.latexindent.with({
                        extra_args = { "-l", "indentconfig.yaml" },
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
                },
            })
        end,
    },
}
