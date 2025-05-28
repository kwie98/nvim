return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "b0o/SchemaStore.nvim", -- in jsonls config
        "hrsh7th/cmp-nvim-lsp",
    },
    event = { "BufReadPost", "BufNewFile" },
    enabled = vim.fn.has("win32") == 0,

    config = function()
        local mason_lspconfig = require("mason-lspconfig")
        local lspconfig = require("lspconfig")
        local handlers = require("plugins.lsp.handlers")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local function setup_lsp(server)
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_nvim_lsp.default_capabilities()
            )
            local lsp_conf = {
                on_attach = handlers.on_attach,
                capabilities = capabilities,
            }
            -- Use per-server custom configs from the configs folder:
            local has_custom_conf, custom_conf = pcall(require, "plugins.lsp.configs." .. server)
            if has_custom_conf then lsp_conf = vim.tbl_deep_extend("force", lsp_conf, custom_conf) end
            lspconfig[server].setup(lsp_conf)
        end

        mason_lspconfig.setup({ automatic_enable = false })

        setup_lsp("hls")
        setup_lsp("clangd")
        setup_lsp("lua_ls")
        setup_lsp("gopls")
        setup_lsp("biome")
        setup_lsp("ts_ls")
        setup_lsp("ruff")
        setup_lsp("taplo")
        setup_lsp("yamlls")
        setup_lsp("bashls")
        setup_lsp("rust_analyzer")
        setup_lsp("cssls")
        setup_lsp("basedpyright")
        setup_lsp("dockerls")
        setup_lsp("emmet_language_server")
        setup_lsp("html")
        setup_lsp("jsonls")
        setup_lsp("markdown_oxide")
        setup_lsp("taplo")
        setup_lsp("nushell")
    end,
}
