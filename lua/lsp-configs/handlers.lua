local cmp_nvim_lsp = require("cmp_nvim_lsp")

local M = {}

local function lsp_keymaps()
    local opts = { buffer = true, noremap = true, silent = true }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", "<CMD>Telescope lsp_definitions<CR>", opts)
    -- vim.keymap.set("n", "gd", "<CMD>Telescope lsp_definitions theme=ivy<CR>", opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", "<CMD>Telescope lsp_references<CR>", opts)
    -- vim.keymap.set("n", "gr", "<CMD>Telescope lsp_references theme=ivy<CR>", opts)
end

M.on_attach = function()
    vim.opt.formatexpr = ""
    lsp_keymaps()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
