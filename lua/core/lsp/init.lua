local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    print("Could not load lspconfig.")
    return
end

require("core.lsp.configs")
require("core.lsp.handlers").setup()
require("core.lsp.null-ls")
