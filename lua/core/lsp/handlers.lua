local M = {}

M.setup = function()
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
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "none",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "none",
        -- width = 60,
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "none",
        -- width = 60,
    })
end

local function lsp_keymaps()
    local opts = { buffer = true, noremap = true, silent = true }
    vim.keymap.set("n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.keymap.set("n", "gd", "<CMD>Telescope lsp_definitions theme=ivy<CR>", opts)
    vim.keymap.set("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", opts)
    vim.keymap.set("n", "gI", "<CMD>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.keymap.set("n", "gr", "<CMD>Telescope lsp_references theme=ivy<CR>", opts)
    vim.keymap.set("n", "[l", "<CMD>lua vim.diagnostic.goto_prev()<CR>", opts)
    vim.keymap.set("n", "gl", "<CMD>lua vim.diagnostic.open_float()<CR>", opts)
    vim.keymap.set("n", "]l", "<CMD>lua vim.diagnostic.goto_next()<CR>", opts)
end

M.on_attach = function(client, bufnr)
    lsp_keymaps()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
    print("Could not load cmp_nvim_lsp.")
    return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
