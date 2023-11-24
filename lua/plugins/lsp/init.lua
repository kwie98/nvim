return {
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
}
