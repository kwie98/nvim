-- return {
--     "neovim/nvim-lspconfig",
--     dependencies = {
--         "hrsh7th/nvim-cmp",
--     },
--     config = function()
--         local lspconfig = require("lspconfig")
--         local capabilities = require("cmp_nvim_lsp").default_capabilities()
--         lspconfig.pylyzer.setup({ capabilities = capabilities })
--         lspconfig.ruff.setup({ capabilities = capabilities })
--         lspconfig.lua_ls.setup({
--             capabilities = capabilities,
--             on_init = function(client)
--                 if client.workspace_folders then
--                     local path = client.workspace_folders[1].name
--                     if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
--                         return
--                     end
--                 end
--
--                 client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
--                     runtime = {
--                         version = "LuaJIT",
--                     },
--                     workspace = {
--                         checkThirdParty = false,
--                         library = vim.api.nvim_get_runtime_file("", true),
--                     },
--                 })
--             end,
--             settings = {
--                 Lua = {},
--             },
--         })
--     end,
-- }
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        -- "folke/neodev.nvim",
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

        -- local neodev = require("neodev")
        -- local rt = require("rust-tools")

        -- -- IMPORTANT: make sure to set up neodev BEFORE lspconfig
        -- neodev.setup({
        --     setup_jsonls = false,
        -- })

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
        setup_lsp("lua_ls")
        setup_lsp("gopls")
        setup_lsp("biome")
        setup_lsp("ts_ls")
        setup_lsp("ruff")
        setup_lsp("taplo")
        setup_lsp("yamlls")
        setup_lsp("bashls")
        setup_lsp("rust_analyzer")

        -- rt.setup({
        --     tools = {
        --         inlay_hints = {
        --             show_parameter_hints = false,
        --         },
        --     },
        --     server = {
        --         cmd = { "rustup", "run", "stable", "rust-analyzer" },
        --         on_attach = function(client, bufnr) handlers.on_attach(client, bufnr) end,
        --     },
        -- })
    end,
}
