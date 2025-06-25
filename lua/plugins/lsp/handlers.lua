local M = {}

M.on_attach = function(_, _) -- client, bufnr
    -- print(vim.inspect(client.id))
    -- print(vim.inspect(client.name))
    -- print(vim.inspect(client.server_capabilities.semanticTokensProvider))
    local telescope = require("telescope.builtin")

    -- Semantic tokens are laggier than treesitter only, and mess up my rust highlights. might be nice in lua tho?
    -- client.server_capabilities.semanticTokensProvider = nil
    -- vim.opt.formatexpr = ""

    -- vim.keymap.set("n", "<Leader>la", vim.lsp.buf.code_action, { buffer = true, desc = "Code Action" })
    vim.keymap.set("n", "<Leader>ll", vim.lsp.codelens.run, { buffer = true, desc = "CodeLens Action" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = true, desc = "Goto Declaration" })
    vim.keymap.set("n", "gd", telescope.lsp_definitions, { buffer = true, desc = "Goto Definition" })
    vim.keymap.set("n", "gI", telescope.lsp_implementations, { buffer = true, desc = "Goto Implementation" })
    vim.keymap.set("n", "gri", telescope.lsp_implementations, { buffer = true, desc = "Goto Implementation" })
    vim.keymap.set("n", "grr", telescope.lsp_references, { buffer = true, desc = "Goto References" })
    vim.keymap.set("n", "gO", telescope.lsp_document_symbols, { buffer = true, desc = "Document symbols" })

    vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { buffer = true, desc = "Signature Help" })
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = true, desc = "Signature Help" })
    vim.keymap.set("n", "gt", telescope.lsp_type_definitions, { buffer = true, desc = "Goto Type Definition" })
    -- Meta:
    vim.keymap.set("n", "<Leader>ml", "<CMD>LspInfo<Enter>", { buffer = true, desc = "LSP Info" })
    vim.keymap.set("n", "<Leader>lr", vim.cmd.LspRestart, { buffer = true, desc = "Restart LSP" })

    local filter_f_symbols = { symbols = { "function", "method", "class" } }
    vim.keymap.set(
        "n",
        "<Leader>lm",
        function() telescope.lsp_dynamic_workspace_symbols(filter_f_symbols) end,
        { buffer = true, desc = "Workspace Methods" }
    )
    -- local filter_c_symbols = { symbols = { "constant" } }
    -- vim.keymap.set("n", "<Leader>lc", function()
    --     telescope.lsp_dynamic_workspace_symbols(filter_c_symbols)
    -- end, { buffer = true, desc = "Workspace Constants" })

    vim.keymap.set(
        "n",
        "<Leader>ls",
        telescope.lsp_dynamic_workspace_symbols,
        { buffer = true, desc = "Workspace Symbols" }
    )
    vim.keymap.set("n", "<Leader>ld", telescope.diagnostics, { buffer = true, desc = "Workspace Diagnostics" })
end

return M
