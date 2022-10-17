local function setup(mason, index, mason_lspconfig, lspconfig)
    -- Add custom pydocstyle package
    index["pydocstyle[toml]"] = "core.mason.pydocstyle-toml"

    mason.setup({
        ui = {
            border = U.big_border,
        },
    })

    mason_lspconfig.setup()

    -- auto setup installed LSPs(?)
    mason_lspconfig.setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server) -- default handler (optional)
            local opts = {
                on_attach = require("core.lsp.handlers").on_attach,
                capabilities = require("core.lsp.handlers").capabilities,
            }
            local has_custom_opts, server_custom_opts = pcall(require, "core.lsp.settings." .. server)
            if has_custom_opts then
                opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
            end
            lspconfig[server].setup(opts)
        end,
        -- Next, you can provide targeted overrides for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        -- ["rust_analyzer"] = function()
        --     require("rust-tools").setup({})
        -- end,
    })
end

U.load({ "mason", "mason-registry.index", "mason-lspconfig", "lspconfig" }, setup)
