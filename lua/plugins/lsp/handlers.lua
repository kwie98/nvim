local cmp_nvim_lsp = require("cmp_nvim_lsp")

local M = {}
local opts = { buffer = true, noremap = true, silent = true }

M.on_attach = function()
    local telescope = require("telescope.builtin")

    vim.opt.formatexpr = ""

    vim.keymap.set("n", "<Leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })
    vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.format, { desc = "Format" })
    vim.keymap.set("n", "<Leader>ll", vim.lsp.codelens.run, { desc = "CodeLens Action" })

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", telescope.lsp_references, opts)

    local filter_f_symbols = { symbols = { "function", "method", "class" } }
    local filter_c_symbols = { symbols = { "constant" } }
    vim.keymap.set("n", "<Leader>lm", function()
        telescope.lsp_dynamic_workspace_symbols(filter_f_symbols)
    end, { desc = "Workspace Methods" })
    vim.keymap.set("n", "<Leader>lc", function()
        telescope.lsp_dynamic_workspace_symbols(filter_c_symbols)
    end, { desc = "Workspace Constants" })

    vim.keymap.set("n", "<Leader>ls", telescope.lsp_document_symbols, { desc = "Document Symbols" })
    vim.keymap.set("n", "<Leader>lw", telescope.lsp_dynamic_workspace_symbols, { desc = "Workspace Symbols" })
    vim.keymap.set("n", "<Leader>ld", function()
        telescope.diagnostics({ bufnr = 0 })
    end, { desc = "Document Diagnostics" })
    vim.keymap.set("n", "<Leader>lD", telescope.diagnostics, { desc = "Workspace Diagnostics" })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
