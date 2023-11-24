return {
    {
        "williamboman/mason.nvim",
        lazy = true,
        enabled = vim.fn.has("win32") == 0,

        config = function()
            local mason = require("mason")
            local m_ui = require("mason.ui")

            vim.keymap.set("n", "<Leader>M", m_ui.open, { desc = "Mason" })

            mason.setup({
                PATH = "skip",
                ui = {
                    border = vim.g.big_border,
                    keymaps = {
                        apply_language_filter = "f",
                    },
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "folke/neodev.nvim",
            "simrat39/rust-tools.nvim",
            "barreiroleo/ltex_extra.nvim", -- in ltex config
            "b0o/SchemaStore.nvim", -- in jsonls config
            {
                "hrsh7th/cmp-nvim-lsp",
            },
        },
        event = { "BufReadPre", "BufNewFile" },
        enabled = vim.fn.has("win32") == 0,

        config = function()
            local mason_lspconfig = require("mason-lspconfig")
            local lspconfig = require("lspconfig")
            local handlers = require("plugins.lsp.handlers")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            local neodev = require("neodev")
            local rt = require("rust-tools")

            vim.keymap.set("n", "<Leader>L", "<CMD>LspInfo<CR>", { desc = "LSP Info" })

            -- IMPORTANT: make sure to set up neodev BEFORE lspconfig
            neodev.setup({
                setup_jsonls = false,
            })

            local function setup_lsp(server)
                -- Default config:
                local lsp_conf = {
                    on_attach = handlers.on_attach,
                    capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
                }
                -- Use per-server custom configs from the configs folder:
                local has_custom_conf, custom_conf = pcall(require, "plugins.lsp.configs." .. server)
                if has_custom_conf then
                    lsp_conf = vim.tbl_deep_extend("force", lsp_conf, custom_conf)
                end
                lspconfig[server].setup(lsp_conf)
            end

            -- Auto set up Mason's LSPs:
            mason_lspconfig.setup()
            mason_lspconfig.setup_handlers({ setup_lsp })

            -- Set up other LSPs:
            setup_lsp("hls")
            setup_lsp("clangd")

            rt.setup({
                tools = {
                    inlay_hints = {
                        show_parameter_hints = false,
                    },
                    hover_actions = {
                        border = vim.g.small_border,
                    },
                },
                server = {
                    cmd = { "rustup", "run", "stable", "rust-analyzer" },
                    on_attach = function(client, bufnr)
                        handlers.on_attach(client, bufnr)
                        -- Hover actions
                        vim.keymap.set(
                            "n",
                            "K",
                            rt.hover_actions.hover_actions,
                            { buffer = bufnr, desc = "Hover Actions" }
                        )
                        -- Code action groups
                        vim.keymap.set(
                            "n",
                            "<Leader>lA",
                            rt.code_action_group.code_action_group,
                            { buffer = bufnr, desc = "Code Action Group" }
                        )
                    end,
                },
            })

            local signs = {
                { name = "DiagnosticSignError", text = "" },
                { name = "DiagnosticSignWarn", text = "" },
                { name = "DiagnosticSignHint", text = "" },
                { name = "DiagnosticSignInfo", text = "" },
            }
            for _, sign in ipairs(signs) do
                vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
            end

            -- Diagnostic settings:
            vim.diagnostic.config({
                virtual_text = false,
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
            })
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = vim.g.small_border,
            })
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = vim.g.small_border,
            })
        end,
    },
    {
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
    },
}
