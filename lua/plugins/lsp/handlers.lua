local M = {}

M.on_attach = function(client, _) -- client, bufnr
    -- print(vim.inspect(client.id))
    -- print(vim.inspect(client.name))
    -- print(vim.inspect(client.server_capabilities.semanticTokensProvider))
    local telescope = require("telescope.builtin")

    -- semantic tokens are laggier than treesitter only, and mess up my rust highlights. might be nice in lua tho?
    -- client.server_capabilities.semanticTokensProvider = nil
    vim.opt.formatexpr = ""

    vim.keymap.set("n", "<Leader>la", vim.lsp.buf.code_action, { buffer = true, desc = "Code Action" })
    vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.format, { buffer = true, desc = "Format" })
    vim.keymap.set("n", "<Leader>ll", vim.lsp.codelens.run, { buffer = true, desc = "CodeLens Action" })

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = true, desc = "" })
    vim.keymap.set("n", "gd", telescope.lsp_definitions, { buffer = true, desc = "" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = true, desc = "" })
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = true, desc = "" })
    vim.keymap.set("n", "gr", telescope.lsp_references, { buffer = true, desc = "" })

    local filter_f_symbols = { symbols = { "function", "method", "class" } }
    local filter_c_symbols = { symbols = { "constant" } }
    vim.keymap.set("n", "<Leader>lm", function()
        telescope.lsp_dynamic_workspace_symbols(filter_f_symbols)
    end, { buffer = true, desc = "Workspace Methods" })
    vim.keymap.set("n", "<Leader>lc", function()
        telescope.lsp_dynamic_workspace_symbols(filter_c_symbols)
    end, { buffer = true, desc = "Workspace Constants" })

    vim.keymap.set("n", "<Leader>ls", telescope.lsp_document_symbols, { buffer = true, desc = "Document Symbols" })
    vim.keymap.set(
        "n",
        "<Leader>lw",
        telescope.lsp_dynamic_workspace_symbols,
        { buffer = true, desc = "Workspace Symbols" }
    )
    vim.keymap.set("n", "<Leader>ld", function()
        telescope.diagnostics({ bufnr = 0 })
    end, { buffer = true, desc = "Document Diagnostics" })
    vim.keymap.set("n", "<Leader>lD", telescope.diagnostics, { buffer = true, desc = "Workspace Diagnostics" })

    vim.keymap.set("n", "<Leader>lh", vim.show_pos, { desc = "Inspect Semantic Highlight" })
end

return M
