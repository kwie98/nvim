return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "folke/neodev.nvim",
        "simrat39/rust-tools.nvim",
        -- "barreiroleo/ltex_extra.nvim", -- in ltex config
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

        local neodev = require("neodev")
        local rt = require("rust-tools")

        vim.keymap.set("n", "<Leader>ml", "<CMD>LspInfo<Enter>", { desc = "LSP Info" })

        -- IMPORTANT: make sure to set up neodev BEFORE lspconfig
        neodev.setup({
            setup_jsonls = false,
        })

        local function setup_lsp(server)
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_nvim_lsp.default_capabilities()
            )
            -- Enable folding for nvim-ufo:
            -- capabilities.textDocument.foldingRange = {
            --     dynamicRegistration = false,
            --     lineFoldingOnly = true,
            -- }
            local lsp_conf = {
                on_attach = handlers.on_attach,
                capabilities = capabilities,
            }
            -- Use per-server custom configs from the configs folder:
            local has_custom_conf, custom_conf = pcall(require, "plugins.lsp.configs." .. server)
            if has_custom_conf then lsp_conf = vim.tbl_deep_extend("force", lsp_conf, custom_conf) end
            -- local filename = "/tmp/yo_nvim_" .. server .. ".txt"
            -- local tmp_handle = io.open(filename, "w")
            -- tmp_handle:write(vim.inspect(lsp_conf))
            -- tmp_handle:close()
            -- print("Wrote to " .. filename)
            lspconfig[server].setup(lsp_conf)
        end

        -- Set up Mason's LSPs:
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
            },
            server = {
                cmd = { "rustup", "run", "stable", "rust-analyzer" },
                on_attach = function(client, bufnr) handlers.on_attach(client, bufnr) end,
            },
        })
    end,
}
