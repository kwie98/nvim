local function setup(mason, index, mason_lspconfig, lspconfig)
    -- Add custom pydocstyle package
    index["pydocstyle[toml]"] = "core.mason.pydocstyle-toml"

    mason.setup({
        ui = {
            border = U.big_border,
            keymaps = {
                apply_language_filter = "f",
            },
        },
    })

    mason_lspconfig.setup()

    -- auto setup installed LSPs:
    mason_lspconfig.setup_handlers({
        function(server) -- default handler (optional)
            local opts = {
                on_attach = require("core.lsp.handlers").on_attach,
                capabilities = require("core.lsp.handlers").capabilities,
            }
            -- use custom configurations from the settings folder:
            local has_custom_opts, server_custom_opts = pcall(require, "core.lsp.settings." .. server)
            if has_custom_opts then
                opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
            end
            lspconfig[server].setup(opts)
        end,
    })
end

U.load({ "mason", "mason-registry.index", "mason-lspconfig", "lspconfig" }, setup)
