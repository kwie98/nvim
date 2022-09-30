local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    print("Could not load nvim-lsp-installer.")
    return
end

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    print("Could not load lspconfig.")
    return
end

local servers = { "jsonls", "sumneko_lua", "pyright", "yamlls", "marksman" }

lsp_installer.setup({
    ensure_installed = servers,
})

for _, server in pairs(servers) do
    local opts = {
        on_attach = require("core.lsp.handlers").on_attach,
        capabilities = require("core.lsp.handlers").capabilities,
    }
    local has_custom_opts, server_custom_opts = pcall(require, "core.lsp.settings." .. server)
    if has_custom_opts then
        opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
    end
    lspconfig[server].setup(opts)
end
