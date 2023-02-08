local mason = require("mason")
local index = require("mason-registry.index")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local handlers = require("lsp-configs.handlers")

-- Add custom pydocstyle package
index["pydocstyle[toml]"] = "mason-packages.pydocstyle-toml"

mason.setup({
    ui = {
        border = vim.g.big_border,
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
            on_attach = handlers.on_attach,
            capabilities = handlers.capabilities,
        }
        -- use custom configurations from the settings folder:
        local has_custom_opts, server_custom_opts = pcall(require, "lsp-configs." .. server)
        if has_custom_opts then
            opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
        end
        lspconfig[server].setup(opts)
    end,
})

local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
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
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = vim.g.small_border,
    -- width = 60,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = vim.g.small_border,
    -- width = 60,
})
