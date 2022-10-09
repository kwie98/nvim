local status_ok, mason = pcall(require, "mason")
if not status_ok then
    print("Could not load mason.")
    return
end

local index = require("mason-registry.index")

local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
    print("Could not load mason-lspconfig.")
    return
end

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    print("Could not load lspconfig.")
    return
end

index["pydocstyle"] = "core.mason.pydocstyle"

mason.setup({
    ui = {
        border = U.big_border,
    },
})

-- -- manually install pydocstyle with toml support
-- Pkg.new({
--     name = "pydocstyle-toml",
--     desc = "pydocstyle is a static analysis tool for checking compliance with Python docstring conventions",
--     homepage = "https://www.pydocstyle.org/",
--     languages = { Pkg.Lang.Python },
--     categories = { Pkg.Cat.Linter },
--     install = pip3.packages({ "pydocstyle[toml]", bin = { "pydocstyle" } }),
-- }):uninstall()

mason_lspconfig.setup()

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

-- local servers = mason_lspconfig.get_installed_servers()
-- for _, server in pairs(servers) do
--     local opts = {
--         on_attach = require("core.lsp.handlers").on_attach,
--         capabilities = require("core.lsp.handlers").capabilities,
--     }
--     local has_custom_opts, server_custom_opts = pcall(require, "core.lsp.settings." .. server)
--     if has_custom_opts then
--         opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
--     end
--     lspconfig[server].setup(opts)
-- end
